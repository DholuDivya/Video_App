import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:readmore/readmore.dart';
import 'package:remixicon/remixicon.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_event.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_event.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_state.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_bloc.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_event.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_state.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_state.dart';
import 'package:vimeo_clone/bloc/add_user_history/add_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/add_user_history/add_user_history_event.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_bloc.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_event.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/Utils/Widgets/download_button.dart';

import 'package:vimeo_clone/Utils/Widgets/like_dislike.dart';
import 'package:vimeo_clone/Utils/Widgets/report_button.dart';
import 'package:vimeo_clone/Utils/Widgets/save_button.dart';
import 'package:vimeo_clone/Utils/Widgets/share_button.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/Utils/Widgets/video_container.dart';
import 'package:vimeo_clone/model/play_video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPage extends StatefulWidget {
  final String slug;
  const VideoPage({super.key, required this.slug});

  @override
  State<VideoPage> createState() => _VideoPageState();
}


class _VideoPageState extends State<VideoPage>  with SingleTickerProviderStateMixin {

  PodPlayerController? _podController;
  late bool _isSubscribed = false;
  // late String _subscribeCount;
  late int _channelId;
  // late bool _isLiked = false;
  // late bool _isDisLiked = false;
  // late int _likeCount;
  Duration? _lastReachedDuration;
  String? _lastReachedDurationString;
  StreamSubscription? _videoBlocSubscription;

