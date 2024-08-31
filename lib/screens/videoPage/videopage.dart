import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:readmore/readmore.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_bloc.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_event.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_event.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_bloc.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_state.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_state.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_event.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_state.dart';
import 'package:vimeo_clone/bloc/like_dislike_comment/like_dislike_comment_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike_comment/like_dislike_comment_event.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_bloc.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_event.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_state.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_state.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_state.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_bloc.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_event.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/Utils/Widgets/download_button.dart';
import 'package:vimeo_clone/Utils/Widgets/report_button.dart';
import 'package:vimeo_clone/Utils/Widgets/save_button.dart';
import 'package:vimeo_clone/Utils/Widgets/share_button.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/Utils/Widgets/video_container.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/model/play_video_model.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';
import 'package:vimeo_clone/utils/widgets/toggle_button.dart';
import '../../bloc/add_user_history/add_user_history_bloc.dart';
import '../../bloc/add_user_history/add_user_history_event.dart';



class VideoPage extends StatefulWidget {
  final String slug;
  const VideoPage({super.key, required this.slug});

  @override
  State<VideoPage> createState() => _VideoPageState();
}


class _VideoPageState extends State<VideoPage>  with SingleTickerProviderStateMixin {

  PodPlayerController? _podController;
  late bool _isSubscribed = false;
  // late bool local = false;
  late int _subscribeCount = 0;
  late int _channelId;
  late bool _isLiked = false;
  late bool _isDisLiked = false;
  int _likeCount = 0;
  Duration? _lastReachedDuration;
  String? _lastReachedDurationString;
  StreamSubscription? _videoBlocSubscription;
  List<int> selectedPlaylistIds = [];
  late int selectedPlaylist;

  late String channelLogo = '';
  late int commentLength = 0;
  late String userComment = '';
  var commentData;
  late int commentLikeCount = 0;
  late bool isCommentLiked = false;
  late bool isCommentDisliked = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<PlayVideoBloc>().add(GetVideoSlugEvent(slug: widget.slug));
    context.read<GetCommentsBloc>().add(GetCommentsRequest(videoSlug: widget.slug));

    print('-------------------    $commentLength');
    final commentBloc = context.read<GetCommentsBloc>();
    commentBloc.stream.listen((state){
      print('kgsrbhjodsjnbdjnboidjjdodinb');

      if(state is GetCommentsLoaded){
        commentLength = state.getCommentsList.first.data!.length;
        userComment = state.getCommentsList.first.data!.first.comment!;
        commentData = state.getCommentsList.first.data;
        print('^^^^^^^^^^^^^    $commentLength');
        print('898898989889989898989898');
      }
    });



