import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import '../../../utils/widgets/customBottomSheet.dart';
import '../../../utils/widgets/custom_channel_video_preview.dart';
import '../../../utils/widgets/custom_for_you_preview.dart';
import '../../../utils/widgets/custom_report_dialog.dart';

class HomePreviewPage extends StatefulWidget {
  // final GetChannelDetailModel channelData;
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
    {
      'name': 'Save to playlist',
      'icon': HeroiconsOutline.bookmark
    },
    {
      'name': 'Download video',
      'icon': HeroiconsOutline.arrowDownTray
    },
    {
      'name': 'Share',
      'icon': HeroiconsOutline.share
    },
    {
      'name': 'Report',
      'icon': HeroiconsOutline.chatBubbleBottomCenterText
    },
  ];



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
      builder: (BuildContext context, ChannelProfileState state) {
        if(state is ChannelProfileLoaded){
          // final videoDataLength = widget.channelData.videoCount;
          // final isAssociated = widget.channelData.isAssociated;
          final videoDataLength = state.channelData.first.channelVideos.length;
          final isAssociated = state.channelData.first.isAssociated;
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
                      child: const Text(
                        'For You',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ) : Container(),
                    isAssociated == false ? SizedBox(
                      height: ScreenSize.screenHeight(context) * 0.285,
                      child: ListView.builder(
                        shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: ScreenSize.screenWidth(context) * 0.04
                          ),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.channelData.first.suggestedVideos.length,
                          itemBuilder: (context, index){
                          final suggestedVideo = state.channelData.first.suggestedVideos[index];
                          final type = suggestedVideo.type;
                          print('sssssssssssssss    ${state.channelData.first.suggestedVideos.length}');
                            return  type == "video" ? ForYouPreview(
                              videoThumbnail: suggestedVideo.thumbnails,
                              videoTitle: suggestedVideo.title,
                              channelName: state.channelData.first.channel.name,
                              uploadTime: suggestedVideo.createdAtHuman,
                            ) : Container();
                      }),
                    ) : Container(),

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
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: videoDataLength + 1,
                      (BuildContext context, int index) {
                    print('&&&&&&&&&&&&&    $videoDataLength  ');
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

                        final videoData = state.channelData.first.channelVideos[index];
                        final totalSeconds = videoData.duration;
                        final formattedTime = formatDuration(totalSeconds);
                    return Padding(
                      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: CustomVideoPreview(
                        imageUrl: videoData.thumbnails,
                        videoTitle: videoData.title,
                        videoViews: videoData.views.toString(),
                        uploadTime: '${videoData.createdAtHuman}',
                        videoDuration: formattedTime,
                        onShowMorePressed: (){
                          customShowMoreBottomSheet(
                            context,
                            bottomSheetListTileField,
                                (int index) {
                              if (index == 0) {

                              } else if (index == 1) {
                                // GoRouter.of(context).pushNamed('settingPage');
                              }else if(index == 3){
                                if(Navigator.canPop(context)){
                                  Navigator.pop(context);
                                }
                                showReportDialog(context, videoData.id);
                              }
                            },
                          );
                          // customShowMoreBottomSheet(
                          //     context,
                          //     bottomSheetListTileField,
                          //         (int index){
                          //       if(index == 0){
                          //         if(Navigator.canPop(context)){
                          //           Navigator.pop(context);
                          //         }
                          //         GoRouter.of(context).pushNamed(
                          //             'editVideoDetailPage',
                          //             pathParameters: {
                          //               'slug': videoData.slug
                          //             }
                          //         );
                          //       }
                          //     }
                          // );
                        },
                      ),
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

  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomReportDialog(videoId: videoId,);
      },
    );
  }

}
