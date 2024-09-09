import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/customBottomSheet.dart';
import 'package:vimeo_clone/utils/widgets/custom_channel_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/latest_popular_oldest.dart';

import '../../../bloc/channel_profile/channel_profile_bloc.dart';
import '../../../bloc/channel_profile/channel_profile_state.dart';

class VideosPreviewPage extends StatefulWidget {
  // final GetChannelDetailModel channelData;
  const VideosPreviewPage({super.key});

  @override
  State<VideosPreviewPage> createState() => _VideosPreviewPageState();
}

class _VideosPreviewPageState extends State<VideosPreviewPage> {
  int selectedIndex = 0;

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
  
  @override
  void initState() {
    super.initState();
    sortedVideoList = List.from(videoList);
  }

  List<Videos> sortVideos(List<Videos> videos, String sortType) {
    switch (sortType) {
      case "Latest":
        videos.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        break;
      case "Popular":
        videos.sort((a, b) => b.views!.compareTo(a.views!));
        break;
      case "Oldest":
        videos.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
    }
    return videos;
  }

  void _onSortTypeChanged(int index) {
    setState(() {
      selectedIndex = index;
      sortList.forEach((item) => item['isSelected'] = false);
      sortList[selectedIndex]['isSelected'] = true;
    });
  }


  List<Map<String, dynamic>> bottomSheetListTileField = [
    {
      'name': 'Edit video detail',
      'icon': HeroiconsOutline.bookmark
    },
    {
      'name': 'Save to playlist',
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
    // String selectedSortType = sortList[selectedIndex]['type'];
    // List<Videos> sortedVideos = sortVideos(widget.channelData.channel!.videos!, selectedSortType);

    return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
      builder: (BuildContext context, ChannelProfileState state) {
        if(state is ChannelProfileLoaded) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSize.screenHeight(context) * 0.01,
                      left: ScreenSize.screenWidth(context) * 0.015
                  ),
                  child: VideoSortCategory(
                      sortCategoryList: sortList,
                      selectedIndex: selectedIndex,
                      onCategorySelected: (index) {}
                  ),
                ),

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      top: 5.h,
                      bottom: ScreenSize.screenHeight(context) * 0.01,
                    ),
                    itemCount: state.channelData.first.channelVideos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final videoData = state.channelData.first.channelVideos[index];
                      final totalSeconds = videoData.duration;
                      final formattedDuration = formatDuration(totalSeconds);
                      return Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                        child: CustomVideoPreview(
                            imageUrl: videoData.thumbnails,
                            videoTitle: videoData.title,
                            videoViews: '${videoData.views}',
                            uploadTime: videoData.createdAtHuman,
                            videoDuration: formattedDuration,
                          onShowMorePressed: (){
                            customShowMoreBottomSheet(
                                context,
                                bottomSheetListTileField,
                                    (int index){
                                  if(index == 0){
                                    GoRouter.of(context).pushNamed('editVideoDetailPage');
                                  }
                                }
                            );
                          },
                        ),
                      );
                    }
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