    final videoBloc = context.read<PlayVideoBloc>();
    videoBloc.stream.listen((state) {
      if (state is PlayVideoLoaded) {
        _isSubscribed = state.playVideo[0].data!.channel!.isSubscribed!;
        _subscribeCount = state.playVideo[0].data!.channel!.subscriberCount!;
        _isLiked = state.playVideo[0].data!.isLiked!;
        _isDisLiked = state.playVideo[0].data!.isDisliked!;
        _likeCount = state.playVideo[0].data!.likes!;
        print('++++++++++++++++       $_isSubscribed');
        final videoData = state.playVideo[0].data!;
        if (mounted) {
          setState(() {
            _podController = PodPlayerController(
              playVideoFrom: videoData.uploadSourceType == "external"
                  ? PlayVideoFrom.youtube(videoData.video!)
                  : PlayVideoFrom.network(videoData.video!),
            )..initialise().then((_) {
              context.read<ViewIncrementBloc>().add(ViewIncrementRequest(videoSlug: widget.slug));
              print('Video has been initialized successfully!');
            });

            _podController?.addListener(() {
              if (_podController?.isInitialised ?? false) {
                // Make the initial API call when the video is initialized
                if (_lastReachedDuration == null) {
                  final currentPosition = _podController?.currentVideoPosition;
                  if (currentPosition != null) {
                    _lastReachedDuration = currentPosition;
                    _lastReachedDurationString = formatLastDuration(currentPosition);
                    context.read<UserHistoryBloc>().add(UserHistoryRequest(lastDuration: _lastReachedDurationString!, videoSlug: widget.slug));

                    // Start the timer to make API calls every 10 seconds
                    _startTimer();
                  }
                }
              }
            });

          });
        }
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      final currentPosition = _podController?.currentVideoPosition;
      if (currentPosition != null) {
        setState(() {
          _lastReachedDuration = currentPosition;
          _lastReachedDurationString = formatLastDuration(currentPosition);
          context.read<UserHistoryBloc>().add(UserHistoryRequest(lastDuration: _lastReachedDurationString!, videoSlug: widget.slug));
        });
      }
    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    _podController?.dispose();
    _videoBlocSubscription?.cancel();
    _focusNode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<PlayVideoBloc, PlayVideoState>(
              builder: (BuildContext context, state) {
                if(state is PlayVideoLoaded) {
                  final data = state.playVideo[0].data!;
                  _channelId = data.channel!.id!;
                  channelLogo = state.playVideo[0].data!.channel!.logo!;
                  // var _subscribeCount = data.channel!.subscriberCount;
                  // _likeCount = data.likes!;
                  // _isLiked = data.isLiked!;
                  // _isDisLiked = data.isDisliked!;
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(top: 180.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title of the video, Views and Upload time
                        InkWell(
                          onTap: () {
                            final desData = state.playVideo[0];
                            videoDescriptionSheet(context, desData);
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: ScreenSize.screenHeight(context) * 0.01,
                                left: ScreenSize.screenWidth(context) * 0.03,
                                right: ScreenSize.screenWidth(context) * 0.03,
                                bottom: ScreenSize.screenWidth(context) * 0.015,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.playVideo[0].data!.title}',
                                    style: const TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  AutoSizeText(
                                    '${state.playVideo[0].data!.views} Views - ${state.playVideo[0].data!.createdAtHuman}',
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenSize.screenHeight(context) * 0.01),

                        // Channel Photo, Channel Name, Subscriber, Subscribe Button
                        Padding(
                          padding: EdgeInsets.only(
                            left: ScreenSize.screenWidth(context) * 0.03,
                            right: ScreenSize.screenWidth(context) * 0.03,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage('${state.playVideo[0].data!.channel!.logo}'),
                                // backgroundImage: NetworkImage('${state.playVideo[0].data!.channel!.logo}'),
                                // child: Icon(Remix.user_3_line),
                              ),
                              SizedBox(width: ScreenSize.screenWidth(context) * 0.02),
            
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    final String channelId = state.playVideo.first.data!.channel!.id.toString();
                                    GoRouter.of(context).pushNamed(
                                        'channelProfilePage',
                                        pathParameters: {
                                          'channelId': channelId
                                        }
                                    );
                                    _podController?.pause();
                                  },
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${state.playVideo[0].data!.channel!.name}',
                                          style: const TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                          width: ScreenSize.screenWidth(context) * 0.03),
                                              Text(
                                                  _subscribeCount.toString(),
                                                  style: TextStyle(
                                                    fontFamily: fontFamily,
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                              ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: ScreenSize.screenWidth(context) * 0.02),


                              BlocBuilder<SubscribeChannelBloc, SubscribeChannelState>(
                                builder: (BuildContext context, SubscribeChannelState state) {
                                  if (state is SubscribeChannelSuccess) {
                                    // _isSubscribed = state.subscribeChannel.isNotEmpty && state.subscribeChannel[0].isSubscribed!;
                                  } else if (state is UnsubscribeChannelSuccess) {
                                    // _isSubscribed = state.subscribeChannel.isNotEmpty && state.subscribeChannel[0].isSubscribed!;
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if (_isSubscribed) {
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Unsubscribed successfully'
                                        );
                                        context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: _channelId));
                                      } else {
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Subscribed successfully'
                                        );
                                        context.read<SubscribeChannelBloc>().add(SubscribeChannelRequest(channelId: _channelId));
                                      }

                                      setState(() {
                                        print('  BEFORE    $_isSubscribed  ');
                                        _isSubscribed = !_isSubscribed;
                                        if(_isSubscribed){
                                          _subscribeCount++;
                                        }else{
                                          _subscribeCount--;
                                        }
                                        print('  AFTER    $_isSubscribed  ');
                                      });
                                    },
                                    child: Container(
                                      height: ScreenSize.screenHeight(context) * 0.045,
                                      width: _isSubscribed
                                          ? ScreenSize.screenWidth(context) * 0.28
                                          : ScreenSize.screenWidth(context) * 0.25,
                                      decoration: BoxDecoration(
                                        color: _isSubscribed ? Colors.grey.shade200 : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _isSubscribed ? 'Unsubscribe' : 'Subscribe',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _isSubscribed ? Colors.black : Colors.white,
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
                        SizedBox(height: ScreenSize.screenHeight(context) * 0.02),

                        // Like, DisLike, Save, Download, Share, Report Buttons
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                            left: ScreenSize.screenWidth(context) * 0.03,
                            right: ScreenSize.screenWidth(context) * 0.03,
                          ),
                          child: Row(
                            children: [
                              BlocBuilder<LikeDislikeVideoBloc, LikeDislikeVideoState>(
                                  builder: (BuildContext context, LikeDislikeVideoState state){
                                    if(state is LikeVideoSuccess){}
                                    else if(state is DislikeVideoSuccess){}
                                    return IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.surfaceDim,
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          padding: EdgeInsets.only(
                                            left: ScreenSize.screenWidth(context) * 0.03,
                                            right: ScreenSize.screenWidth(context) * 0.03,
                                            top: ScreenSize.screenHeight(context) * 0.009,
                                            bottom: ScreenSize.screenHeight(context) * 0.009,
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  context.read<LikeDislikeVideoBloc>().add(LikeVideoRequest(videoSlug: widget.slug));
                                                  setState(() {
                                                    print('((((  $_isDisLiked   )))) ');
                                                    print('((((  $_isLiked  ))))');
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
                                                      if (_isDisLiked) {
                                                        _isDisLiked = false;
                                                      }
                                                    }
                                                    print('***********     $_isLiked');
                                                    print('***********     $_isDisLiked');
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    _isLiked == true
                                                        ? const Icon(Remix.thumb_up_fill, size: 17)
                                                        : const Icon(Remix.thumb_up_line, size: 17),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.02,
                                                    ),
                                                    Text(
                                                      '$_likeCount',
                                                      style: const TextStyle(
                                                        fontFamily: fontFamily,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.01,
                                              ),
                                              const VerticalDivider(thickness: 0.5),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.01,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  context.read<LikeDislikeVideoBloc>().add(DislikeVideoRequest(videoSlug: widget.slug));
                                                  setState(() {
                                                    if (_isDisLiked) {
                                                      _isDisLiked = false;
                                                    } else {
                                                      ToastManager().showToast(
                                                          context: context,
                                                          message: 'Video disliked!'
                                                      );
                                                      _isDisLiked = true;
                                                      if (_isLiked) {
                                                        _isLiked = false;
                                                        _likeCount--;
                                                      }
                                                    }
                                                    print('***********     $_isDisLiked');
                                                    print('***********     $_isLiked');
                                                  });
                                                },
                                                child: _isDisLiked == true
                                                    ? const Icon(Remix.thumb_down_fill, size: 17)
                                                    : const Icon(Remix.thumb_down_line, size: 17),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  ),

                              SizedBox(
                                  width: ScreenSize.screenWidth(context) *
                                      0.03),
            
                              const ShareButton(),
                              SizedBox(
                                  width: ScreenSize.screenWidth(context) *
                                      0.03),
            
                              const DownloadButton(),
                              SizedBox(
                                  width: ScreenSize.screenWidth(context) *
                                      0.03),

                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: (){
                                  context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
                                  showPlaylistBottomSheet(state.playVideo);
                                },
                                  child: const SaveButton()
                              ),
                              SizedBox(
                                  width: ScreenSize.screenWidth(context) *
                                      0.03),
            
                              const ReportButton(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize.screenHeight(context) * 0.02,),


                        commentLength != 0 ? BlocBuilder<GetCommentsBloc, GetCommentsState>(
                          builder: (BuildContext context, GetCommentsState state) {
                            if(state is GetCommentsLoaded){
                              final getComments = state.getCommentsList.first.data;
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenSize.screenWidth(context) * 0.03,
                                    right: ScreenSize.screenWidth(context) * 0.03
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    videoCommentSheet(context);
                                  },
                                  child: Container(
                                    // height: ScreenSize.screenHeight(context) * 0.,
                                    width: ScreenSize.screenWidth(context) * 0.95,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceDim,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                'Comments',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )
                                            ),
                                            SizedBox(
                                              width: ScreenSize.screenWidth(context) *
                                                  0.02,),
                                            Text(
                                              getComments!.length.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey.shade500
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenSize.screenHeight(context) *
                                              0.01,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundImage: NetworkImage(
                                                  '${getComments.last.user!.profile}'),
                                            ),
                                            SizedBox(
                                              width: ScreenSize.screenWidth(context) *
                                                  0.02,),

                                            Expanded(
                                              child: Text(
                                                getComments.last.comment!,
                                                style: const TextStyle(
                                                    fontFamily: fontFamily,
                                                    fontSize: 12,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                                maxLines: 4,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container(child: Text('NOOOO Commmmenntsss'),);
                          },
                        ) : Padding(
                          padding: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w
                          ),
                          child: Container(
                            // height: ScreenSize.screenHeight(context) * 0.,
                            width: ScreenSize.screenWidth(context) * 0.95,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceDim,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(
                              top: 8.h,
                              right: 10.w,
                              bottom: 8.h,
                              left: 10.w
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'Comments',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    SizedBox(
                                      width: ScreenSize.screenWidth(context) *
                                          0.02,),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.grey.shade500
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenSize.screenHeight(context) *
                                      0.01,),

                                Container(
                                  height: ScreenSize.screenHeight(context) * 0.05,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(channelLogo),
                                      ),
                                      SizedBox(width: ScreenSize.screenWidth(context) * 0.02,),

                                      InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: (){
                                          addCommentSheet(context);
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 280.w,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.tertiaryFixedDim,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          padding: EdgeInsets.only(
                                              left: ScreenSize.screenWidth(context) * 0.02
                                          ),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Add Comment...')
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            
                        // Divider(thickness: 0.5, color: Colors.grey.shade300,),
            
                        Container(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                                top: ScreenSize.screenHeight(context) * 0.02
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.playVideo[0].data!.recommended!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (state.playVideo[0].data!.recommended == null) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      ShimmerWidget.rectangular(
                                          height: 200, isBorder: false),
                                      SizedBox(height: 16),
            
                                      Row(
                                        children: [
                                          ShimmerWidget.circular(width: 50,
                                              height: 50,
                                              isBorder: true),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              ShimmerWidget.rectangular(
                                                  height: 20,
                                                  width: 120,
                                                  isBorder: true),
                                              SizedBox(height: 8),
                                              ShimmerWidget.rectangular(
                                                  height: 20,
                                                  width: 200,
                                                  isBorder: true),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                final recommendedVideos = state.playVideo[0].data!.recommended![index];
                                final videoDuration = recommendedVideos.duration;
                                final formattedDuration = formatDuration(videoDuration!);
                                return recommendedVideos.type == "video" ? VideoListItem(
                                  onTap: (){
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                      Future.delayed(
                                          const Duration(milliseconds: 200), () {
                                        GoRouter.of(context).pushNamed('videoPage',
                                            pathParameters: {
                                              "slug": recommendedVideos.slug!
                                            });
                                      });
                                    }

                                  },
                                  onTapChannel: (){
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                      final String channelId = recommendedVideos.channel!.id.toString();
                                      GoRouter.of(context).pushNamed(
                                          'channelProfilePage',
                                          pathParameters: {
                                            'channelId': channelId
                                          }
                                      );
                                    }



                                  },
                                  channelPhoto: '${recommendedVideos.channel!.logo}',
                                  thumbnailUrl: '${recommendedVideos.thumbnail}',
                                  duration: formattedDuration,
                                  title: '${recommendedVideos.title}',
                                  author: '${recommendedVideos.channel!.name}',
                                  views: '${recommendedVideos.views}',
                                  uploadTime: '${recommendedVideos.createdAtHuman}',
                                  onMorePressed: () {
                                    showPopupMenu();
                                    },
                                ) : null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // VIDEO PAGE SHIMMER---------------------------------
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16/9,
                        child: ShimmerWidget.rectangular(isBorder: false),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                            left: 5.w, right: 5.w),
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerWidget.rectangular(height: 40.h, isBorder: true),
                            SizedBox(height: 2.h,),

                            ShimmerWidget.rectangular(height: 10.h, width: 150.w,isBorder: true),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 2.w,),
                                    ShimmerWidget.circular(height: 40.h, width: 40.w, isBorder: true),
                                    SizedBox(width: 5.w,),
                                    ShimmerWidget.rectangular(height: 15.h, width: 150.w, isBorder: true),
                                  ],
                                ),

                                ShimmerWidget.rectangular(height: 30.h, width: 85.w, isBorder: true),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                          ],
                        ),
                      ),

                      Container(
                        height: ScreenSize.screenHeight(context) * 0.04,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: 10.h,
                            ),
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (context, index){
                              return Row(
                                children: [
                                  ShimmerWidget.rectangular(
                                      width: 100,
                                      height: 40.h,
                                      isBorder: true
                                  ),
                                  SizedBox(width: 10,)
                                ],
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 10.h,),

                      Container(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 5.w
                        ),
                        child: ShimmerWidget.rectangular(
                          height: 70.h,
                            isBorder: true),
                      ),
                      SizedBox(height: 10.h,),

                      Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 8,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerWidget.rectangular(
                                        height: 200, isBorder: false),
                                    SizedBox(height: 16),

                                    Row(
                                      children: [
                                        ShimmerWidget.circular(width: 50,
                                            height: 50,
                                            isBorder: true),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            ShimmerWidget.rectangular(
                                                height: 20,
                                                width: 120,
                                                isBorder: true),
                                            SizedBox(height: 8),
                                            ShimmerWidget.rectangular(
                                                height: 20,
                                                width: 200,
                                                isBorder: true),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
            
            // Video
            BlocBuilder<PlayVideoBloc, PlayVideoState>(
              builder: (BuildContext context, PlayVideoState state) {
                  if(state is PlayVideoLoaded){
                    return Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:  AspectRatio(
                            aspectRatio: 16/9,
                        child: _podController == null
                            ? const Center(child: CircularProgressIndicator())
                            : PodVideoPlayer(
                          controller: _podController!,
                        ),
                      )
                    );
                  }
                return Container();
              },
            
            ),
          ],
        ),
      ),
    );
  }




  // DESCRIPTION DIALOG BOX **********************************************************************
  void videoDescriptionSheet(BuildContext context, PlayVideoModel descriptionData ) {

    final videoCreatedDate = descriptionData.data!.categories?[0].createdAt;

    final String formattedDate = formatDate(videoCreatedDate!);

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.605.h,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: ScreenSize.screenHeight(context) * 0.01,
              left: ScreenSize.screenWidth(context) * 0.04,
              right: ScreenSize.screenWidth(context) * 0.04,
              bottom: ScreenSize.screenHeight(context) * 0.02
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 22
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            GoRouter.of(context).pop();
                          },
                          icon: Icon(HeroiconsOutline.xMark)
                      )
                    ],
                  ),
                ),

                Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),


                // VIDEO TITLE -------------------------------------------------
                Text(
                    '${descriptionData.data!.description}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis
                  ),
                  maxLines: 3,
                ),



                // VIDEO LIKES, VIEWS, UPLOAD DATE ---------------------------------
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenSize.screenHeight(context) * 0.018
                  ),
                  child: Container(
                    height: ScreenSize.screenHeight(context) * 0.055,
                    width: ScreenSize.screenWidth(context) * 0.9,
                    // color: yellow,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                descriptionData.data!.likes.toString(),
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 15
                                ),
                              ),
                              Text(
                                  'likes',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              )
                            ],
                          ),

                          Column(
                            children: [
                              Text(
                                descriptionData.data!.views.toString(),
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15
                                ),
                              ),
                              Text(
                                  'views',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              )
                            ],
                          ),

                          Column(
                            children: [
                              Text(
                                  formattedDate,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15
                                ),
                              ),
                              Text(
                                  'date',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenSize.screenWidth(context) * 0.015
                  ),
                  child: Container(
                    height: ScreenSize.screenHeight(context) * 0.03,
                    width: ScreenSize.screenWidth(context) * 0.9,
                    // color: red,

                    // child: Row(
                    //   children: [
                    //     VideoHastag(
                    //         hastag: 'tarakmehta'
                    //     ),
                    //     SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),
                    //
                    //     VideoHastag(
                    //         hastag: 'tmkocsmileofindia'
                    //     ),
                    //     SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),
                    //
                    //     VideoHastag(
                    //         hastag: 'tmkoc'
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.015,),

                Container(
                  // height: ScreenSize.screenHeight(context) * 0.5,
                  width: ScreenSize.screenWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ReadMoreText(
                    descriptionData.data!.description!,
                    trimLength: 400,
                    moreStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: Theme.of(context).colorScheme.secondaryFixedDim,
                      fontSize: 12
                    ),

                    lessStyle: TextStyle(
                        fontFamily: fontFamily,
                        color: Colors.grey.shade600,
                        fontSize: 12
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  String description = 'In this episode, Taarak is excited as he comes to the soda shop, everyone asks for the reason for his excitement. The reason is a shock to everyone as Anjali had cooked Taarak\'s favorite food for him. Purush Mandali starts speculating about why and how this miracle took place. Taarak also informs them about the surprise he is getting in the morning. In the morning, Jetha calls Taarak and requests to come to his place for breakfast. Will Jetha regret going to Taarak\'s place for his breakfast? \n  '
      'Show Name - Taarak Mehta Ka Ooltah Chashmah \n Star Cast - Dilip Joshi, Disha Vakani, Amit Bhatt \n Produced By - Asit Kumar Modi, Neela Asit Modi \n '
      'About The Show:\n '
  '----------------------------\n'
  'Taarak Mehta Ka Ooltah Chashmah is a comedy show inspired by the famous humorous column \'Duniya Ne Undha Chashmah\' written by the eminent Gujarati writer Mr. Tarak Mehta. This show revolves around the Gada Family which consists of uneducated businessmen Jethalal Champaklal Gada, Jethalal’s Wife Daya & their naughty Son Tipendra Gada living in \'Gokuldham Co-operative Society\' and covers topical issues which are socially relevant. In case of a problem and emergency, Jethalal Gada often rushes to Taarak Mehta to seek his help and guidance as he finds a philosopher in him. The residents of the housing society, help each other find solutions when they face common, real-life challenges and get involved in sticky situations.';



  MenuAnchor showPopupMenu(){
    return MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_horiz),
            tooltip: 'Show menu',
          );
        },
        menuChildren: List<MenuItemButton>.generate(
            3,
                (int index) => MenuItemButton(
            onPressed: (){},
                  child: Text('Item ${index + 1}'),
    )
    ));
  }






  void showPlaylistBottomSheet(List<PlayVideoModel> videoData){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
        context: context,
        builder: (context){
          return SizedBox(
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 25.h,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: greyShade300
                      )
                    )
                  ),
                  padding: EdgeInsets.only(
                    top: 5.h,
                    left: 10.w,
                    right: 10.w,
                    bottom: 2.h
                  ),
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          'Save to...',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16
                        ),
                      ),

                      MaterialButton(
                          onPressed: (){
                            createPlaylistAlertDialog();
                          },
                        child: Text(
                          '+ Create playlist',
                          style: TextStyle(
                              fontFamily: fontFamily,
                            color: primaryColor
                          ),
                        ),
                      )
                    ],
                  ),
                ),


                BlocBuilder<GetUserPlaylistBloc, GetUserPlaylistState>(
                  builder: (BuildContext context, GetUserPlaylistState state) {
                    if(state is GetUserPlaylistSuccess){
                      final playlistLength = state.userPlaylist.first.playlists!.length;
                      final playlist = state.userPlaylist.first.playlists;
                      return BlocBuilder<PlaylistSelectionBloc, PlaylistSelectionState>(
                        builder: (BuildContext context, PlaylistSelectionState state) {
                          if(state is PlaylistSelected){
                            selectedPlaylistIds = state.selectedPlaylistIds;
                            selectedPlaylist = selectedPlaylistIds.first;
                          }
                          return Container(
                            height: 120.h,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: playlistLength,
                              itemBuilder: (context, index) {
                                final userPlaylist = playlist![index];
                                final isSelected =  selectedPlaylistIds.contains(userPlaylist.id);
                                return Container(
                                  padding: EdgeInsets.only(
                                    // top: 2.h,
                                      left: 10.w,
                                      right: 10.w,
                                      bottom: 4.h
                                  ),
                                  width: double.infinity,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {
                                      if(isSelected){

                                        context.read<PlaylistSelectionBloc>().add(DeselectPlaylistRequest(playlistId: userPlaylist.id!));
                                      } else {
                                        context.read<PlaylistSelectionBloc>().add(SelectPlaylistRequest(playlistId: userPlaylist.id!));
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: isSelected
                                            ? blue
                                            : Theme.of(context).colorScheme.tertiaryFixedDim,
                                      ),
                                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${userPlaylist.title}',
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              color: isSelected ? Colors.white : Colors.black
                                            ),
                                          ),

                                          Text(
                                            '${userPlaylist.videos!.length}',
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                                color: isSelected ? Colors.white : Colors.black
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  },
                ),


                InkWell(
                  onTap: (){
                    context.read<AddVideoToPlaylistBloc>().add(AddVideoToPlaylistRequest(
                        videoId: videoData.first.data!.id!,
                        playlistId: selectedPlaylist
                    ));
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: greyShade300
                        )
                      )
                    ),
                    child: const Center(
                      child: Text(
                          'Done',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          );
        }
    );
  }

  final TextEditingController playlistTitleController = TextEditingController();
  final TextEditingController playlistDescriptionController = TextEditingController();
  late String playlistStatus = 'public';
  late bool isPublic = true;

  void createPlaylistAlertDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState){
                return AlertDialog(
                  title: Center(
                      child: Text(
                        'Create a playlist',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 17.sp
                        ),
                      )
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 8.h,),
                      CustomTextFieldUpload(
                        maxLines: 1,
                        controller: playlistTitleController,
                        fieldLabel: 'title',
                      ),
                      SizedBox(height: 10.h,),

                      CustomTextFieldUpload(
                        maxLines: 3,
                        minLines: 1,
                        controller: playlistDescriptionController,
                        fieldLabel: 'description',
                      ),
                      SizedBox(height: 10.h,),

                      Material(
                        child: Container(
                          height: 70,
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
                                  isPublic = !isPublic;
                                  if(isPublic){
                                    playlistStatus = 'public';
                                  }else{
                                    playlistStatus = 'private';
                                  }
                                  print('STATUSSSSSSSSS   :::::::    $playlistStatus');
                                });
                              },
                              toggleName: 'Privacy',
                              toggleValue: isPublic,
                              onChanged: (bool value) {
                                setState(() {
                                  isPublic = value;
                                  print('STATUSSSSSSSSS   :::::::    $isPublic');
                                });
                              },
                              toggleState: isPublic ? 'Public' : 'Private'),
                        ),
                      ),
                      SizedBox(height: 10.h,),

                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: (){
                          final playlistTitle = playlistTitleController.text;
                          final playlistDescription = playlistDescriptionController.text;

                          context.read<CreatePlaylistBloc>().add(CreatePlaylistRequest(
                              playlistTitle: playlistTitle,
                              playlistDescription: playlistDescription,
                              playlistStatus: playlistStatus
                          ));

                          context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor
                          ),
                          child: Center(
                            child: Text(
                              'Create',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),

                );
          });
        }
    );

  }







  // COMMENT DIALOG BOX ****************************************************************************


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
              heightFactor: 0.605.h,
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
                          height: 350.h,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  // scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.getCommentsList.first.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final getComments = state.getCommentsList.first.data![index];
                                    commentLikeCount = getComments.likesCount!;
                                    isCommentLiked = getComments.isLiked!;
                                    isCommentDisliked = getComments.isDisliked!;


                                    print('((((((((((((((((((((     $commentLikeCount');
                                    print('((((((((((((((((((((     $isCommentLiked');
                                    print('((((((((((((((((((((     $isCommentDisliked');

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
                                                          context.read<LikeDislikeCommentBloc>().add(LikeCommentRequest(commentId: getComments.id!));
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
                                                          print('88888888888888888888888    comment isDisliked ::  $isCommentDisliked');
                                                        },
                                                        child: isCommentLiked
                                                            ? const Icon(HeroiconsSolid.handThumbUp, size: 20)
                                                            : const Icon(HeroiconsOutline.handThumbUp, size: 20)
                                                    ),
                                                    SizedBox(width: ScreenSize.screenWidth(context) * 0.01),
                                                    Text('$commentLikeCount'),
                                                    SizedBox(width: ScreenSize.screenWidth(context) * 0.05),
                                                    GestureDetector(
                                                        onTap: (){
                                                          context.read<LikeDislikeCommentBloc>().add(DislikeCommentRequest(commentId: getComments.id!));
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
                                                          print('77777777777777777777777    comment isDisliked ::  $isCommentDisliked');
                                                        },
                                                        child: isCommentDisliked
                                                            ? const Icon(HeroiconsSolid.handThumbDown, size: 20)
                                                            : const Icon(HeroiconsOutline.handThumbDown, size: 20)
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
                                ),
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
                            videoSlug: widget.slug,
                          ));
                          ToastManager().showToast(
                            context: context,
                            message: 'Comment added successfully',
                          );

                          context.read<GetCommentsBloc>().add(GetCommentsRequest(videoSlug: widget.slug));
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
                        videoSlug: widget.slug,
                      ));
                      ToastManager().showToast(
                        context: context,
                        message: 'Comment added successfully',
                      );

                      print('succcessssss');
                      context.read<GetCommentsBloc>().add(GetCommentsRequest(videoSlug: widget.slug));
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




