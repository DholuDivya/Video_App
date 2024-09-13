import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_bloc.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_bloc.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_state.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/model/get_shorts_list_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/like_dislike/like_dislike_state.dart';

class ContentScreen extends StatefulWidget {
  final Data shortsData;

  const ContentScreen({super.key, required this.shortsData});

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool _isSubscribed = false;
  PodPlayerController? _podPlayerController;
  late ValueNotifier<double> _sliderValueNotifier;
  bool isPause = false;
  bool _isLiked = false;
  bool _isDisliked = false;
  int _likeCount = 0;

  int commentLikeCount = 0;
  bool isCommentLiked = false;
  bool isCommentDisliked = false;



  @override
  void initState() {
    super.initState();
    _sliderValueNotifier = ValueNotifier(0.0);
    initializePlayer();
    _likeCount = widget.shortsData.likes!;
    _podPlayerController?.hideOverlay();
    // enterImmersiveMode();
  }

  void toggle(){
    setState(() {
      isPause = !isPause;
    });
  }



  Future initializePlayer() async {
    setState(() {
      // _podPlayerController = PodPlayerController(
      //     playVideoFrom: PlayVideoFrom.youtube('https://www.youtube.com/watch?v=nfl1rW7CWog'),
      //         podPlayerConfig: const PodPlayerConfig(
      //     isLooping: true,
      //           autoPlay: true,
      //           videoQualityPriority: [720, 360]
      // )

      // )..initialise();

      _podPlayerController = PodPlayerController(
        playVideoFrom: widget.shortsData.uploadedBy == "external"
            ? PlayVideoFrom.youtube(widget.shortsData.video!,)
            : PlayVideoFrom.network(widget.shortsData.video!,),
        podPlayerConfig: const PodPlayerConfig(
          isLooping: true,
          autoPlay: true,
        )
      )..initialise();
    });
  }

  @override
  void dispose() {
    _sliderValueNotifier.dispose();
    _podPlayerController?.dispose();
    super.dispose();
    // exitImmersiveMode();
  }


