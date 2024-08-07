import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_bloc.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_event.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_state.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/config/constants.dart';

import '../../utils/widgets/custom_text_field_upload.dart';

class UploadShortsPage extends StatefulWidget {
  const UploadShortsPage({super.key});

  @override
  State<UploadShortsPage> createState() => _UploadShortsPageState();
}

class _UploadShortsPageState extends State<UploadShortsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isCommentOn = true;
  final TextEditingController _hashtagController = TextEditingController();
  List<String> _shortsHashtags = [];
  final GlobalKey<FormState> _formKey = GlobalKey();


  void _extractHashtags(String text) {
    final RegExp hashtagRegExp = RegExp(r'\B#\w\w+');
    final Iterable<RegExpMatch> matches = hashtagRegExp.allMatches(text);
    setState(() {
      _shortsHashtags = matches.map((match) => match.group(0)!).toList();
    });
  }

  @override
  void dispose() {
    _hashtagController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
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
                    controller: _titleController,
                    fieldLabel: 'Title...'
                ),

                SizedBox(height: 20.h),

                CustomTextFieldUpload(
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
                //           String selectedCategoryNames = state.categories
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
                //                     title: Center(
                //                       child: Text(
                //                         'Select a category',
                //                         style: TextStyle(
                //                           fontFamily: fontFamily,
                //                           fontSize: 22,
                //                         ),
                //                       ),
                //                     ),
                //                     content: SizedBox(
                //                       width: double.infinity,
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
                //                     borderSide: BorderSide(
                //                       color: Colors.grey.shade300,
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
                // SizedBox(height: 20.h,),


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

                _shortsHashtags.isNotEmpty ? Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.tertiaryFixedDim,
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _shortsHashtags.map((hashtag) => Chip(
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
                          _shortsHashtags.remove(hashtag);
                          _hashtagController.text = _shortsHashtags.join(' ') + ' ';
                        });
                      },
                    ))
                        .toList(),
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