// void addCommentSheet(context){
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context){
  //         return TextField(
  //           autofocus: true,
  //           controller: _commentController,
  //           focusNode: _focusNode,
  //           decoration: InputDecoration(
  //             hintText: 'Add Comment...',
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide: BorderSide.none,
  //             ),
  //             filled: true,
  //             fillColor: Colors.grey.shade300,
  //           ),
  //           onTap: () {
  //             final userComment = _commentController.text;
  //             _focusNode.requestFocus();
  //             context.read<AddCommentBloc>().add(AddCommentRequest(userComment: userComment, videoSlug: widget.slug));
  //             ToastManager().showToast(
  //                 context: context,
  //                 message: 'Comment added successfully'
  //             );
  //           },
  //         );
  //       }
  //   );
  // }

}




class AddCommentField extends StatefulWidget {
  @override
  _AddCommentFieldState createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context)*0.065,
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/sonysab.jpg'),
          ),
          SizedBox(width: ScreenSize.screenWidth(context) * 0.02),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Add Comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
              ),
              onTap: () {
                _focusNode.requestFocus();
              },
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle adding comment
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}



class VideoHastag extends StatelessWidget {
  final String hastag;
  const VideoHastag({super.key, required this.hastag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenSize.screenWidth(context) * 0.025,
          right: ScreenSize.screenWidth(context) * 0.025
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '#${hastag}',
        style: TextStyle(
          // fontFamily: fontFamily,
          fontSize: 12,
        ),
      ),
    );
  }
}







