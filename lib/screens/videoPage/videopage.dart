import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:readmore/readmore.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_bloc.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_event.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_bloc.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_event.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_state.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
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
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_state.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_bloc.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_event.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/Utils/Widgets/download_button.dart';
import 'package:vimeo_clone/Utils/Widgets/report_button.dart';
import 'package:vimeo_clone/Utils/Widgets/save_button.dart';
import 'package:vimeo_clone/Utils/Widgets/share_button.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/Utils/Widgets/video_container.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/model/play_video_model.dart';
import '../../bloc/add_user_history/add_user_history_bloc.dart';
import '../../bloc/add_user_history/add_user_history_event.dart';
import 'package:floating/floating.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/widgets/custom_report_dialog.dart';
import '../../utils/widgets/custom_save_to_playlist.dart';


class VideoPage extends StatefulWidget {
  final String slug;
  const VideoPage({super.key, required this.slug});

  @override
  State<VideoPage> createState() => _VideoPageState();
}


class _VideoPageState extends State<VideoPage>  with SingleTickerProviderStateMixin {

  late Floating floating;
  static const platform = MethodChannel('com.cineplex.app/pip');
  PodPlayerController? _podController;
  late bool _isSubscribed = false;
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

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  final userChannelId = Global.userData!.userChannelId;





