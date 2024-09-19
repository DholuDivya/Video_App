import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_bloc.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_event.dart';
import 'package:vimeo_clone/bloc/edit_video_detail/edit_video_detail_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';
import '../../bloc/get_thumbnail_from_user/get_thumbnail_bloc.dart';
import '../../bloc/get_thumbnail_from_user/get_thumbnail_event.dart';
import '../../bloc/get_thumbnail_from_user/get_thumbnail_state.dart';
import '../../bloc/play_video/play_video_bloc.dart';
import '../../bloc/play_video/play_video_event.dart';
import '../../bloc/play_video/play_video_state.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';

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
  var thumbnail;
  List<String> _hashtags = [];


  @override
  void initState() {
    context.read<PlayVideoBloc>().add(GetVideoSlugEvent(slug: widget.videoSlug!));
    final playVideoBloc = context.read<PlayVideoBloc>();

    playVideoBloc.stream.listen((state){
      if(state is PlayVideoLoaded){
        final videoData = state.playVideo.first.data;
        thumbnail = videoData!.thumbnail;
        selectedVisibility = videoData.visibility ?? '';
        _titleController = TextEditingController(
            text: state.playVideo.first.data!.title
        );
        String? initialHashtagsFromApi = videoData.hashtag;  // Replace with actual API data

        // Initialize the controller with the hashtag string from the API response
        _hashtagController = TextEditingController(text: initialHashtagsFromApi ?? '');

        // If there is an initial hashtag value, extract the hashtags
        if (initialHashtagsFromApi != null && initialHashtagsFromApi.isNotEmpty) {
          // Use a Future to ensure this happens after the widget has been mounted
          Future.delayed(Duration.zero, () {
            if (mounted) {
              _extractHashtags(initialHashtagsFromApi); // Safely check for mounting before setState
            }
          });
        }
      }
    });
    super.initState();
  }

  void _extractHashtags(String text) {
    final RegExp hashtagRegExp = RegExp(r'(#\w+|\b\w{1,}\b)');
    final Iterable<RegExpMatch> matches = hashtagRegExp.allMatches(text);

    if (mounted) {
      setState(() {
        _hashtags = matches
            .map((match) => '#' + match.group(0)!.replaceAll('#', ''))
            .toList();
      });
    }
  }

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
        centerTitle: true,
        title: const Text(
          'Edit video detail',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),
      body: BlocBuilder<PlayVideoBloc, PlayVideoState>(
        builder: (BuildContext context, PlayVideoState state) {
          if(state is PlayVideoLoaded){
            final videoData = state.playVideo.first.data;
            thumbnail = state.playVideo.first.data!.thumbnail;
            _descriptionController = TextEditingController(
              text: videoData!.description
            );
            return SingleChildScrollView(
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
                                        image: finalThumbnail != null ? DecorationImage(
                                            image: FileImage(File(finalThumbnail!.path))
                                        ) : DecorationImage(
                                            image: NetworkImage(thumbnail),
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
                                  )
                                ],
                              ),
                            );
                          }


                          return AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: finalThumbnail != null ? DecorationImage(
                                          image: FileImage(File(finalThumbnail!.path))
                                      ) : DecorationImage(
                                        image: NetworkImage(thumbnail),
                                      )
                                  ),
                                ),
                                Positioned(
                                  top: 10.h,
                                  left: 10.w,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () {
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
                                )
                              ],
                            ),
                          );
                        }),
                    SizedBox(height: 15.h),
                    CustomTextFieldUpload(
                        // readOnly: isEdit == false ? true : false,
                        // isEnabled: isEdit == false ? false : true,
                      readOnly: false,
                        isEnabled: true,
                        autoFocus: false,
                        controller: _titleController,
                        fieldLabel: 'Title'
                    ),
                    SizedBox(height: 15.h),
                    CustomTextFieldUpload(
                        // readOnly: isEdit == false ? true : false,
                        // isEnabled: isEdit == false ? false : true,
                        readOnly: false,
                        isEnabled: true,
                        controller: _descriptionController,
                        fieldLabel: 'Description'
                    ),
                    SizedBox(height: 15.h),
                    CustomTextFieldUpload(
                        readOnly: true,
                        isEnabled: false,
                        controller: TextEditingController(
                          text: videoData.categories!.first.name
                        ),
                        fieldLabel: 'Category'
                    ),
                    SizedBox(height: 15.h),

                    TextFormField(
                      readOnly: false,
                      enabled: true,
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
                      onChanged: (value) {
                        // Extract hashtags every time the text is changed
                        _extractHashtags(value);
                      },
                    ),

                    // Display extracted hashtags from both API response and user input
                    _hashtags.isNotEmpty
                        ? Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Container(
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
                            side: BorderSide(width: 0, color: Colors.grey.shade600),
                            label: Text(
                              hashtag,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            deleteIconColor: Colors.grey.shade700,
                            onDeleted: () {
                              setState(() {
                                // Remove the hashtag from the list
                                _hashtags.remove(hashtag);

                                // Update the text field to reflect the remaining hashtags
                                _hashtagController.text = _hashtags.join(' ') + ' ';
                              });
                            },
                          )).toList(),
                        ),
                      ),
                    )
                        : Container(),
                    SizedBox(height: 15.h,),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {

                            return AlertDialog(
                              title: const Center(
                                child: Text(
                                  'Select Visibility',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              content: Container(
                                width: 400.w,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: visibility.length,
                                  itemBuilder: (context, index) {
                                    final currentVisibility = visibility[index]['type'];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5), // Add padding between items
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {
                                          setState(() {
                                            selectedVisibility = currentVisibility;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: selectedVisibility == currentVisibility
                                                ? Theme.of(context).colorScheme.tertiaryFixedDim
                                                : Colors.transparent, // Use transparent for default state
                                          ),
                                          child: Text(
                                            currentVisibility,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                            ),
                                          ),
                                        ),
                                      ),
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
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceDim,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primaryColor, width: 2.0),
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
                              borderSide: const BorderSide(color: Colors.black12, width: 0.5),
                            ),
                            labelText: 'Select a visibility',
                            labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                          controller: TextEditingController(
                            text: selectedVisibility, // This will display the initial value or the one selected by the user
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    BlocBuilder<EditVideoDetailBloc, EditVideoDetailState>(
                      builder: (BuildContext context, EditVideoDetailState state) {
                        if(state is EditVideoDetailSuccess){
                          context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            GoRouter.of(context).goNamed('homePage');
                          });

                          ToastManager().showToast(
                              context: context,
                              message: 'Channel details is successfully updated!'
                          );
                        }
                        return Container(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                              onPressed: (){
                                final videoTitle = _titleController.text.trim().isEmpty ? '' : _titleController.text;
                                final videoDescription = _descriptionController.text.trim().isEmpty ? '' : _descriptionController.text;
                                print('!!!!!!!!!!!!!!!!!!!     :::::   $videoTitle');
                                print('!!!!!!!!!!!!!!!!!!!     :::::   $videoDescription');
                                print('!!!!!!!!!!!!!!!!!!!     :::::   $_hashtags');
                                print('!!!!!!!!!!!!!!!!!!!     :::::   $finalThumbnail');
                                print('!!!!!!!!!!!!!!!!!!!     :::::   $selectedVisibility');
                                context.read<EditVideoDetailBloc>().add(EditVideoDetailRequest(
                                  videoSlug: widget.videoSlug!,
                                    videoTitle: videoTitle,
                                    videoDescription: videoDescription,
                                    videoHashtag: _hashtags,
                                    videoThumbnail: finalThumbnail,
                                    videoVisibility: selectedVisibility
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 120.w, vertical: 10.h),
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
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
