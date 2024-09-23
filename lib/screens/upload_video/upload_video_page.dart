import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_state.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_event.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_event.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_state.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_alert_dialog.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';
import 'package:vimeo_clone/utils/widgets/toggle_button.dart';
import '../../bloc/get_video_from_user/get_video_bloc.dart';
import '../../bloc/get_video_from_user/get_video_state.dart';
import '../../bloc/select_cat_for_video_detail/category_selection_bloc.dart';
import '../../bloc/select_cat_for_video_detail/category_selection_state.dart';
import '../../config/colors.dart';
import '../../model/video_categories_model.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  bool isCommentOn = true;
  final TextEditingController _hashtagController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _hashtags = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _extractHashtags(String text) {
    final RegExp hashtagRegExp = RegExp(r'(#\w+|\b\w{3,}\b)');
    final Iterable<RegExpMatch> matches = hashtagRegExp.allMatches(text);

    setState(() {
      _hashtags = matches
          .map((match) => '#' + match.group(0)!.replaceAll('#', ''))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<CategorySelectionBloc>().add(ClearCategorySelectionEvent());
    super.initState();
  }


  @override
  void dispose() {
    _hashtagController.dispose();
    finalThumbnail = null;
    _hashtagController.clear();
    _titleController.clear();
    _descriptionController.clear();
    _hashtagController.clear();
    super.dispose();
  }

  String selectedVisibility = '';

  void _validateAndSubmit() {
    // Check if the form is valid first
    if (_formKey.currentState!.validate()) {
      // Perform additional validation after form validation
      if (finalThumbnail == null) {
        ToastManager().showToast(
            context: context,
            message: 'Thumbnail is required'
        );
        // _showCustomDialog('Thumbnail is required');
        return;
      }
      if (selectedVideo == null) {
        ToastManager().showToast(
            context: context,
            message: 'Video is required'
        );
        // _showCustomDialog('Video is required');
        return;
      }
      if (tempSelectedCategoryIds.isEmpty) {
        print('ifhishhgfihgfihgfiihih     $selectedCategoryIds');
        ToastManager().showToast(
            context: context,
            message: 'Category is required'
        );
        // _showCustomDialog('Category is required');
        return;
      }

      // Check if title and description are not empty
      final videoTitle = _titleController.text;
      final videoDescription = _descriptionController.text;
      final videoHashtag = _hashtags;

      if (videoTitle.isEmpty) {
        ToastManager().showToast(
            context: context,
            message: 'Title is required'
        );
        // _showCustomDialog('Title is required');
        return;
      }
      if (videoDescription.isEmpty) {
        ToastManager().showToast(
            context: context,
            message: 'Description is required'
        );
        // _showCustomDialog('Description is required');
        return;
      }
      if (selectedVisibility == null || selectedVisibility.isEmpty) {
        ToastManager().showToast(
            context: context,
            message: 'Visibility is required'
        );
        // _showCustomDialog('Visibility is required');
        return;
      }

      String visibility = '';
      if(selectedVisibility == 'Public'){
        visibility = 'public';
      }else{
        visibility = 'private';
      }

      print("Form is Valid");
      print('Video::::::::     ${selectedVideo}');
      print('Thumbnail::::::    ${finalThumbnail!.path}');
      print('Title::::::     ${_titleController.text}');
      print('Description::::::     ${_descriptionController.text}');
      print('Categories::::::   ${selectedCategoryIds.join(', ')}');
      print("Hashtags:::::::     $videoHashtag");
      print("Selected Visibility::::::::      $visibility");
      print("Comments Enabled:::::::::      $isCommentOn");


      context.read<UploadVideoBloc>().add(UploadVideoRequestEvent(
          video: selectedVideo,
          videoThumbnail: finalThumbnail!,
          videoTitle: videoTitle,
          videoDescription: videoDescription,
          videoCategory: selectedCategoryIds,
          videoHashtag: videoHashtag,
          videoVisibility: visibility
      ));

    } else {
      _showCustomDialog('Please fill all required fields');
    }
  }


  void _showCustomDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          alertDialogTitle: 'Invalid',
          alertDialogWidgets: Text(message),
        );
      },
    );
  }



  final List visibility = [
    {"type": "Public"},
    {"type": "Private"}
  ];


  CroppedFile? finalThumbnail;
  late PlatformFile selectedVideo;
  List<int> selectedCategoryIds = [];
  late String selectedCategoryNames;
  List<int> tempSelectedCategoryIds = [];
  List<String> tempSelectedCategoryNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(HeroiconsOutline.arrowLeft),
        title: Column(
          children: [
            Text(
              'Add video details',
              style: TextStyle(
                fontFamily: fontFamily,
                // fontWeight: FontWeight.bold,
                // color: Colors.black,
              ),
            ),

          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  image: FileImage(File(finalThumbnail!.path))
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

                  return AspectRatio(
                      aspectRatio: 16 / 9,

                      child: finalThumbnail != null ? Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: FileImage(File(finalThumbnail!.path))
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
                      ) : InkWell(
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


                SizedBox(height: 40.h),

                CustomTextFieldUpload(
                  readOnly: false,
                  isEnabled: true,
                    controller: _titleController,
                    fieldLabel: 'Title'
                ),


                SizedBox(height: 15.h),
                TextFormField(
                  controller: _descriptionController,
                  // validator: _validateDescription,
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
                        color: Theme.of(context).colorScheme.secondaryFixedDim),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceDim,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          // color: Colors.grey.shade200,
                          width: 2.0),
                    ),
                    counterText: '',
                  ),
                ),
                SizedBox(height: 15.h),


              // BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
              //   builder: (context, state) {
              //     if (state is VideoCategoriesLoading) {
              //       return const Center(child: CircularProgressIndicator());
              //     } else if (state is VideoCategoriesLoaded) {
              //       return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
              //         builder: (context, selectionState) {
              //           final selectedCategoryIds = selectionState is CategorySelected
              //               ? selectionState.selectedCategoryIds
              //               : [];
              //
              //           // Get names of the selected categories
              //           final selectedCategoryNames = state.categories
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
              //                         'Select Categories',
              //                         style: TextStyle(fontSize: 22),
              //                       ),
              //                     ),
              //                     content: SizedBox(
              //                       width: 400,
              //                       child: StatefulBuilder(
              //                         builder: (context, setState) {
              //                           return ListView.builder(
              //                             shrinkWrap: true,
              //                             itemCount: state.categories.length,
              //                             itemBuilder: (context, index) {
              //                               final category = state.categories[index];
              //                               final isSelected = selectedCategoryIds.contains(category.id);
              //
              //                               return InkWell(
              //                                 onTap: () {
              //                                   // Toggle selection state in the Bloc
              //                                   if (isSelected) {
              //                                     context.read<CategorySelectionBloc>().add(
              //                                       DeselectCategoryEvent(categoryId: category.id!),
              //                                     );
              //                                   } else {
              //                                     context.read<CategorySelectionBloc>().add(
              //                                       SelectCategoryEvent(categoryId: category.id!),
              //                                     );
              //                                   }
              //                                   setState(() {}); // Update UI to reflect changes
              //                                 },
              //                                 child: Container(
              //                                   alignment: Alignment.center,
              //                                   height: 40,
              //                                   margin: const EdgeInsets.symmetric(vertical: 5),
              //                                   decoration: BoxDecoration(
              //                                     borderRadius: BorderRadius.circular(15),
              //                                     color: isSelected
              //                                         ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
              //                                         : Theme.of(context).colorScheme.surface,
              //                                   ),
              //                                   child: Text(
              //                                     category.name ?? '',
              //                                     style: TextStyle(
              //                                       color: isSelected ? Colors.white : Colors.black,
              //                                     ),
              //                                   ),
              //                                 ),
              //                               );
              //                             },
              //                           );
              //                         },
              //                       ),
              //                     ),
              //                     actions: [
              //                       TextButton(
              //                         onPressed: () => Navigator.pop(context), // Close dialog after selection
              //                         child: const Text('Done'),
              //                       ),
              //                     ],
              //                   );
              //                 },
              //               );
              //             },
              //             child: AbsorbPointer(
              //               child: TextFormField(
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Theme.of(context).colorScheme.surfaceDim,
              //                   focusedBorder: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                     borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
              //                   ),
              //                   enabledBorder: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                     borderSide: BorderSide(
              //                       color: Theme.of(context).colorScheme.secondary,
              //                       width: 1.0,
              //                     ),
              //                   ),
              //                   labelText: 'Select Categories',
              //                   labelStyle: TextStyle(
              //                     fontSize: 15,
              //                     color: Colors.grey.shade500,
              //                   ),
              //                   suffixIcon: const Icon(Icons.arrow_drop_down),
              //                 ),
              //                 controller: TextEditingController(
              //                   text: selectedCategoryNames.isNotEmpty
              //                       ? selectedCategoryNames
              //                       : 'Select Categories', // Fallback to default if no categories selected
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //     } else if (state is VideoCategoriesFailure) {
              //       return const Text('Failed to load categories');
              //     } else {
              //       return const Text('No categories available');
              //     }
              //   },
              // ),



              BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
                builder: (context, state) {
                  if (state is VideoCategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is VideoCategoriesLoaded) {
                    return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                      builder: (context, selectionState) {
                        // Initialize selectedCategoryIds and selectedCategoryNames
                        selectedCategoryIds = selectionState is CategorySelected
                            ? selectionState.selectedCategoryIds
                            : [];
                        selectedCategoryNames = selectionState is CategorySelected
                            ? selectionState.selectedCategoryNames.join(', ')
                            : '';

                        return GestureDetector(
                          onTap: () {
                            // Open category selection dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                // Temporary variables for dialog selections
                                tempSelectedCategoryIds = List<int>.from(selectedCategoryIds);
                                tempSelectedCategoryNames = List<String>.from(selectedCategoryNames.isNotEmpty ? selectedCategoryNames.split(', ') : []);

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text(
                                          'Select Categories',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                      content: SizedBox(
                                        width: 400,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.categories.length,
                                              itemBuilder: (context, index) {
                                                final category = state.categories[index];
                                                final isSelected = tempSelectedCategoryIds.contains(category.id);

                                                return GestureDetector(
                                                  // borderRadius: BorderRadius.circular(15),
                                                  onTap: () {
                                                    setState(() {
                                                      if (isSelected) {
                                                        // Deselect category
                                                        tempSelectedCategoryIds.remove(category.id);
                                                        tempSelectedCategoryNames.remove(category.name!);
                                                      } else {
                                                        // Select category
                                                        tempSelectedCategoryIds.add(category.id!);
                                                        tempSelectedCategoryNames.add(category.name!);
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 35.h,
                                                    margin: EdgeInsets.symmetric(vertical: 5.h),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: isSelected
                                                          ? primaryLightColor // Color for selected state
                                                          : Colors.white, // Default color for deselected state
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? primaryColor // Border for selected state
                                                            : Theme.of(context).colorScheme.secondary, // Border for deselected state
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            category.name!,
                                                            style: TextStyle(
                                                              fontFamily: fontFamily,
                                                              color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                                                              // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Bold text for selected
                                                            ),
                                                          ),
                                                          SizedBox(width: 10.w,),
                                                          isSelected ? Icon(HeroiconsSolid.checkCircle , size: 20.r, color: primaryColor,)
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the dialog without changes
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Theme.of(context).colorScheme.secondaryFixed, // Optional: make Cancel button red
                                                  ),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontFamily: fontFamily,
                                                      color: greyShade900,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: primaryColor, // Optional: make Add button with primary color
                                                  ),
                                                  onPressed: () {
                                                    // On "Add" button press, update the Bloc with selected categories
                                                    context.read<CategorySelectionBloc>().add(
                                                      UpdateCategorySelectionEvent(
                                                        selectedCategoryIds: tempSelectedCategoryIds,
                                                        selectedCategoryNames: tempSelectedCategoryNames,
                                                      ),
                                                    );
                                                    Navigator.of(context).pop(); // Close the dialog
                                                  },
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                      fontFamily: fontFamily,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              scribbleEnabled: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.surfaceDim,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Select Categories',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                              ),
                              controller: TextEditingController(
                                text: selectedCategoryNames, // Prevent empty string
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is VideoCategoriesFailure) {
                    return const Text('Failed to load categories');
                  }
                  return const Text('No categories available');
                },
              ),







              // BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
              //   builder: (context, state) {
              //     if (state is VideoCategoriesLoading) {
              //       return const Center(child: CircularProgressIndicator());
              //     } else if (state is VideoCategoriesLoaded) {
              //
              //       return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
              //         builder: (context, selectionState) {
              //
              //           // Initialize empty selectedCategoryIds if none
              //           if (state is CategorySelected) {
              //             final selectedCategoryIds = selectionState is CategorySelected
              //                 ? selectionState.selectedCategoryIds
              //                 : [];
              //
              //             // Get the names of the selected categories
              //             final selectedCategoryNames = state.categories
              //                 .where((category) => selectedCategoryIds.contains(category.id))
              //                 .map((category) => category.name)
              //                 .join(', ');
              //
              //             return GestureDetector(
              //               onTap: () {
              //                 showDialog(
              //                   context: context,
              //                   builder: (context) {
              //                     return AlertDialog(
              //                       title: const Center(
              //                         child: Text(
              //                           'Select Categories',
              //                           style: TextStyle(fontSize: 22),
              //                         ),
              //                       ),
              //                       content: SizedBox(
              //                         width: 400,
              //                         child: ListView.builder(
              //                           shrinkWrap: true,
              //                           itemCount: state.categories.length,
              //                           itemBuilder: (context, index) {
              //                             final category = state.categories[index];
              //                             final isSelected = selectedCategoryIds.contains(state.categories);
              //
              //                             return InkWell(
              //                               borderRadius: BorderRadius.circular(15),
              //                               onTap: () {
              //                                 // Update the selection state in Bloc
              //                                 if (isSelected) {
              //                                   context.read<CategorySelectionBloc>().add(
              //                                     DeselectCategoryEvent(categoryId: category.id!),
              //                                   );
              //                                 } else {
              //                                   context.read<CategorySelectionBloc>().add(
              //                                     SelectCategoryEvent(categoryId: category.id!, categoryName: ),
              //                                   );
              //                                 }
              //                               },
              //                               child: Container(
              //                                 alignment: Alignment.center,
              //                                 height: 40,
              //                                 margin: const EdgeInsets.symmetric(vertical: 5),
              //                                 decoration: BoxDecoration(
              //                                   borderRadius: BorderRadius.circular(15),
              //                                   color: isSelected
              //                                       ? Theme.of(context).colorScheme.tertiaryFixedDim
              //                                       : Theme.of(context).colorScheme.surface,
              //                                   border: isSelected
              //                                       ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              //                                       : Border.all(color: Colors.grey.shade300, width: 1),
              //                                 ),
              //                                 child: Text(
              //                                   category.name!,
              //                                   style: TextStyle(
              //                                     color: isSelected ? Colors.white : Colors.black,
              //                                   ),
              //                                 ),
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                 );
              //               },
              //               child: AbsorbPointer(
              //                 child: TextFormField(
              //                   decoration: InputDecoration(
              //                     filled: true,
              //                     fillColor: Theme.of(context).colorScheme.surfaceDim,
              //                     focusedBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(10),
              //                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
              //                     ),
              //                     enabledBorder: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(10),
              //                       borderSide: BorderSide(
              //                         color: Theme.of(context).colorScheme.secondary,
              //                         width: 1.0,
              //                       ),
              //                     ),
              //                     labelText: 'Select Categories',
              //                     labelStyle: TextStyle(
              //                       fontSize: 15,
              //                       color: Colors.grey.shade500,
              //                     ),
              //                     suffixIcon: const Icon(Icons.arrow_drop_down),
              //                   ),
              //                   controller: TextEditingController(
              //                     text: selectedCategoryNames,
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }
              //           return SizedBox.shrink();
              //           },
              //       );
              //     } else if (state is VideoCategoriesFailure) {
              //       return const Text('Failed to load categories');
              //     }
              //       return const Text('No categories available');
              //   },
              // ),

              SizedBox(height: 15.h),

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
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.0,
                      ),
                    ),
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12, width: 0.5),
                    ),
                  ),
                  onChanged: _extractHashtags,
                ),

                _hashtags.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.tertiaryFixedDim,
                        ),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: _hashtags
                              .map((hashtag) => Chip(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceDim,
                                    side: BorderSide(
                                        width: 0, color: Colors.grey.shade600),
                                    label: Text(
                                      hashtag,
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          color: Colors.grey.shade600),
                                    ),
                                    deleteIconColor: Colors.grey.shade700,
                                    onDeleted: () {
                                      setState(() {
                                        _hashtags.remove(hashtag);
                                        _hashtagController.text =
                                            _hashtags.join(' ') + ' ';
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      )
                    : Container(),

                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // icon: Icon(HeroiconsOutline.arrowRight),
                          title: Center(
                            child: Text(
                              'Select a visibility',
                              style: TextStyle(
                                  fontFamily: fontFamily, fontSize: 22),
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
                                      onTap: () {
                                        setState(() {
                                          selectedVisibility =
                                              visibility[index]['type'];
                                          print('${selectedVisibility}');
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: selectedVisibility ==
                                                  visibility[index]['type']
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryFixedDim
                                              : null,
                                        ),
                                        child: Text(
                                          visibility[index]['type'],
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
                      // validator: _validateVisibility,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceDim,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: primaryColor,
                              width: 2.0
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black12, width: 0.5),
                        ),
                        labelText: 'Select a visibility',
                        labelStyle: TextStyle(
                            fontSize: 15, color: Colors.grey.shade500),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                      controller: TextEditingController(
                        text: selectedVisibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // TOGGLE BUTTON for
                Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 2,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.tertiaryFixedDim,
                    ),
                    // padding: EdgeInsets.all(0),
                    child: CustomToggleButton(
                        borderRadius: 15.0,
                        onTap: () {
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
                        toggleState: isCommentOn ? 'on' : 'off'),
                  ),
                ),

                SizedBox(
                  height: 30.h,
                ),

                // Submit Button
                Center(
                  child: BlocBuilder<UploadVideoBloc, UploadVideoState>(
                    builder: (context, state){
                      if(state is UploadVideoSuccess){
                        ToastManager().showToast(
                            context: context,
                            message: 'Video uploaded successfully'
                        );
                        context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          GoRouter.of(context).goNamed('homePage');
                        });

                      }else if(state is UploadVideoLoading){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    return BlocBuilder<GetVideoBloc, GetVideoState>(
                      builder: (BuildContext context, state) {
                      if(state is GetVideoSuccess){
                        selectedVideo = state.userVideo!;
                      }
                      return ElevatedButton(
                        onPressed: () {
                          _validateAndSubmit();
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
                      },
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


