// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:heroicons_flutter/heroicons_flutter.dart';
// import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
// import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
// import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
// import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
// import 'package:vimeo_clone/config/constants.dart';
// import '../../../utils/widgets/customBottomSheet.dart';
// import '../../../utils/widgets/custom_channel_video_preview.dart';
// import '../../../utils/widgets/custom_for_you_preview.dart';
// import '../../../utils/widgets/custom_report_dialog.dart';
//
// class HomePreviewPage extends StatefulWidget {
//   const HomePreviewPage({super.key});
//
//   @override
//   State<HomePreviewPage> createState() => _HomePreviewPageState();
// }
//
// class _HomePreviewPageState extends State<HomePreviewPage> {
//   List<Map<String, dynamic>> bottomSheetListTileField = [
//     {'name': 'Save to playlist', 'icon': HeroiconsOutline.bookmark},
//     {'name': 'Download video', 'icon': HeroiconsOutline.arrowDownTray},
//     {'name': 'Share', 'icon': HeroiconsOutline.share},
//     {'name': 'Report', 'icon': HeroiconsOutline.chatBubbleBottomCenterText},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
//       builder: (BuildContext context, ChannelProfileState state) {
//         if (state is ChannelProfileLoaded) {
//           final isAssociated = state.channelData.first.isAssociated;
//
//           return CustomScrollView(
//             slivers: [
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     if (!isAssociated!)
//                       Padding(
//                         padding: EdgeInsets.only(
//                           top: ScreenSize.screenHeight(context) * 0.015,
//                           left: ScreenSize.screenWidth(context) * 0.044,
//                           bottom: ScreenSize.screenHeight(context) * 0.015,
//                         ),
//                         child: const Text(
//                           'For You',
//                           style: TextStyle(
//                             fontFamily: fontFamily,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     if (!isAssociated)
//                       SliverToBoxAdapter(
//                         child: SizedBox(
//                           height: ScreenSize.screenHeight(context) * 0.285,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.only(
//                               left: ScreenSize.screenWidth(context) * 0.04,
//                             ),
//                             scrollDirection: Axis.horizontal,
//                             itemCount:
//                             state.channelData.first.suggestedVideos!.length,
//                             itemBuilder: (context, index) {
//                               final suggestedVideo =
//                               state.channelData.first.suggestedVideos![index];
//                               final type = suggestedVideo.type;
//                               return type == "video"
//                                   ? ForYouPreview(
//                                 videoThumbnail: suggestedVideo.thumbnails!,
//                                 videoTitle: suggestedVideo.title!,
//                                 channelName:
//                                 state.channelData.first.channel!.name!,
//                                 uploadTime:
//                                 suggestedVideo.createdAtHuman!,
//                               )
//                                   : Container();
//                             },
//                           ),
//                         ),
//                       ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: ScreenSize.screenHeight(context) * 0.015,
//                         left: ScreenSize.screenWidth(context) * 0.044,
//                         bottom: ScreenSize.screenHeight(context) * 0.015,
//                       ),
//                       child: const Text(
//                         'Videos',
//                         style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               BlocBuilder<YourVideosBloc, YourVideosState>(
//                 builder: (BuildContext context, YourVideosState state) {
//                   if (state is YourVideosLoaded) {
//                     final videoDataLength = state.yourVideoData.length;
//                     return SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                             (BuildContext context, int index) {
//                           if (index == videoDataLength) {
//                             return SizedBox(height: 12.h);
//                           }
//
//                           final videoData = state.yourVideoData[index];
//                           final totalSeconds = videoData.duration;
//                           final formattedTime = formatDuration(totalSeconds!);
//
//                           return Padding(
//                             padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
//                             child: CustomVideoPreview(
//                               imageUrl: videoData.thumbnail!,
//                               videoTitle: videoData.title!,
//                               videoViews: videoData.views.toString(),
//                               uploadTime: '${videoData.createdAtHuman}',
//                               videoDuration: formattedTime,
//                               onShowMorePressed: () {
//                                 customShowMoreBottomSheet(
//                                   context,
//                                   bottomSheetListTileField,
//                                       (int index) {
//                                     if (index == 3) {
//                                       if (Navigator.canPop(context)) {
//                                         Navigator.pop(context);
//                                       }
//                                       showReportDialog(context, videoData.id!);
//                                     }
//                                   },
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         childCount: videoDataLength + 1,
//                       ),
//                     );
//                   }
//                   return SliverToBoxAdapter(
//                     child: Container(),
//                   );
//                 },
//               ),
//             ],
//           );
//         }
//         return Container();
//       },
//     );
//   }
//
//   void showReportDialog(BuildContext context, int videoId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomReportDialog(videoId: videoId);
//       },
//     );
//   }
// }
//











import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import '../../../utils/widgets/customBottomSheet.dart';
import '../../../utils/widgets/custom_channel_video_preview.dart';
import '../../../utils/widgets/custom_for_you_preview.dart';
import '../../../utils/widgets/custom_report_dialog.dart';