// GestureDetector(
//   onTap: () {
//     if(_isSubscribed == true) {
//       context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: _channelId));
//       final subscribeBloc = context.read<SubscribeChannelBloc>();
//       subscribeBloc.stream.listen((state){
//         if(state is SubscribeChannelSuccess){
//           _isSubscribed = state.subscribeChannel.first.isSubscribed!;
//           print('SUBSCRIBE   STATE ::::::::::       $_isSubscribed');
//         }
//       });
//     }
//     if(_isSubscribed == false){
//       context.read<SubscribeChannelBloc>().add(SubscribeChannelRequest(channelId: _channelId));
//       final subscribeBloc = context.read<SubscribeChannelBloc>();
//       subscribeBloc.stream.listen((state){
//         if(state is UnsubscribeChannelSuccess){
//           _isSubscribed = state.subscribeChannel.first.isSubscribed!;
//           print('SUBSCRIBE   STATE ::::::::::       $_isSubscribed');
//         }
//       });
//     }
//     setState(() {
//       _isSubscribed = _isSubscribed;
//       print('SUBSCRIBE   STATE ::::::::::       $_isSubscribed');
//     });
//   },
//   child: Container(
//     height: ScreenSize.screenHeight(context) * 0.045,
//     width: _isSubscribed
//         ? ScreenSize.screenWidth(context) * 0.28
//         : ScreenSize.screenWidth(context) * 0.25,
//     decoration: BoxDecoration(
//       color: _isSubscribed ? Colors.grey.shade200 : Colors.red,
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Center(
//       child: Text(
//         _isSubscribed ? 'Unsubscribe' : 'Subscribe',
//         style: TextStyle(
//           fontSize: 12,
//           color: _isSubscribed ? Colors.black : Colors.white,
//           fontFamily: fontFamily,
//         ),
//       ),
//     ),
//   ),
// ),












// BlocBuilder<SubscribeChannelBloc, SubscribeChannelState>(
//   builder: (BuildContext context, SubscribeChannelState state) {
//     print(' *******************    ${state}');
//     if (state is SubscribeChannelSuccess) {
//       // _subscribeCount = state.subscribeChannel[0].subscriberCount;
//       _isSubscribed = state.subscribeChannel.first.isSubscribed!;
//       print('IS SUBSCRIBED ::::::   $_isSubscribed  ');
//     }
//     if(state is UnsubscribeChannelSuccess){
//       _isSubscribed = state.subscribeChannel.first.isSubscribed;
//       print('IS SUBSCRIBED ::::::   $_isSubscribed  ');
//       // _subscribeCount = state.subscribeChannel[0].subscriberCount;
//     }
//
//     return
//   },
// ),