  @override
  void initState() {
    super.initState();
    floating = Floating();
    context.read<PlayVideoBloc>().add(GetVideoSlugEvent(slug: widget.slug));
    context.read<GetCommentsBloc>().add(GetCommentsRequest(videoSlug: widget.slug));

    initBannerAd();
    print('-------------------    $commentLength');
    final commentBloc = context.read<GetCommentsBloc>();
    commentBloc.stream.listen((state){
      print('kgsrbhjodsjnbdjnboidjjdodinb');

      if(state is GetCommentsLoaded){
        commentLength = state.getCommentsList.length;
        commentData = state.getCommentsList;
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
              playVideoFrom: videoData.uploadSourceType == "youtube"
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


  initBannerAd(){
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-2734509756038446/1670883979",
        listener: BannerAdListener(
          onAdLoaded: (ad){
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error){
            ad.dispose();
            print(error);
          }
        ),
        request: const AdRequest()
    );

    bannerAd.load();
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


  Future<void> enterPipMode() async {
    try {
      await platform.invokeMethod('enterPiP');
    } on PlatformException catch (e) {
      print("Failed to enter PiP mode: '${e.message}'.");
    }
  }


  Future<void> enablePip(BuildContext context, {bool autoEnable = false}) async {
    final rational = Rational.landscape();
    final screenSize = MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio;
    final height = screenSize.width ~/ rational.aspectRatio;

    final sourceRectHint = Rectangle<int>(
      0,
      (screenSize.height ~/ 2) - (height ~/ 2),
      screenSize.width.toInt(),
      height,
    );

    final arguments = autoEnable
        ? OnLeavePiP(aspectRatio: rational, sourceRectHint: sourceRectHint)
        : ImmediatePiP(aspectRatio: rational, sourceRectHint: sourceRectHint);

    final status = await floating.enable(arguments);
    debugPrint('PiP enabled? $status');
  }



  // => enablePip(context),

  @override
  Widget build(BuildContext context) {

    // downloading
    //     ? Container(
    //   height: 120.0,
    //   width: 200.0,
    //   child: Card(
    //     color: Colors.black,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         CircularProgressIndicator(),
    //         SizedBox(
    //           height: 20.0,
    //         ),
    //         Text(
    //           "Downloading File: $progressString",
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // )
    //     : Text("No Data");


    return PiPSwitcher(
      childWhenEnabled: BlocBuilder<PlayVideoBloc, PlayVideoState>(
        builder: (BuildContext context, PlayVideoState state) {
          if (state is PlayVideoLoaded) {
            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AspectRatio(
              aspectRatio: 16 / 9,
              child: _podController == null
                ? const Center(child: CircularProgressIndicator())
                : PodVideoPlayer(
                    controller: _podController!,
                  ),
              ),
            );
          }
        return const Center(child: CircularProgressIndicator());
      },
      ),
      childWhenDisabled: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<PlayVideoBloc, PlayVideoState>(
                builder: (BuildContext context, state) {
                  if(state is PlayVideoLoaded) {
                    final data = state.playVideo[0].data!;
                    _channelId = data.channel!.id!;
                    channelLogo = state.playVideo[0].data!.channel!.logo!;
                    final isAssociated = state.playVideo[0].data!.channel!.isAssociated;
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
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),



                                // Row(
                                    //   children: [
                                    //     Container(
                                    //       // color: red,
                                    //       constraints: BoxConstraints(
                                    //         maxWidth: 260.w
                                    //       ),
                                    //       height: 30.h,
                                    //       child: Row(
                                    //         children: [
                                    //           Text(
                                    //             '${state.playVideo[0].data!.views} Views - ',
                                    //             style: TextStyle(
                                    //               fontFamily: fontFamily,
                                    //               fontSize: 12.sp,
                                    //               color: Colors.grey[700],
                                    //             ),
                                    //             maxLines: 1,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //
                                    //           Text(
                                    //             '${state.playVideo[0].data!.createdAtHuman}',
                                    //             style: TextStyle(
                                    //               fontFamily: fontFamily,
                                    //               fontSize: 12.sp,
                                    //               color: Colors.grey[700],
                                    //             ),
                                    //             maxLines: 1,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //
                                    //
                                    //           Text(
                                    //             ' -  ${state.playVideo[0].data!.description!.trim()}',
                                    //             style: TextStyle(
                                    //               fontFamily: fontFamily,
                                    //               fontSize: 12.sp,
                                    //               color: Colors.grey[700],
                                    //             ),
                                    //             maxLines: 1,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //
                                    //           Text(
                                    //             ' ${state.playVideo[0].data!.hashtag}',
                                    //             style: TextStyle(
                                    //               fontFamily: fontFamily,
                                    //               fontSize: 12.sp,
                                    //               color: Colors.grey[700],
                                    //             ),
                                    //             maxLines: 1,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //
                                    //
                                    //
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       '...more',
                                    //       style: TextStyle(
                                    //         fontFamily: fontFamily,
                                    //         fontSize: 12.sp,
                                    //         color: Colors.grey[700],
                                    //       ),
                                    //       maxLines: 1,
                                    //     ),
                                    //   ],
                                    // ),


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
      
      
                                isAssociated == false ? BlocBuilder<SubscribeChannelBloc, SubscribeChannelState>(
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
                                              message: AppLocalizations.of(context)!.unsubscribedSuccessfully
                                          );
                                          context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: _channelId));
                                        } else {
                                          ToastManager().showToast(
                                              context: context,
                                              message: AppLocalizations.of(context)!.subscribedSuccessfully
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
                                            _isSubscribed ? AppLocalizations.of(context)!.unsubscribe : AppLocalizations.of(context)!.subscribe,
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
                                ) : Container(),
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
                                                            message: AppLocalizations.of(context)!.videoLiked
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
                                                            message: AppLocalizations.of(context)!.videoDisliked
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
                                    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                    showPlaylistBottomSheet(state.playVideo.first.data!.id!, userChannelId!);
                                  },
                                    child: const SaveButton()
                                ),
                                SizedBox(
                                    width: ScreenSize.screenWidth(context) *
                                        0.03),
              
                                InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      showReportDialog(context, state.playVideo.first.data!.id!);
                                    },
                                      child: const ReportButton()
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenSize.screenHeight(context) * 0.02,),
      
      
                          commentLength != 0 ? BlocBuilder<GetCommentsBloc, GetCommentsState>(
                            builder: (BuildContext context, GetCommentsState state) {
                              if(state is GetCommentsLoaded){
                                final getComments = state.getCommentsList;
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
                                                  AppLocalizations.of(context)!.comments,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  )
                                              ),
                                              SizedBox(
                                                width: ScreenSize.screenWidth(context) *
                                                    0.02,),
                                              Text(
                                                getComments.length.toString(),
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
                              return Container();
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
                                          AppLocalizations.of(context)!.comments,
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
                                                child: Text(
                                                    AppLocalizations.of(context)!.addAComment,
                                                  style: TextStyle(
                                                    fontFamily: fontFamily,
                                                  ),
                                                )
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
                                    onShowMorePressed: (){},
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
                      return isAdLoaded ? SizedBox(
                        height: bannerAd.size.height.toDouble(),
                        width: bannerAd.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd),
                      )
                          : Positioned(
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
        floatingActionButton: isAdLoaded ? SizedBox(
          height: bannerAd.size.height.toDouble(),
          width: bannerAd.size.width.toDouble(),
          child: AdWidget(ad: bannerAd),
        ) : SizedBox(),
      ),
    );

  }




  // DESCRIPTION DIALOG BOX **********************************************************************
  void videoDescriptionSheet(BuildContext context, PlayVideoModel descriptionData ) {

    final videoCreatedDate = descriptionData.data!.categories?[0].createdAt;
    final hashtag = descriptionData.data!.hashtag;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18.sp
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

                const Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),


                // VIDEO TITLE -------------------------------------------------
                Text(
                    '${descriptionData.data!.description!.trim()}',
                  style: const TextStyle(
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
                    height: ScreenSize.screenHeight(context) * 0.06,
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
                                  fontSize: 15.sp
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Icon(HeroiconsOutline.handThumbUp, size: 18.r, color: Theme.of(context).colorScheme.secondaryFixedDim,)
                            ],
                          ),