class HomePreviewPage extends StatefulWidget {
  const HomePreviewPage({super.key});

  @override
  State<HomePreviewPage> createState() => _HomePreviewPageState();
}

class _HomePreviewPageState extends State<HomePreviewPage> {
  List<Map<String, dynamic>> videoList = [
    {"thumbnail": "assets/images/tmkoc10.jpg", "views": "1.2M"},
    {"thumbnail": "assets/images/tmkoc9.jpg", "views": "876K"},
    {"thumbnail": "assets/images/tmkoc8.jpg", "views": "1M"},
    {"thumbnail": "assets/images/tmkoc7.jpg", "views": "432K"},
    {"thumbnail": "assets/images/tmkoc6.jpg", "views": "200K"},
    {"thumbnail": "assets/images/tmkoc5.jpg", "views": "56.9K"},
    {"thumbnail": "assets/images/tmkoc4.jpg", "views": "103K"},
    {"thumbnail": "assets/images/tmkoc3.jpg", "views": "760K"},
    {"thumbnail": "assets/images/tmkoc2.jpg", "views": "1.2M"},
    {"thumbnail": "assets/images/tmkoc1.jpg", "views": "144K"},
  ];

  List<Map<String, dynamic>> bottomSheetListTileField = [
    {'name': 'Save to playlist', 'icon': HeroiconsOutline.bookmark},
    {'name': 'Download video', 'icon': HeroiconsOutline.arrowDownTray},
    {'name': 'Share', 'icon': HeroiconsOutline.share},
    {'name': 'Report', 'icon': HeroiconsOutline.chatBubbleBottomCenterText},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
      builder: (BuildContext context, ChannelProfileState state) {
        if (state is ChannelProfileLoaded) {
          final channelData = state.channelData;

          if (channelData != null && channelData.isNotEmpty) {
            final isAssociated = channelData.first.isAssociated;

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (!isAssociated!)
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenSize.screenHeight(context) * 0.015,
                            left: ScreenSize.screenWidth(context) * 0.044,
                            bottom: ScreenSize.screenHeight(context) * 0.015,
                          ),
                          child: const Text(
                            'For You',
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      if (!isAssociated)
                        SizedBox(
                          height: ScreenSize.screenHeight(context) * 0.285,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                left: ScreenSize.screenWidth(context) * 0.04),
                            scrollDirection: Axis.horizontal,
                            itemCount: channelData.first.suggestedVideos?.length ?? 0,
                            itemBuilder: (context, index) {
                              final suggestedVideo = channelData.first.suggestedVideos![index];
                              final type = suggestedVideo.type;
                              if (type == "video") {
                                return ForYouPreview(
                                  videoThumbnail: suggestedVideo.thumbnails!,
                                  videoTitle: suggestedVideo.title!,
                                  channelName: channelData.first.channel!.name!,
                                  uploadTime: suggestedVideo.createdAtHuman!,
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenSize.screenHeight(context) * 0.015,
                          left: ScreenSize.screenWidth(context) * 0.044,
                          bottom: ScreenSize.screenHeight(context) * 0.015,
                        ),
                        child: const Text(
                          'Videos',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<YourVideosBloc, YourVideosState>(
                  builder: (BuildContext context, YourVideosState state) {
                    if (state is YourVideosLoaded) {
                      final videoDataLength = state.yourVideoData.length;

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: videoDataLength + 1,
                              (BuildContext context, int index) {
                            if (index == videoDataLength) {
                              return SizedBox(height: 12.h);
                            }

                            final videoData = state.yourVideoData[index];
                            final totalSeconds = videoData.duration;
                            final formattedTime =
                            totalSeconds != null ? formatDuration(totalSeconds) : 'N/A';

                            return Padding(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: CustomVideoPreview(
                                imageUrl: videoData.thumbnail!,
                                videoTitle: videoData.title!,
                                videoViews: videoData.views.toString(),
                                uploadTime: '${videoData.createdAtHuman}',
                                videoDuration: formattedTime,
                                onShowMorePressed: () {
                                  customShowMoreBottomSheet(
                                    context,
                                    bottomSheetListTileField,
                                        (int index) {
                                      if (index == 0) {}
                                      else if (index == 1) {}
                                      else if (index == 2) {}
                                      else if (index == 3) {
                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                        showReportDialog(context, videoData.id!);
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container(
                      // color: yellow,
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // color: red,
                              height: 120.h,
                              width: 240.w,
                              child: Image.asset('assets/images/no_data.png'),
                            ),
                            Text(
                              'Videos not found !!',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 15.sp
                              ),
                            ),
                          ],
                        ),)
                    ); // Empty state for YourVideosBloc
                  },
                ),
              ],
            );
          } else {
            return Container(); // Empty state for ChannelProfileBloc
          }
        }
        return Container(); // Empty state while loading
      },
    );
  }

  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomReportDialog(videoId: videoId);
      },
    );
  }
}

