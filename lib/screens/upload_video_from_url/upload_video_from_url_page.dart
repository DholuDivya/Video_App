import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_state.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_event.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_state.dart';
import 'package:vimeo_clone/config/colors.dart';

import '../../bloc/select_cat_for_video_detail/category_selection_bloc.dart';
import '../../bloc/select_cat_for_video_detail/category_selection_event.dart';
import '../../bloc/select_cat_for_video_detail/category_selection_state.dart';
import '../../bloc/video_category/video_category_bloc.dart';
import '../../bloc/video_category/video_category_state.dart';
import '../../config/constants.dart';
import '../../utils/widgets/toggle_button.dart';

class UploadVideoFromUrlPage extends StatefulWidget {
  const UploadVideoFromUrlPage({super.key});

  @override
  State<UploadVideoFromUrlPage> createState() => _UploadVideoFromUrlPageState();
}

class _UploadVideoFromUrlPageState extends State<UploadVideoFromUrlPage> {

  bool isCommentOn = true;
  final TextEditingController _hashtagController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();
  List<String> _hashtags = [];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final String urlPattern = r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$";



  File? _thumbnail;

  Future<void> getThumbnail() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Specify the file type to image
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _thumbnail = File(result.files.single.path!);
        });
        // Print the image path to the console
        print('Image path to be stored in database: ${_thumbnail!.path}');
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  void _extractHashtags(String text) {
    final RegExp hashtagRegExp = RegExp(r'\B#\w\w+');
    final Iterable<RegExpMatch> matches = hashtagRegExp.allMatches(text);
    setState(() {
      _hashtags = matches.map((match) => match.group(0)!).toList();
    });
  }

  @override
  void dispose() {
    _hashtagController.dispose();
    super.dispose();
  }


  String selectedVisibility = '';

  final List visibility = [
    {"type": "public"},
    {"type": "private"}
  ];


  String? _validateVideoUrl(String? value){
    if(value == null || value.isEmpty){
      return "Please enter Video URL !";
    }
    RegExp regExp = RegExp(urlPattern);
    if(regExp.hasMatch(value)){
      return "Invalid Video URL";
    }
  }


  String? _validateTitle(String? value){
    if(value == null || value.isEmpty){
      return "Please enter Title !";
    }
    return null;
  }

  String? _validateDescription(String? value){
    if(value == null || value.isEmpty){
      return "Please enter Description !";
    }
    return null;
  }

  String? _validateCategory(String? value){
    if(value == null || value.isEmpty){
      return "Please select Category !";
    }
    return null;
  }

  String? _validateVisibility(String? value){
    if(value == null || value.isEmpty){
      return "Please select Visibility !";
    }
    return null;
  }

  late CroppedFile finalThumbnail;
  List<int> selectedCategoryIds = [];
  late String selectedCategoryNames;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add details',
          style: TextStyle(
            fontFamily: fontFamily,
            // fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),


                TextFormField(
                  controller: _videoUrlController,
                  // validator: _validateVideoUrl,
                  // keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'https://www.example.com/',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.secondaryFixedDim
                    ),
                    labelText: 'Video URL...',
                    labelStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).colorScheme.secondaryFixedDim
                    ),

                    // floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceDim,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: blue,
                          width: 2.0
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),


                BlocBuilder<GetThumbnailBloc, GetThumbnailState>(
                    builder: (BuildContext context, state) {

                      if(state is GetThumbnailSuccess){
                        finalThumbnail = state.videoThumbnail!;

                        return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: FileImage(File(finalThumbnail!.path!))
                                    )
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                left: 10.h,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    // getThumbnail();
                                    context
                                        .read<GetThumbnailBloc>()
                                        .add(OpenFilesToGetThumbnail());
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      HeroiconsOutline.folderPlus,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      else if(state is GetThumbnailLoading){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: (){
                              context.read<GetThumbnailBloc>().add(OpenFilesToGetThumbnail());
                            },
                            child: DottedBorder(
                              color: Theme.of(context).colorScheme.secondaryFixedDim,
                              borderType: BorderType.RRect,
                              dashPattern: [4, 3],
                              radius: Radius.circular(15),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add thumbnail of your video',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryFixedDim),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    ClipRRect(

                                      // radius: 50,
                                      child: Container(
                                        height: 70.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Icon(
                                          HeroiconsOutline.plus,
                                          size: 25,
                                          color: Theme.of(context).colorScheme.secondaryFixedDim,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));

                    }),

                SizedBox(height: 20.h),

                TextFormField(
                  controller: _titleController,
                  validator: _validateTitle,
                  maxLength: 50,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    // hintText: ' Title... ',
                    labelText: 'Title...',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondaryFixedDim
                    ),

                    // floatingLabelStyle: TextStyle(
                    //
                    // ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceDim,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: blue,
                          width: 2.0
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
                TextFormField(
                  controller: _descriptionController,
                  validator: _validateDescription,
                  minLines: 3,
                  maxLines: 10,
                  maxLength: 200,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    // hintText: 'Description...',
                    labelText: 'Description...',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondaryFixedDim
                    ),
                    filled: true,
                    fillColor:Theme.of(context).colorScheme.surfaceDim,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: blue,
                          width: 2.0
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        // color: Colors.grey.shade200,
                          width: 2.0
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),



                // BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
                //   builder: (context, state) {
                //     if (state is VideoCategoriesLoading) {
                //       return Center(child: CircularProgressIndicator());
                //     } else if (state is VideoCategoriesLoaded) {
                //       return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                //         builder: (context, selectionState) {
                //
                //           if (selectionState is CategorySelected) {
                //             selectedCategoryIds = selectionState.selectedCategoryIds;
                //           }
                //
                //           // Get the names of the selected categories
                //           selectedCategoryNames = state.categories
                //               .where((category) => selectedCategoryIds.contains(category.id))
                //               .map((category) => category.name)
                //               .join(', ');
                //
                //           return GestureDetector(
                //             onTap: () {
                //               showDialog(
                //                 context: context,
                //                 builder: (context) {
                //                   return AlertDialog(
                //                     title: const Center(
                //                       child: Text(
                //                         'Select a category',
                //                         style: TextStyle(
                //                           fontFamily: fontFamily,
                //                           fontSize: 22,
                //                         ),
                //                       ),
                //                     ),
                //                     content: SizedBox(
                //                       width: 400.w,
                //                       child: ListView.builder(
                //                         shrinkWrap: true,
                //                         itemCount: state.categories.length,
                //                         itemBuilder: (context, index) {
                //                           final category = state.categories[index];
                //                           final isSelected = selectedCategoryIds.contains(category.id);
                //
                //                           return Container(
                //                             width: double.infinity,
                //                             child: InkWell(
                //                               borderRadius: BorderRadius.circular(15),
                //                               onTap: () {
                //                                 if (isSelected) {
                //                                   context.read<CategorySelectionBloc>().add(DeselectCategoryEvent(categoryId: category.id!));
                //                                 } else {
                //                                   context.read<CategorySelectionBloc>().add(SelectCategoryEvent(categoryId: category.id!));
                //                                 }
                //                                 Navigator.of(context).pop();
                //                               },
                //                               child: Container(
                //                                 alignment: Alignment.center,
                //                                 height: 40.h,
                //                                 width: double.infinity,
                //                                 decoration: BoxDecoration(
                //                                   borderRadius: BorderRadius.circular(15),
                //                                   color: isSelected
                //                                       ? Theme.of(context).colorScheme.tertiaryFixedDim
                //                                       : null,
                //                                 ),
                //                                 child: Text(
                //                                   '${category.name}',
                //                                   style: TextStyle(
                //                                     fontFamily: fontFamily,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           );
                //                         },
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               );
                //             },
                //             child: AbsorbPointer(
                //               child: Material(
                //                 borderRadius: BorderRadius.circular(10),
                //                 elevation: 2,
                //                 child: TextFormField(
                //                   // validator: _validateCategory,
                //                   decoration: InputDecoration(
                //                     filled: true,
                //                     fillColor: Theme.of(context).colorScheme.surfaceDim,
                //                     focusedBorder: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10),
                //                       borderSide: BorderSide(color: blue, width: 2.0),
                //                     ),
                //                     enabledBorder: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10),
                //                       borderSide: BorderSide(
                //                         color: Colors.grey.shade500,
                //                         width: 1.0,
                //                       ),
                //                     ),
                //                     border: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10),
                //                       borderSide: BorderSide(
                //                         color: Colors.grey.shade300,
                //                         width: 0.5,
                //                       ),
                //                     ),
                //                     labelText: 'Select a category',
                //                     labelStyle: TextStyle(
                //                       fontSize: 15,
                //                       color: Colors.grey.shade500,
                //                     ),
                //                     suffixIcon: Icon(Icons.arrow_drop_down),
                //                   ),
                //                   controller: TextEditingController(
                //                     text: selectedCategoryNames,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     } else if (state is VideoCategoriesFailure) {
                //       return Text('Failed to get categories');
                //     } else {
                //       return Text('No categories available');
                //     }
                //   },
                // ),




              // BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
                //   builder: (context, state) {
                //     if (state is VideoCategoriesLoading) {
                //       return Center(child: CircularProgressIndicator());
                //     }else if (state is VideoCategoriesLoaded) {
                //       return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                //         builder: (context, selectionState) {
                //           VideoCategoriesModel? selectedCategory;
                //           if (selectionState is CategorySelected) {
                //             selectedCategory = selectionState.selectedCategory;
                //           }
                //
                //           return GestureDetector(
                //             onTap: () {
                //               showDialog(
                //                 context: context,
                //                 builder: (context) {
                //                   return AlertDialog(
                //                     title: Center(
                //                       child: Text('Select a category',
                //                         style: TextStyle(
                //                             fontFamily: fontFamily,
                //                             fontSize: 22
                //                         ),
                //                       ),
                //                     ),
                //                     content: SizedBox(
                //                       width: double.infinity,
                //                       child: ListView.builder(
                //                         shrinkWrap: true,
                //                         itemCount: state.categories.length,
                //                         itemBuilder: (context, index) {
                //                           return Container(
                //                             width: double.infinity,
                //                             child: InkWell(
                //                               borderRadius: BorderRadius.circular(15),
                //                               onTap: () {
                //                                 BlocProvider.of<CategorySelectionBloc>(context)
                //                                     .add(SelectCategoryEvent(selectedCategory: state.categories[index]));
                //                                 Navigator.of(context).pop();
                //                               },
                //                               child: Container(
                //                                 alignment: Alignment.center,
                //                                 height: 40.h,
                //                                 width: double.infinity,
                //                                 decoration: BoxDecoration(
                //                                     borderRadius: BorderRadius.circular(15),
                //                                     color: selectedCategory == state.categories[index] ? Theme.of(context).colorScheme.tertiaryFixedDim : null
                //                                 ),
                //                                 child: Text(
                //                                   '${state.categories[index].name}',
                //                                   style: TextStyle(
                //                                     fontFamily: fontFamily,
                //
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           );
                //                         },
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               );
                //             },
                //             child: AbsorbPointer(
                //               child: TextFormField(
                //                 validator: _validateCategory,
                //                 decoration: InputDecoration(
                //                   filled: true,
                //                   fillColor: Theme.of(context).colorScheme.surfaceDim,
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10),
                //                     borderSide: BorderSide(color: blue, width: 2.0),
                //                   ),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10),
                //                     borderSide: BorderSide(
                //                       color: Colors.grey.shade500,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10),
                //                     borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
                //                   ),
                //                   labelText: 'Select a category',
                //                   labelStyle: TextStyle(
                //                       fontSize: 15,
                //                       color: Colors.grey.shade500
                //                   ),
                //                   suffixIcon: Icon(Icons.arrow_drop_down),
                //                 ),
                //                 controller: TextEditingController(
                //                   text: selectedCategory?.name ?? '',
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     } else if (state is VideoCategoriesFailure) {
                //       return Text('Failed to get categories');
                //     } else {
                //       return Text('No categories available');
                //     }
                //   },
                // ),
                SizedBox(height: 30.h),



                TextFormField(
                  controller: _hashtagController,
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 50,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Hashtag...',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondaryFixedDim,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceDim,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.black12, width: 0.5
                      ),
                    ),
                  ),
                  onChanged: _extractHashtags,
                ),

                _hashtags.isNotEmpty ? Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.tertiaryFixedDim,
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _hashtags.map((hashtag) => Chip(
                      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                      side: BorderSide(
                          width: 0,
                          color: Colors.grey.shade600
                      ),
                      label: Text(hashtag,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: Colors.grey.shade600
                        ),
                      ),
                      deleteIconColor: Colors.grey.shade700,
                      onDeleted: () {
                        setState(() {
                          _hashtags.remove(hashtag);
                          _hashtagController.text = _hashtags.join(' ') + ' ';
                        });
                      },
                    ))
                        .toList(),
                  ),
                ) : Container(),


                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // icon: Icon(HeroiconsOutline.arrowRight),
                          title: Center(
                            child: Text('Select a visibility',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 22
                              ),
                            ),
                          ),
                          content: SizedBox(
                            width: 400.w,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: visibility.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  // alignment: Alignment.center,
                                    height: 40.h,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: (){
                                        setState(() {
                                          selectedVisibility = visibility[index]['type'];
                                          print('${selectedVisibility}');
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: selectedVisibility == visibility[index]['type'] ? Theme.of(context).colorScheme.tertiaryFixedDim : null,
                                        ),

                                        child: Text(
                                          visibility[index]['type'] == "public" ? 'Public' : 'Private',
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                          ),
                                        ),
                                      ),
                                    )


                                  // },
                                  // ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: _validateVisibility,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceDim,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade700, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black12, width: 0.5),
                        ),
                        labelText: 'Select a visibility',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade500
                        ),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                      controller: TextEditingController(
                        text: selectedVisibility == "public" ? 'Public' : 'Private',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),



                // TOGGLE BUTTON for
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.tertiaryFixedDim,
                  ),
                  // padding: EdgeInsets.all(0),
                  child: CustomToggleButton(

                      borderRadius: 15.0,
                      onTap: (){
                        setState(() {
                          isCommentOn = !isCommentOn;
                        });
                      },
                      toggleName: 'Comments',
                      toggleValue: isCommentOn,
                      onChanged: (bool value) {
                        setState(() {
                          isCommentOn = value;
                        });
                      },
                      toggleState: isCommentOn ? 'on' : 'off'
                  ),
                ),

                SizedBox(height: 30.h,),

                // Submit Button
                Center(
                  child: BlocBuilder<UploadVideoExternalBloc, UploadVideoExternalState>(
                      builder: (context, state){
                        if(state is UploadVideoExternalSuccess){
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            GoRouter.of(context).pushReplacementNamed('homePage');
                          });
                        }else if(state is UploadVideoExternalLoading){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        return ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {

                                  final videoTitle = _titleController.text;
                                  final videoDescription = _descriptionController.text;
                                  final videoExternalUrl = _videoUrlController.text;


                                  print("Form is Valid");
                                  // print('Video::::::::     ${selectedVideo}');
                                  print('Thumbnail::::::    ${finalThumbnail}');
                                  print('Title::::::     ${_titleController.text}');
                                  print('Description::::::     ${_descriptionController.text}');
                                  print('Categories::::::   ${selectedCategoryIds.single}');
                                  print("Hashtags:::::::     $_hashtags");
                                  print("Selected Visibility::::::::      $selectedVisibility");
                                  print("Comments Enabled:::::::::      $isCommentOn");

                                  context.read<UploadVideoExternalBloc>().add(UploadVideoExternalRequest(
                                    videoExternalUrl: videoExternalUrl,
                                      videoThumbnail: finalThumbnail,
                                      videoTitle: videoTitle,
                                      videoDescription: videoDescription,
                                      videoCategory: selectedCategoryIds,
                                      videoVisibility: selectedVisibility
                                  ));

                                } else {
                                  print("Form is not Valid");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 105.w, vertical: 15.h),
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Upload Video',
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            );
                      }
                  ),
                ),
                SizedBox(height: 20.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