  void enterImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

// Call this method when you want to exit immersive mode
  void exitImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        _podPlayerController != null ? GestureDetector(
          onTap: (){

              toggle();
              isPause ? _podPlayerController?.pause() : _podPlayerController?.play();
            },
          child: AspectRatio(
            aspectRatio: 9/16,
            child: PodVideoPlayer(
                controller: _podPlayerController!,
              alwaysShowProgressBar: false,
              overlayBuilder: (options) {
                return const SizedBox.shrink();
              },
                matchVideoAspectRatioToFrame: true,
                matchFrameAspectRatioToVideo: true,
            ),
          ),
        ) : const Center(child:  CircularProgressIndicator(),),
        GestureDetector(
          onTap: (){
            toggle();
            isPause ? _podPlayerController?.pause() : _podPlayerController?.play();
          },
            child: Icon(
              isPause ? (Icons.play_arrow) : null, color: Colors.white70, size: 40,
            )
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ScreenSize.screenWidth(context) * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15.r,
                                backgroundImage: NetworkImage(
                                    widget.shortsData.channel!.logo!),
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Text(
                                  // 'rgtrewgtresw',
                                  widget.shortsData.channel!.name!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: fontFamily,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              SizedBox(width: 15.h,),
                              BlocBuilder<SubscribeChannelBloc, SubscribeChannelState>(
                                builder: (BuildContext context, SubscribeChannelState state) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (_isSubscribed) {
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Unsubscribed successfully'
                                        );
                                        context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: widget.shortsData.id!));
                                      } else {
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Subscribed successfully'
                                        );
                                        context.read<SubscribeChannelBloc>().add(SubscribeChannelRequest(channelId: widget.shortsData.id!));
                                      }
                                      setState(() {
                                        print('  BEFORE    $_isSubscribed  ');
                                        _isSubscribed = !_isSubscribed;
                                        print('  AFTER    $_isSubscribed  ');
                                      });
                                    },
                                    child: Container(
                                      height:
                                      ScreenSize.screenHeight(context) * 0.038,
                                      width: _isSubscribed
                                          ? ScreenSize.screenWidth(context) * 0.25
                                          : ScreenSize.screenWidth(context) * 0.22,
                                      decoration: BoxDecoration(
                                        color: _isSubscribed
                                            ? Colors.grey.shade200
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _isSubscribed
                                              ? 'Unsubscribe'
                                              : 'Subscribe',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: _isSubscribed
                                                ? Colors.black
                                                : Colors.white,
                                            fontFamily: fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.shortsData.description!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: fontFamily,
                          ),
                        ),
                        // SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.music_note,
                        //       size: 15,
                        //       color: Colors.white,
                        //     ),
                        //     SizedBox(width: 6),
                        //     Expanded(
                        //       child: Text(
                        //         'originalAudio',
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontFamily: fontFamily,
                        //             overflow: TextOverflow.ellipsis),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      children: [
                        BlocBuilder<LikeDislikeVideoBloc, LikeDislikeVideoState>(
                          builder: (BuildContext context, LikeDislikeVideoState state) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<LikeDislikeVideoBloc>().add(LikeVideoRequest(videoSlug: widget.shortsData.slug!));
                                    setState(() {
                                      if (_isLiked) {
                                        _isLiked = false;
                                        _likeCount--;
                                      } else {
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Video liked!'
                                        );
                                        _isLiked = true;
                                        _likeCount++;
                                        if (_isDisliked) {
                                          _isDisliked = false;
                                        }
                                      }
                                    });
                                  },
                                  child: _isLiked ? Icon(HeroiconsSolid.handThumbUp,
                                    color: Colors.blue,
                                  )
                                  : Icon(HeroiconsOutline.handThumbUp,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 8),
                                Text(
                                  _likeCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(height: 15.h),

                        BlocBuilder<LikeDislikeVideoBloc, LikeDislikeVideoState>(
                          builder: (BuildContext context, LikeDislikeVideoState state) {
                            return GestureDetector(
                              onTap: (){
                                context.read<LikeDislikeVideoBloc>().add(DislikeVideoRequest(videoSlug: widget.shortsData.slug!));
                                setState(() {
                                  if (_isDisliked) {
                                    _isDisliked = false;
                                  } else {
                                    ToastManager().showToast(
                                        context: context,
                                        message: 'Video disliked!'
                                    );
                                    _isDisliked = true;
                                    if (_isLiked) {
                                      _isLiked = false;
                                      _likeCount--;
                                    }
                                  }
                                });
                              },
                              child: _isDisliked ? const Icon(
                                HeroiconsSolid.handThumbDown,
                                color: Colors.blue,
                              )
                                  : const Icon(
                                HeroiconsOutline.handThumbDown,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 6.h),

                        SizedBox(height: 15.h),
                        GestureDetector(
                          onTap: (){
                            videoCommentSheet(context);
                          },
                          child: const Icon(
                            HeroiconsOutline.chatBubbleBottomCenterText,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.shortsData.comments.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: fontFamily,
                          ),
                        ),
                        SizedBox(height: 20),
                        Transform(
                          transform: Matrix4.rotationZ(5.8),
                          child: Icon(
                            HeroiconsOutline.paperAirplane,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Icon(
                        //   Icons.more_vert,
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }


  void videoCommentSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return FractionallySizedBox(
              heightFactor: 0.500.h,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Top fixed container with comments text and close button
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenSize.screenHeight(context) * 0.005,
                      left: ScreenSize.screenWidth(context) * 0.03,
                      right: ScreenSize.screenWidth(context) * 0.03,

                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Comments',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 22,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            icon: const Icon(HeroiconsOutline.xMark),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: Colors.grey.shade300,),
                  // SizedBox(height: 10), // Add some spacing if needed
                  // Scrollable user comments

                  BlocBuilder<GetCommentsBloc, GetCommentsState>(
                    builder: (BuildContext context, GetCommentsState state) {
                      if(state is GetCommentsLoaded){
                        return SizedBox(
                          height: 320.h,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                commentLikeCount != 0 ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  // scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.getCommentsList.first.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final getComments = state.getCommentsList.first.data![index];
                                    // commentLikeCount = getComments.likesCount!;
                                    // isCommentLiked = getComments.isLiked!;
                                    // isCommentDisliked = getComments.isDisliked!;


                                    // print('((((((((((((((((((((     $commentLikeCount');
                                    // print('((((((((((((((((((((     $isCommentLiked');
                                    // print('((((((((((((((((((((     $isCommentDisliked');

                                    return Container(
                                      // color: Colors.yellow,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: ScreenSize.screenHeight(context) * 0.015),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: ScreenSize.screenWidth(context) * 0.03,
                                            ),
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundImage: NetworkImage('${getComments.user!.profile}'),
                                            ),
                                          ),
                                          SizedBox(width: ScreenSize.screenWidth(context) * 0.015),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    '${getComments.user!.name} - ${getComments.createdAtHuman}',
                                                    style: TextStyle(
                                                      fontFamily: fontFamily,
                                                      fontSize: 12,
                                                      color: Colors.grey.shade700,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                SizedBox(height: ScreenSize.screenHeight(context) * 0.005),
                                                Text(
                                                  getComments.comment!,
                                                  style: const TextStyle(
                                                    fontFamily: fontFamily,
                                                    fontSize: 14,
                                                    overflow: TextOverflow.visible,
                                                  ),
                                                ),

                                                SizedBox(height: ScreenSize.screenHeight(context) * 0.025),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          /* context.read<LikeDislikeCommentBloc>().add(LikeCommentRequest(commentId: getComments.id!));
                                                          setState(() {
                                                            if (isCommentLiked){
                                                              isCommentLiked = false;
                                                              commentLikeCount--;
                                                            } else {
                                                              ToastManager().showToast(
                                                                  context: context,
                                                                  message: 'Comment liked!'
                                                              );
                                                              isCommentLiked = true;
                                                              commentLikeCount++;
                                                              if (isCommentDisliked){
                                                                isCommentDisliked = false;
                                                              }
                                                            }
                                                          });
                                                          print('LLLIIIKKKEEE');
                                                          print('88888888888888888888888    comment count ::  $commentLength');
                                                          print('88888888888888888888888    comment isLiked ::  $isCommentLiked');
                                                          print('88888888888888888888888    comment isDisliked ::  $isCommentDisliked'); */
                                                        },
                                                        child:
                                                        // isCommentLiked
                                                        //     ? const Icon(HeroiconsSolid.handThumbUp, size: 20)
                                                        const Icon(HeroiconsOutline.handThumbUp, size: 20)
                                                    ),
                                                    SizedBox(width: ScreenSize.screenWidth(context) * 0.01),
                                                    Text('0'),
                                                    SizedBox(width: ScreenSize.screenWidth(context) * 0.05),
                                                    GestureDetector(
                                                        onTap: (){
                                                          /* context.read<LikeDislikeCommentBloc>().add(DislikeCommentRequest(commentId: getComments.id!));
                                                          setState(() {
                                                            if (isCommentDisliked) {
                                                              isCommentDisliked = false;
                                                            } else {
                                                              ToastManager().showToast(
                                                                  context: context,
                                                                  message: 'Comment disliked!'
                                                              );
                                                              isCommentDisliked = true;
                                                              if (isCommentLiked) {
                                                                isCommentLiked = false;
                                                                commentLikeCount--;
                                                              }
                                                            }
                                                          });

                                                          print('77777777777777777777777    comment count ::  $commentLength');
                                                          print('77777777777777777777777    comment isLiked ::  $isCommentLiked');
                                                          print('77777777777777777777777    comment isDisliked ::  $isCommentDisliked'); */
                                                        },
                                                        child: const Icon(HeroiconsSolid.handThumbDown, size: 20)
                                                            // : const Icon(HeroiconsOutline.handThumbDown, size: 20)
                                                    ),
                                                    // SizedBox(width: ScreenSize.screenWidth(context) * 0.05),
                                                    // Icon(HeroiconsOutline.chatBubbleBottomCenterText, size: 20),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(HeroiconsOutline.ellipsisVertical, size: 18),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ) : const Center(child: Text('No comment found!!'),),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),

                  Divider(thickness: 0.5, color: Colors.grey.shade300,),

                  // AddCommentField(),
                  // Bottom fixed add comment text field
                  Container(
                    padding: EdgeInsets.only(
                        left: ScreenSize.screenHeight(context) * 0.02
                    ),
                    height: ScreenSize.screenHeight(context) * 0.05,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage('${Global.userData!.userProfilePhoto}'),
                        ),
                        SizedBox(width: ScreenSize.screenWidth(context) * 0.02,),

                        InkWell(
                          onTap: (){
                            addCommentSheet(context);
                          },
                          child: Container(
                            height: ScreenSize.screenHeight(context) * 0.5,
                            width: ScreenSize.screenWidth(context) * 0.8,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(
                                left: ScreenSize.screenWidth(context) * 0.02
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'Add Comment...',
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                    )
                                )
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  void addCommentSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),// This is important for adjusting to the keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // This ensures the padding matches the keyboard height
            left: 5.w,
            right: 5.w,
            // top: 5.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the sheet is as small as possible
            children: [
              Container(
                height: 30.h,
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  autofocus: true,
                  controller: _commentController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      hintText: 'Add Comment...',
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                          fontFamily: fontFamily
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                          top: 5.h
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.tertiaryFixedDim,

                      suffix: GestureDetector(
                        onTap: (){
                          final text = _commentController.text;
                          if (text.isNotEmpty) {
                            context.read<AddCommentBloc>().add(AddCommentRequest(
                              userComment: text,
                              videoSlug: widget.shortsData.slug!,
                            ));
                            ToastManager().showToast(
                              context: context,
                              message: 'Comment added successfully',
                            );

                            context.read<GetCommentsBloc>().add(GetCommentsRequest(videoSlug: widget.shortsData.slug!));
                          }
                          Navigator.pop(context);
                        },
                        child: const Icon(HeroiconsOutline.paperAirplane, color: Colors.grey,),
                      )
                  ),
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      context.read<AddCommentBloc>().add(AddCommentRequest(
                        userComment: text,
                        videoSlug: widget.shortsData.slug!,
                      ));
                      ToastManager().showToast(
                        context: context,
                        message: 'Comment added successfully',
                      );

                      print('succcessssss');
                      context.read<GetCommentsBloc>().add(GetCommentsRequest(videoSlug: widget.shortsData.slug!));
                    }
                    _commentController.clear();
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 5.h,),
              // const SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: () {
              //     final userComment = _commentController.text;
              //     if (userComment.isNotEmpty) {
              //       context.read<AddCommentBloc>().add(AddCommentRequest(
              //         userComment: userComment,
              //         videoSlug: widget.slug,
              //       ));
              //       ToastManager().showToast(
              //         context: context,
              //         message: 'Comment added successfully',
              //       );
              //       Navigator.pop(context); // Close the sheet after submitting
              //     }
              //   },
              //   child: Text('Post Comment'),
              // ),
            ],
          ),
        );
      },
    );
  }





}
