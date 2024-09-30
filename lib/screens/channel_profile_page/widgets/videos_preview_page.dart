import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/customBottomSheet.dart';
import 'package:vimeo_clone/utils/widgets/custom_channel_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/latest_popular_oldest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../bloc/channel_profile/channel_profile_bloc.dart';
import '../../../bloc/channel_profile/channel_profile_state.dart';
import '../../../config/global_variable.dart';
import '../../../utils/widgets/custom_save_to_playlist.dart';
import '../../homePage/homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VideosPreviewPage extends StatefulWidget {
  final int channelId;
  const VideosPreviewPage({super.key, required this.channelId});

  @override
  State<VideosPreviewPage> createState() => _VideosPreviewPageState();
}

class _VideosPreviewPageState extends State<VideosPreviewPage> {
  int selectedIndex = 0;
  final userChannelId = Global.userData!.userChannelId;

  List<Map<String, dynamic>> sortList = [
    {"type": "Latest", "isSelected": true},
    {"type": "Popular", "isSelected": false},
    {"type": "Oldest", "isSelected": false},
  ];

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

  List<Map<String, dynamic>> sortedVideoList = [];

  // List<Videos> sortVideos(List<Videos> videos, String sortType) {
  //   switch (sortType) {
  //     case "Latest":
  //       videos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  //       break;
  //     case "Popular":
  //       videos.sort((a, b) => b.views!.compareTo(a.views!));
  //       break;
  //     case "Oldest":
  //       videos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  //       break;
  //   }
  //   return videos;
  // }

  void _onSortTypeChanged(int index) {
    setState(() {
      selectedIndex = index;
      sortList.forEach((item) => item['isSelected'] = false);
      sortList[selectedIndex]['isSelected'] = true;
    });
  }

  List<Map<String, dynamic>> bottomSheetListTileField = [
    {'name': 'Edit video detail', 'icon': HeroiconsOutline.bookmark},
    {'name': 'Save to playlist', 'icon': HeroiconsOutline.arrowDownTray},
    {'name': 'Share', 'icon': HeroiconsOutline.share},
    {'name': 'Report', 'icon': HeroiconsOutline.chatBubbleBottomCenterText},
  ];


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

  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(videoId: videoId,);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // String selectedSortType = sortList[selectedIndex]['type'];
    // List<Videos> sortedVideos = sortVideos(widget.channelData.channel!.videos!, selectedSortType);

    return BlocBuilder<YourVideosBloc, YourVideosState>(
      builder: (BuildContext context, YourVideosState state) {
        if (state is YourVideosLoaded) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: state.yourVideoData.isNotEmpty
                ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSize.screenHeight(context) * 0.01,
                      left: ScreenSize.screenWidth(context) * 0.015),
                  child: VideoSortCategory(
                      sortCategoryList: sortList,
                      selectedIndex: selectedIndex,
                      onCategorySelected: (index) {}),
                ),
                ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: ScreenSize.screenHeight(context) * 0.01,
                        ),
                        itemCount: state.yourVideoData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final videoData = state.yourVideoData[index];
                          final totalSeconds = videoData.duration;
                          final formattedDuration =
                              formatDuration(totalSeconds!);
                          return Padding(
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            child: CustomVideoPreview(
                              imageUrl: videoData.thumbnail!,
                              videoTitle: videoData.title!,
                              videoViews: '${videoData.views}',
                              uploadTime: videoData.createdAtHuman!,
                              videoDuration: formattedDuration,
                              onShowMorePressed: () {
                                customShowMoreBottomSheet(
                                    context, bottomSheetListTileField,
                                    (int index) {
                                  if (index == 0) {
                                    GoRouter.of(context).pushNamed('editVideoDetailPage');
                                  }
                                  else if (index == 1) {
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                    }
                                    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                    showPlaylistBottomSheet(videoData.id!, userChannelId!);
                                  }
                                  else if (index == 2) {
                                    final String appLink = '${baseUrl}share?video=${videoData.slug}';
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                    }
                                    // Use the share_plus package to share the link
                                    Share.share('Check out this video: $appLink');
                                  }
                                  else if (index == 3) {
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                    }
                                    showReportDialog(context, videoData.id!);
                                  }
                                });
                              },
                            ),
                          );
                        })
              ],
            ) : Container(
          // color: yellow,
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: red,
                height: 120.h,
                width: 240.w,
                child: Image.asset('assets/images/no_data.png'),
              ),
              Text(
                AppLocalizations.of(context)!.videoNotFound,
                style: TextStyle(
                    fontFamily: fontFamily, fontSize: 15.sp),
              ),
            ],
          ),
        )),
          );
        }
        return Container();
      },
    );
  }
}
