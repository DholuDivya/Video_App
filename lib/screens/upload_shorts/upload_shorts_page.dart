import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_bloc.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_event.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_state.dart';
import 'package:vimeo_clone/bloc/upload_shorts/upload_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/upload_shorts/upload_shorts_event.dart';
import 'package:vimeo_clone/bloc/upload_shorts/upload_shorts_state.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/config/constants.dart';

import '../../bloc/all_video_list/all_video_list_bloc.dart';
import '../../bloc/all_video_list/all_video_list_event.dart';
import '../../bloc/get_video_from_user/get_video_bloc.dart';
import '../../bloc/get_video_from_user/get_video_state.dart';
import '../../bloc/upload_video/upload_video_bloc.dart';
import '../../bloc/upload_video/upload_video_event.dart';
import '../../bloc/upload_video/upload_video_state.dart';
import '../../config/colors.dart';
import '../../utils/widgets/custom_alert_dialog.dart';
import '../../utils/widgets/custom_text_field_upload.dart';
import '../../utils/widgets/toggle_button.dart';

class UploadShortsPage extends StatefulWidget {
  final CroppedFile thumbnail;
  const UploadShortsPage({super.key, required this.thumbnail});

  @override
  State<UploadShortsPage> createState() => _UploadShortsPageState();
}

class _UploadShortsPageState extends State<UploadShortsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isCommentOn = true;
  final TextEditingController _hashtagController = TextEditingController();
  List<String> _hashtags = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  String selectedVisibility = '';


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
  void dispose() {
    _hashtagController.dispose();
    super.dispose();
  }


  void _validateAndSubmit() {

    finalThumbnail = widget.thumbnail;

    // Check if the form is valid first
    if (_formKey.currentState!.validate()) {
      // Perform additional validation after form validation
      if (finalThumbnail == null) {
        _showCustomDialog('Thumbnail is required');
        return;
      }
      if (selectedVideo == null) {
        _showCustomDialog('Video is required');
        return;
      }
      if (selectedCategoryIds.isEmpty) {
        _showCustomDialog('Category is required');
        return;
      }

      // Check if title and description are not empty
      final videoTitle = _titleController.text;
      final videoDescription = _descriptionController.text;
      final videoHashtag = _hashtags;

      if (videoTitle.isEmpty) {
        _showCustomDialog('Title is required');
        return;
      }
      if (videoDescription.isEmpty) {
        _showCustomDialog('Description is required');
        return;
      }
      if (selectedVisibility == null || selectedVisibility.isEmpty) {
        _showCustomDialog('Visibility is required');
        return;
      }

      print("Form is Valid");
      print('Video::::::::     ${selectedVideo}');
      print('Thumbnail::::::    ${finalThumbnail!.path}');
      print('Title::::::     ${_titleController.text}');
      print('Description::::::     ${_descriptionController.text}');
      print('Categories::::::   ${selectedCategoryIds.join(', ')}');
      print("Hashtags:::::::     $videoHashtag");
      print("Selected Visibility::::::::      $selectedVisibility");
      print("Comments Enabled:::::::::      $isCommentOn");

      context.read<UploadShortsBloc>().add(UploadShortsRequest(
          video: selectedVideo!,
          videoThumbnail: finalThumbnail!,
          videoTitle: videoTitle,
          videoDescription: videoDescription,
          videoCategory: selectedCategoryIds,
          videoHashtag: videoHashtag,
          videoVisibility: selectedVisibility
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
    {"type": "public"},
    {"type": "private"}
  ];


  CroppedFile? finalThumbnail;
  PlatformFile? selectedVideo;
  List<int> selectedCategoryIds = [];
  late String selectedCategoryNames;

  @override
  Widget build(BuildContext context) {
    print('Shorts thumbnail by arguments:: ${widget.thumbnail.path} ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                SizedBox(height: 20.h),

                CustomTextFieldUpload(
                  readOnly: false,
                    isEnabled: true,
                    controller: _titleController,
                    fieldLabel: 'Title...'
                ),

                SizedBox(height: 20.h),

                CustomTextFieldUpload(
                  readOnly: false,
                    isEnabled: true,
                    controller: _descriptionController,
                    fieldLabel: 'Description...'
                ),

                SizedBox(height: 20.h,),


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
                //               child: TextFormField(
                //                 // validator: _validateCategory,
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
                //                       color: Theme.of(context).colorScheme.secondary,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10),
                //                     borderSide: BorderSide(
                //                       color: Theme.of(context).colorScheme.secondary,
                //                       width: 0.5,
                //                     ),
                //                   ),
                //                   labelText: 'Select a category',
                //                   labelStyle: TextStyle(
                //                     fontSize: 15,
                //                     color: Colors.grey.shade500,
                //                   ),
                //                   suffixIcon: Icon(Icons.arrow_drop_down),
                //                 ),
                //                 controller: TextEditingController(
                //                   text: selectedCategoryNames,
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


              ],
            ),
          ),
        ),
      ),

      floatingActionButton: BlocBuilder<UploadShortsBloc, UploadShortsState>(
          builder: (context, state){
            if(state is UploadShortsSuccess){
              ToastManager().showToast(
                  context: context,
                  message: 'Shorts uploaded successfully'
              );
              context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
              WidgetsBinding.instance.addPostFrameCallback((_) {
                GoRouter.of(context).goNamed('homePage');
              });

            }else if(state is UploadShortsLoading){
              return const Center(child: CircularProgressIndicator(),);
            }else if(state is UploadShortsFailure){
              ToastManager().showToast(
                  context: context,
                  message: 'Failed to upload shorts'
              );
            }
            return BlocBuilder<GetShortsBloc, GetShortsState>(
              builder: (BuildContext context, state) {
                if(state is GetShortsSuccess){
                  selectedVideo = state.userShorts;
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
    );
  }
}