  @override
  void initState() {
    super.initState();
    context.read<PlayVideoBloc>().add(GetVideoSlugEvent(slug: widget.slug));

    final videoBloc = context.read<PlayVideoBloc>();

    videoBloc.stream.listen((state) {
      if (state is PlayVideoLoaded) {
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
                // Update the last reached duration periodically
                final currentPosition = _podController?.currentVideoPosition;
                if (currentPosition != null) {
                  setState(() {
                    _lastReachedDuration = currentPosition;
                    _lastReachedDurationString = formatLastDuration(currentPosition);
                    context.read<UserHistoryBloc>().add(UserHistoryRequest(lastDuration: _lastReachedDurationString!, videoSlug: widget.slug));
                  });

                }
              }
            });
          });
        }
      }
    });

    print('&&&&&&&&&&&&&&&&&    $_isSubscribed');

    // _isLiked = false;
    // _isDisLiked = false;
    // _isSubscribed = true;
    // _subscribeCount = '';

  }


  @override
  void dispose() {

    if (_lastReachedDuration != null) {
      print('Last reached video duration: $_lastReachedDurationString');
    }

    _podController?.dispose();
    _videoBlocSubscription?.cancel();
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
                  _isSubscribed = data.channel!.isSubscribed!;
                  var _subscribeCount = data.channel!.subscriberCount;
                  var _likeCount = data.likes!;
                  bool _isLiked = data.isLiked!;
                  bool _isDisLiked = data.isDisliked!;
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
                                      fontWeight: FontWeight.bold,
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
                                // child: Icon(Remix.user_3_line),
                              ),
                              SizedBox(width: ScreenSize.screenWidth(context) * 0.02),
            
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    final String channelId = state.playVideo[0].data!.channel!.id.toString();
                                    context.read<ChannelProfileBloc>().add(GetChannelProfileEvent(channelId: channelId));
                                    GoRouter.of(context).pushNamed('channelProfilePage');
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
                                  bool isSubscribed = _isSubscribed;

                                  if (state is SubscribeChannelSuccess) {
                                    isSubscribed = state.subscribeChannel.isNotEmpty && state.subscribeChannel[0].isSubscribed! ?? false;
                                  } else if (state is UnsubscribeChannelSuccess) {
                                    isSubscribed = state.subscribeChannel.isNotEmpty && state.subscribeChannel[0].isSubscribed! ?? false;
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      if (isSubscribed) {
                                        context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: _channelId));
                                      } else {
                                        context.read<SubscribeChannelBloc>().add(SubscribeChannelRequest(channelId: _channelId));
                                      }

                                      // Update local state based on the new subscription status
                                      setState(() {
                                        _isSubscribed = !isSubscribed;
                                        print('subscribe ::::::::     ${isSubscribed}');
                                      });
                                    },
                                    child: Container(
                                      height: ScreenSize.screenHeight(context) * 0.045,
                                      width: _isSubscribed == true
                                          ? ScreenSize.screenWidth(context) * 0.28
                                          : ScreenSize.screenWidth(context) * 0.25,
                                      decoration: BoxDecoration(
                                        color: _isSubscribed == true ? Colors.grey.shade200 : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _isSubscribed == true ? 'Unsubscribe' : 'Subscribe',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _isSubscribed == true ? Colors.black : Colors.white,
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
                                    if(state is LikeVideoSuccess){
                                      _isLiked = state.likeVideo[0].data!.isLiked!;
                                      _isDisLiked = state.likeVideo[0].data!.isDisliked!;
                                      _likeCount = state.likeVideo[0].data!.likesCount!;
                                      print('>>>>>>>>>>>>>>>>>>      ${_isLiked}');
                                      print('>>>>>>>>>>>>>>>>>>      ${_isDisLiked}');
                                      print('>>>>>>>>>>>>>>>>>>      ${_likeCount}');
                                    }else if(state is DislikeVideoSuccess){
                                      _isLiked = state.dislikeVideo[0].data!.isLiked!;
                                      _isDisLiked = state.dislikeVideo[0].data!.isDisliked!;
                                      _likeCount = state.dislikeVideo[0].data!.likesCount!;
                                      print('^^^^^^^^^^^^^^^^^^      ${_isLiked}');
                                      print('^^^^^^^^^^^^^^^^^^      ${_isDisLiked}');
                                      print('^^^^^^^^^^^^^^^^^^      ${_likeCount}');
                                    }
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
                                                    _isLiked = _isLiked;
                                                    _likeCount = _likeCount;
                                                    print('***********     $_isLiked');
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    _isLiked
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
                                                    _isDisLiked = _isDisLiked;
                                                    print('***********     $_isDisLiked');
                                                  });
                                                },
                                                child: _isDisLiked
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
                              // const LikeDislikeButton(
                              //   initialLikeCount: 5824,
                              // ),
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
            
                              const SaveButton(),
                              SizedBox(
                                  width: ScreenSize.screenWidth(context) *
                                      0.03),
            
                              const ReportButton(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize.screenHeight(context) * 0.02,),
            
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenSize.screenWidth(context) * 0.03,
                              right: ScreenSize.screenWidth(context) * 0.03
                          ),
                          child: InkWell(
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
                                        state.playVideo[0].data!.comments.toString(),
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
                                        backgroundImage: AssetImage(
                                            'assets/images/tmkocteam.jpg'),
                                      ),
                                      SizedBox(
                                        width: ScreenSize.screenWidth(context) *
                                            0.02,),
            
                                      Expanded(
                                        child: Text(
                                          '2035 mein kaun kaun Tarak Mehta dekhna pasand karega :)',
                                          style: TextStyle(
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
                                        channelPhoto: '${recommendedVideos.channel!.logo}',
                                        thumbnailUrl: '${recommendedVideos.thumbnail}',
                                        duration: formattedDuration,
                                        title: '${recommendedVideos.title}',
                                        author: '${recommendedVideos.channel!.name}',
                                        views: '${recommendedVideos.views}',
                                        uploadTime: '${recommendedVideos.createdAtHuman}',
                                        onMorePressed: () {
                                          // Add your onMorePressed logic here
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
                            ShimmerWidget.rectangular(height: 20.h, isBorder: true),
                            SizedBox(height: 2.h,),
                            ShimmerWidget.rectangular(height: 20.h, isBorder: true),
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
                  padding: EdgeInsets.all(10),
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




  // COMMENT DIALOG BOX ****************************************************************************

  void videoCommentSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.605.h,
          child: Column(
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
                        icon: Icon(HeroiconsOutline.xMark),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 0.5, color: Colors.grey.shade300,),
              // SizedBox(height: 10), // Add some spacing if needed
              // Scrollable user comments

              Container(
                height: ScreenSize.screenHeight(context) * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                        // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
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
                                      backgroundImage: AssetImage('assets/images/tmkocteam.jpg'),
                                    ),
                                  ),
                                  SizedBox(width: ScreenSize.screenWidth(context) * 0.015),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            '@Babitaji01 - 2 days ago',
                                            style: TextStyle(
                                              fontFamily: 'YourFontFamily',
                                              fontSize: 12,
                                              color: Colors.grey.shade700,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        SizedBox(height: ScreenSize.screenHeight(context) * 0.005),
                                        Text(
                                          '2035 mein kaun kaun Tarak Mehta dekhna pasand karega :)',
                                          style: TextStyle(
                                            fontFamily: 'YourFontFamily',
                                            fontSize: 14,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),

                                        SizedBox(height: ScreenSize.screenHeight(context) * 0.025),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){},
                                                child: Icon(HeroiconsOutline.handThumbUp, size: 20)
                                            ),
                                            SizedBox(width: ScreenSize.screenWidth(context) * 0.01),
                                            Text('502'),
                                            SizedBox(width: ScreenSize.screenWidth(context) * 0.05),
                                            Icon(HeroiconsOutline.handThumbDown, size: 20),
                                            SizedBox(width: ScreenSize.screenWidth(context) * 0.05),
                                            Icon(HeroiconsOutline.chatBubbleBottomCenterText, size: 20),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(HeroiconsOutline.ellipsisVertical, size: 18),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                  ),
                ),
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
                      backgroundImage: AssetImage('assets/images/sonysab.jpg'),
                    ),
                    SizedBox(width: ScreenSize.screenWidth(context) * 0.02,),

                    InkWell(
                      onTap: (){},
                      child: Container(
                        height: ScreenSize.screenHeight(context) * 0.5,
                        width: ScreenSize.screenWidth(context) * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
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
        );
      },
    );
  }



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