                          SizedBox(height: 5.h,),
                          Column(
                            children: [
                              Text(
                                descriptionData.data!.views.toString(),
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15.sp
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Icon(HeroiconsOutline.eye, size: 18.r, color: Theme.of(context).colorScheme.secondaryFixedDim)
                            ],
                          ),


                          Column(
                            children: [
                              Text(
                                formattedDate,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15.sp
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Icon(HeroiconsOutline.calendarDays, size: 18.r, color: Theme.of(context).colorScheme.secondaryFixedDim)
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
                    // height: ScreenSize.screenHeight(context) * 0.03,
                    // width: ScreenSize.screenWidth(context) * 0.9,
                    //
                    //
                    //
                    //   child: Container(
                    //     padding: EdgeInsets.all(8),
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: Theme.of(context).colorScheme.tertiaryFixedDim,
                    //     ),
                    //     child: Wrap(
                    //       spacing: 8.0,
                    //       runSpacing: 4.0,
                    //       children: _hashtags
                    //           .map((hashtag) => Chip(
                    //         backgroundColor: Theme.of(context)
                    //             .colorScheme
                    //             .surfaceDim,
                    //         side: BorderSide(
                    //             width: 0, color: Colors.grey.shade600),
                    //         label: Text(
                    //           hashtag,
                    //           style: TextStyle(
                    //               fontFamily: fontFamily,
                    //               color: Colors.grey.shade600),
                    //         ),
                    //         deleteIconColor: Colors.grey.shade700,
                    //         onDeleted: () {
                    //           setState(() {
                    //             _hashtags.remove(hashtag);
                    //             _hashtagController.text =
                    //                 _hashtags.join(' ') + ' ';
                    //           });
                    //         },
                    //       ))
                    //           .toList(),
                    //     ),
                    //   )
                    //
                    // color: red,
                    child: Row(
                      children: [
                        VideoHashtag(
                            hashtag: 'tarakmehta'
                        ),
                        SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),

                        VideoHashtag(
                            hashtag: 'tmkocsmileofindia'
                        ),
                        SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),

                        VideoHashtag(
                            hashtag: 'tmkoc'
                        ),
                        SizedBox(width: ScreenSize.screenWidth(context) * 0.01,),
                      ],
                    ),
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
                    descriptionData.data!.description!.trim(),
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



  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomReportDialog(videoId: videoId,);
      },
    );
  }



  void showPlaylistBottomSheet(int videoId, String userChannelId){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) {
        return PlaylistBottomSheet(
            videoId: videoId, // Pass your video data
          userChannelId: userChannelId, // Pass your user channel ID
        );
      },
    ).whenComplete((){
      context.read<PlaylistSelectionBloc>().add(ClearPlaylistSelectionRequest());
      context.read<AddVideoToPlaylistBloc>().add(InitializePlaylistBloc());
    });
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
                          Text(
                            AppLocalizations.of(context)!.comments,
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
                          child: Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                // Check if the user has scrolled to the end and load more notes if needed
                                if (!state.hasReachedMax &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  context.read<GetCommentsBloc>().add(
                                      LoadMoreGetComments());
                                }
                                return false;
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                // scrollDirection: Axis.vertical,
                                itemCount: state.hasReachedMax
                                    ? state.getCommentsList.length
                                    : state.getCommentsList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                            

                            
                                  if (index < state.getCommentsList.length) {
                                    final getComments = state.getCommentsList[index];
                                    commentLikeCount = getComments.likesCount!;
                                    isCommentLiked = getComments.isLiked!;
                                    isCommentDisliked = getComments.isDisliked!;

                                    print('uuuuuuuu     ${state.getCommentsList.length}');

                                    print('00000000      $index');
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
                                                                  message: AppLocalizations.of(context)!.commentLiked
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
                                                                  message: AppLocalizations.of(context)!.commentDisliked
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
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                            

                                },
                              ),
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
                                    AppLocalizations.of(context)!.addAComment,
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
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 5.w,
            right: 5.w,
            // top: 5.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    hintText: AppLocalizations.of(context)!.addComment,
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
                        var text = _commentController.text;
                        if (text.isNotEmpty) {
                          context.read<AddCommentBloc>().add(AddCommentRequest(
                            userComment: text,
                            videoSlug: widget.slug,
                          ));
                          text = '';
                          ToastManager().showToast(
                            context: context,
                            message: AppLocalizations.of(context)!.commentAddedSuccessfully,
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
                        message: AppLocalizations.of(context)!.commentAddedSuccessfully,
                      );

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
                hintText: AppLocalizations.of(context)!.addComment,
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


class VideoHashtag extends StatelessWidget {
  final String hashtag;
  const VideoHashtag({super.key, required this.hashtag});

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
        '#${hashtag}',
        style: TextStyle(
          // fontFamily: fontFamily,
          fontSize: 12,
        ),
      ),
    );
  }
}






