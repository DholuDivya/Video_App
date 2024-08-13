// import 'package:flutter/material.dart';
// import 'package:heroicons_flutter/heroicons_flutter.dart';
// import 'package:vimeo_clone/config/constants.dart';
// import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';
// import 'package:vimeo_clone/utils/widgets/custom_for_you_preview.dart';
//
// class HomePreviewPage extends StatefulWidget {
//   const HomePreviewPage({super.key});
//
//   @override
//   State<HomePreviewPage> createState() => _HomePreviewPageState();
// }
//
// class _HomePreviewPageState extends State<HomePreviewPage> {
//   List<Map<String, dynamic>> videoList = [
//     {"thumbnail": "assets/images/tmkoc10.jpg", "views": "1.2M"},
//     {"thumbnail": "assets/images/tmkoc9.jpg", "views": "876K"},
//     {"thumbnail": "assets/images/tmkoc8.jpg", "views": "1M"},
//     {"thumbnail": "assets/images/tmkoc7.jpg", "views": "432K"},
//     {"thumbnail": "assets/images/tmkoc6.jpg", "views": "200K"},
//     {"thumbnail": "assets/images/tmkoc5.jpg", "views": "56.9K"},
//     {"thumbnail": "assets/images/tmkoc4.jpg", "views": "103K"},
//     {"thumbnail": "assets/images/tmkoc3.jpg", "views": "760K"},
//     {"thumbnail": "assets/images/tmkoc2.jpg", "views": "1.2M"},
//     {"thumbnail": "assets/images/tmkoc1.jpg", "views": "144K"},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       // physics: NeverScrollableScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//
//           // FOR YOU WIDGET
//           Padding(
//             padding: EdgeInsets.only(
//               top: ScreenSize.screenHeight(context) * 0.015,
//               left: ScreenSize.screenWidth(context) * 0.044,
//               bottom: ScreenSize.screenHeight(context) * 0.015
//             ),
//             child: Text('For You',
//               style: TextStyle(
//                 fontFamily: fontFamily,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//
//           ForYouPreview(
//               videoTitle: 'Tarak Mehta ka Ooltah Chashma - Episode 2384',
//               channelName: 'Sony Sab',
//               uploadTime: '4 days ago'
//           ),
//
//
//           // VIDEO WIDGET IN HOME PREVIEW OF CHANNEL PROFILE PAGE
//           Padding(
//             padding: EdgeInsets.only(
//                 top: ScreenSize.screenHeight(context) * 0.015,
//                 left: ScreenSize.screenWidth(context) * 0.044,
//                 bottom: ScreenSize.screenHeight(context) * 0.015
//             ),
//             child: Text('Videos',
//               style: TextStyle(
//                 fontFamily: fontFamily,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//
//           ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               padding: EdgeInsets.zero,
//               itemCount: videoList.length,
//               itemBuilder: (BuildContext context, int index){
//                 return CustomVideoPreview(
//                     imageUrl: videoList[index]['thumbnail'],
//                     videoTitle: 'Tarak Mehta ka Ooltah Chashma Episode - 220',
//                     videoViews: videoList[index]['views'],
//                     uploadTime: 5,
//                     videoDuration: '29:33'
//                 );
//               }
//           )
//         ],
//       ),
//     );
//   }
// }


















import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/custom_for_you_preview.dart';

class HomePreviewPage extends StatefulWidget {
  final GetChannelDetailModel channelData;
  const HomePreviewPage({super.key, required this.channelData});

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
      builder: (BuildContext context, ChannelProfileState state) {
        if(state is ChannelProfileLoaded){
          final videoDataLength = widget.channelData.videoCount;
          final isAssociated = widget.channelData.isAssociated;
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    isAssociated == false ? Padding(
                      padding: EdgeInsets.only(
                        top: ScreenSize.screenHeight(context) * 0.015,
                        left: ScreenSize.screenWidth(context) * 0.044,
                        bottom: ScreenSize.screenHeight(context) * 0.015,
                      ),
                      child: Text(
                        'For You',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ) : Container(),
                    isAssociated == false ? Container(
                      height: ScreenSize.screenHeight(context) * 0.285,
                      child: ListView.builder(
                        shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: ScreenSize.screenWidth(context) * 0.04
                          ),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.channelData.suggestedVideos!.length,
                          itemBuilder: (context, index){
                          final suggestedVideo = widget.channelData.suggestedVideos![index];
                            return  ForYouPreview(
                              videoThumbnail: suggestedVideo.thumbnails!,
                              videoTitle: '${suggestedVideo.title}',
                              channelName: '${widget.channelData.channel!.name}',
                              uploadTime: '${suggestedVideo.createdAtHuman}',
                            );
                      }),
                    ) : Container(),

                    Padding(
                      padding: EdgeInsets.only(
                        top: ScreenSize.screenHeight(context) * 0.015,
                        left: ScreenSize.screenWidth(context) * 0.044,
                        bottom: ScreenSize.screenHeight(context) * 0.015,
                      ),
                      child: Text(
                        'Videos',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: videoDataLength! + 1,
                      (BuildContext context, int index) {
                        if (index == videoDataLength) {
                          return SizedBox(height: 12.h,);
                          // return Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Center(
                          //       child: Text(
                          //         'no videos found',
                          //         style: TextStyle(
                          //           fontFamily: fontFamily,
                          //           color: greyShade500,
                          //           fontSize: 15
                          //         ),
                          //       )
                          //   ),
                          // );
                        }

                        final videoData = widget.channelData.channel!.videos?[index];
                        final totalSeconds = videoData!.duration;
                        final formattedTime = formatDuration(totalSeconds!);
                    return CustomVideoPreview(
                      imageUrl: '${videoData.thumbnails}',
                      videoTitle: '${videoData.title}',
                      videoViews: '${videoData.views.toString()}',
                      uploadTime: '${videoData.createdAtHuman}',
                      videoDuration: formattedTime,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
