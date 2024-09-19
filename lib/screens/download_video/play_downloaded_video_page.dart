import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_player/pod_player.dart';
import 'package:vimeo_clone/utils/widgets/like_dislike.dart';

import '../../config/constants.dart';
import '../../model/hive_model/downloaded_video_model/downloaded_video_model.dart';
import '../../utils/widgets/download_button.dart';
import '../../utils/widgets/report_button.dart';
import '../../utils/widgets/save_button.dart';
import '../../utils/widgets/share_button.dart';

class PlayDownloadedVideoPage extends StatefulWidget {
  final DownloadedVideoModel downloadedVideo;
  const PlayDownloadedVideoPage({super.key, required this.downloadedVideo});

  @override
  State<PlayDownloadedVideoPage> createState() => _PlayDownloadedVideoPageState();
}

class _PlayDownloadedVideoPageState extends State<PlayDownloadedVideoPage> {

  PodPlayerController? _podController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _podController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(widget.downloadedVideo.videoSource!),
    )..initialise().then((_){
      setState(() {
        _podController!.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [

            SingleChildScrollView(
              padding: EdgeInsets.only(top: 180.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                            '${widget.downloadedVideo.videoTitle}',
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            '${widget.downloadedVideo.videoViews} Views - ${widget.downloadedVideo.videoCreateAtHuman}',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: ScreenSize.screenHeight(context) * 0.01),


                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(
                              left: ScreenSize.screenWidth(context) * 0.03,
                              right: ScreenSize.screenWidth(context) * 0.03,
                            ),
                            child: Row(
                              children: [
                                // BlocBuilder<LikeDislikeVideoBloc, LikeDislikeVideoState>(
                                //     builder: (BuildContext context, LikeDislikeVideoState state){
                                //       if(state is LikeVideoSuccess){}
                                //       else if(state is DislikeVideoSuccess){}
                                //       return IntrinsicWidth(
                                //         child: IntrinsicHeight(
                                //           child: Container(
                                //             decoration: BoxDecoration(
                                //               color: Theme.of(context).colorScheme.surfaceDim,
                                //               borderRadius: BorderRadius.circular(25),
                                //             ),
                                //             padding: EdgeInsets.only(
                                //               left: ScreenSize.screenWidth(context) * 0.03,
                                //               right: ScreenSize.screenWidth(context) * 0.03,
                                //               top: ScreenSize.screenHeight(context) * 0.009,
                                //               bottom: ScreenSize.screenHeight(context) * 0.009,
                                //             ),
                                //             child: Row(
                                //               children: [
                                //                 InkWell(
                                //                   onTap: (){
                                //                     context.read<LikeDislikeVideoBloc>().add(LikeVideoRequest(videoSlug: widget.slug));
                                //                     setState(() {
                                //                       print('((((  $_isDisLiked   )))) ');
                                //                       print('((((  $_isLiked  ))))');
                                //                       if (_isLiked) {
                                //                         _isLiked = false;
                                //                         _likeCount--;
                                //                       } else {
                                //                         ToastManager().showToast(
                                //                             context: context,
                                //                             message: 'Video liked!'
                                //                         );
                                //                         _isLiked = true;
                                //                         _likeCount++;
                                //                         if (_isDisLiked) {
                                //                           _isDisLiked = false;
                                //                         }
                                //                       }
                                //                       print('***********     $_isLiked');
                                //                       print('***********     $_isDisLiked');
                                //                     });
                                //                   },
                                //                   child: Row(
                                //                     children: [
                                //                       _isLiked == true
                                //                           ? const Icon(Remix.thumb_up_fill, size: 17)
                                //                           : const Icon(Remix.thumb_up_line, size: 17),
                                //                       SizedBox(
                                //                         width: MediaQuery.of(context).size.width * 0.02,
                                //                       ),
                                //                       Text(
                                //                         '$_likeCount',
                                //                         style: const TextStyle(
                                //                           fontFamily: fontFamily,
                                //                           fontSize: 12,
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //                 SizedBox(
                                //                   width: MediaQuery.of(context).size.width * 0.01,
                                //                 ),
                                //                 const VerticalDivider(thickness: 0.5),
                                //                 SizedBox(
                                //                   width: MediaQuery.of(context).size.width * 0.01,
                                //                 ),
                                //                 InkWell(
                                //                   onTap: (){
                                //                     context.read<LikeDislikeVideoBloc>().add(DislikeVideoRequest(videoSlug: widget.slug));
                                //                     setState(() {
                                //                       if (_isDisLiked) {
                                //                         _isDisLiked = false;
                                //                       } else {
                                //                         ToastManager().showToast(
                                //                             context: context,
                                //                             message: 'Video disliked!'
                                //                         );
                                //                         _isDisLiked = true;
                                //                         if (_isLiked) {
                                //                           _isLiked = false;
                                //                           _likeCount--;
                                //                         }
                                //                       }
                                //                       print('***********     $_isDisLiked');
                                //                       print('***********     $_isLiked');
                                //                     });
                                //                   },
                                //                   child: _isDisLiked == true
                                //                       ? const Icon(Remix.thumb_down_fill, size: 17)
                                //                       : const Icon(Remix.thumb_down_line, size: 17),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     }
                                // ),

                                LikeDislikeButton(),

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
                                    // onTap: (){
                                    //   context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
                                    //   showPlaylistBottomSheet(state.playVideo);
                                    // },
                                    child: const SaveButton()
                                ),
                                SizedBox(
                                    width: ScreenSize.screenWidth(context) *
                                        0.03),

                                InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {

                                    },
                                    child: const ReportButton()
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenSize.screenHeight(context) * 0.02,),

                          Padding(
                            padding: EdgeInsets.only(
                              left: ScreenSize.screenWidth(context) * 0.03,
                              right: ScreenSize.screenWidth(context) * 0.03,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage('${widget.downloadedVideo.channelLogo}'),
                                  // backgroundImage: NetworkImage('${state.playVideo[0].data!.channel!.logo}'),
                                  // child: Icon(Remix.user_3_line),
                                ),
                                SizedBox(width: ScreenSize.screenWidth(context) * 0.02),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // final String channelId = state.playVideo.first.data!.channel!.id.toString();
                                      // GoRouter.of(context).pushNamed(
                                      //     'channelProfilePage',
                                      //     pathParameters: {
                                      //       'channelId': channelId
                                      //     }
                                      // );
                                      // _podController?.pause();
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${widget.downloadedVideo.channelName}',
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
                                        // Text(
                                        //   _subscribeCount.toString(),
                                        //   style: TextStyle(
                                        //     fontFamily: fontFamily,
                                        //     fontSize: 12,
                                        //     color: Colors.grey[700],
                                        //   ),
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ScreenSize.screenWidth(context) * 0.02),

                              ],
                            ),
                          ),
                          SizedBox(height: ScreenSize.screenHeight(context) * 0.02),
                        ],
                      ),
                    ),
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
                                widget.downloadedVideo.videoLikes!,
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
                                widget.downloadedVideo.videoViews!,
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
                                '14 sep',
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
                    // decoration: BoxDecoration(
                    //     color: Theme.of(context).colorScheme.surfaceDim,
                    //     borderRadius: BorderRadius.circular(10)
                    // ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.downloadedVideo.videoDescription!,
                      style: TextStyle(
                        fontFamily: fontFamily
                      ),
                    ),
                  )
                ],
              ),
            ),




              AspectRatio(
                aspectRatio: 16/9,
                child: _podController == null
                    ? const Center(child: CircularProgressIndicator())
                    : PodVideoPlayer(
                  controller: _podController!,
                ),
              )
            ],
          )
      ),
    );
  }
}
