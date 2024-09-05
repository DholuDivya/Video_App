import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_bloc.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_event.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_state.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_bloc.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_event.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';

import '../../bloc/get_thumbnail_from_user/get_thumbnail_bloc.dart';
import '../../bloc/get_thumbnail_from_user/get_thumbnail_event.dart';
import '../../bloc/get_thumbnail_from_user/get_thumbnail_state.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';
import '../../config/global_variable.dart';

class EditVideoDetailPage extends StatefulWidget {
  final String? videoSlug;
  const EditVideoDetailPage({super.key, this.videoSlug});

  @override
  State<EditVideoDetailPage> createState() => _EditVideoDetailPageState();
}

class _EditVideoDetailPageState extends State<EditVideoDetailPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _hashtagController = TextEditingController();
  TextEditingController _visibiltyController = TextEditingController();
  late bool isEdit = false;
  CroppedFile? finalThumbnail;

  List<String> _hashtags = [];
  void _extractHashtags(String text) {
    final RegExp hashtagRegExp = RegExp(r'(#\w+|\b\w{3,}\b)');
    final Iterable<RegExpMatch> matches = hashtagRegExp.allMatches(text);

    setState(() {
      _hashtags = matches
          .map((match) => '#' + match.group(0)!.replaceAll('#', ''))
          .toList();
    });
  }

  // @override
  // void initState() {
  //   context.read<PlayVideoBloc>().add(GetVideoSlugEvent(slug: widget.videoSlug));
  //   final playVideoBloc = context.read<PlayVideoBloc>();
  //
  //   playVideoBloc.stream.listen((state){
  //     if(state is PlayVideoLoaded){
  //
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void dispose() {
    _hashtagController.dispose();
    finalThumbnail = null;
    super.dispose();
  }

  String selectedVisibility = '';
  final List visibility = [
    {"type": "public"},
    {"type": "private"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isEdit == true ? IconButton(
            onPressed: (){
              setState(() {
                isEdit = false;
              });
            },
            icon: const Icon(HeroiconsOutline.xMark)
        ) : IconButton(
            onPressed: (){
              GoRouter.of(context).pop();
            },
            icon: const Icon(HeroiconsOutline.chevronLeft)
        ),
        title: const Text(
          'Edit video detail',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
        actions: [
          isEdit == false ? IconButton(
              onPressed: (){
                setState(() {
                  isEdit = true;
                });
              },
              icon: const Icon(HeroiconsOutline.pencilSquare)
          ) : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.h,
            left: 15.w,
            right: 15.w
          ),
          child: Column(
            children: [

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
                            isEdit == true ? Positioned(
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
                            ) : Container(),
                          ],
                        ),
                      );
                    }
                    else if(state is GetThumbnailLoading){
                      return const Center(child: CircularProgressIndicator(),);
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
                            child: isEdit == true ? Center(
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
                            ) : Container(),
                          ),
                        ));

                  }),


              // AspectRatio(
              //   aspectRatio: 16 / 9,
              //   child: Stack(
              //     children: [
              //       Container(
              //         // decoration: BoxDecoration(
              //         //     borderRadius: BorderRadius.circular(15),
              //         //     image: DecorationImage(
              //         //         image: FileImage(File(finalThumbnail!.path))
              //         //     )
              //         // ),
              //       ),
              //       Positioned(
              //         top: 10.h,
              //         left: 10.h,
              //         child: InkWell(
              //           borderRadius: BorderRadius.circular(100),
              //           onTap: () {
              //             // getThumbnail();
              //             // context
              //             //     .read<GetThumbnailBloc>()
              //             //     .add(OpenFilesToGetThumbnail());
              //           },
              //           child: Container(
              //             alignment: Alignment.center,
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               color: Theme.of(context)
              //                   .colorScheme
              //                   .secondary
              //                   .withOpacity(0.7),
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Icon(
              //               HeroiconsOutline.folderPlus,
              //               size: 18,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 15.h),


              CustomTextFieldUpload(
                readOnly: isEdit == false ? true : false,
                  isEnabled: isEdit == false ? false : true,
                  controller: _titleController,
                  fieldLabel: 'Title'
              ),
              SizedBox(height: 15.h),

              CustomTextFieldUpload(
                  readOnly: isEdit == false ? true : false,
                  isEnabled: isEdit == false ? false : true,
                  controller: _descriptionController,
                  fieldLabel: 'Description'
              ),
              SizedBox(height: 15.h),

              CustomTextFieldUpload(
                  readOnly: true,
                  isEnabled: false,
                  controller: _titleController,
                  fieldLabel: 'Category'
              ),
              SizedBox(height: 15.h),



              TextFormField(
                readOnly: isEdit == false ? true : false,
                enabled: isEdit == false ? false : true,
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
              SizedBox(height: 15.h,),


              GestureDetector(
                onTap: () {
                  isEdit == true ? showDialog(
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
                        content: Container(
                          // height: 80.h,
                          width: 300.h,
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
                  ) : null;
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

            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isEdit == true ? BlocBuilder<EditVideoDetailBloc, EditVideoDetailState>(
        builder: (BuildContext context, EditVideoDetailState state) {
          if(state is EditVideoDetailSuccess){
            ToastManager().showToast(
                context: context,
                message: 'Channel details is successfully updated!'
            );
          }
          return ElevatedButton(
              onPressed: (){
                String channelName = '';
                print('!!!!!!!!!!!!!!!!!!!     :::::   ${_titleController.text}');
                // Global.userData!.userName == _nameController.text
                //     ? null : channelName = _nameController.text;
                // final channelLogo = finalChannelLogo;
                // final channelBanner = null;

                final videoTitle = _titleController.text.trim().isEmpty ? '' : _titleController.text;
                final videoDescription = _descriptionController.text.trim().isEmpty ? '' : _descriptionController.text;

                context.read<EditVideoDetailBloc>().add(EditVideoDetailRequest(
                    videoTitle: videoTitle,
                    videoDescription: videoDescription,
                    videoHashtag: _hashtags,
                    videoThumbnail: finalThumbnail!,
                    videoVisibility: selectedVisibility

                  // channelName: channelName.isEmpty ? null : channelName,
                  // channelLogo: channelLogo,

                ));

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 135.w, vertical: 10.h),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18
                ),
              )
          );
        },
      ) : Container(),
    );
  }
}
