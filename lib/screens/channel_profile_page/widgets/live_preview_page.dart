import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/latest_popular_oldest.dart';

import '../../../utils/widgets/custom_channel_video_preview.dart';

class LivePreviewPage extends StatefulWidget {
  // final GetChannelDetailModel channelData;
  const LivePreviewPage({super.key,});

  @override
  State<LivePreviewPage> createState() => _LivePreviewPageState();
}

class _LivePreviewPageState extends State<LivePreviewPage> {

  int selectedIndex = 0;

  List<Map<String, dynamic>> sortList = [
    {"type": "Latest", "isSelected": true},
    {"type": "Popular", "isSelected": false},
    {"type": "Oldest", "isSelected": false},
  ];

  List<Map<String, dynamic>> videoList = [
    {"thumbnail": "assets/images/tmkoc1.jpg", "views": "1.2M"},
    {"thumbnail": "assets/images/tmkoc2.jpg", "views": "876K"},
    {"thumbnail": "assets/images/tmkoc3.jpg", "views": "1M"},
    {"thumbnail": "assets/images/tmkoc4.jpg", "views": "432K"},
    {"thumbnail": "assets/images/tmkoc5.jpg", "views": "200K"},
    {"thumbnail": "assets/images/tmkoc6.jpg", "views": "56.9K"},
    {"thumbnail": "assets/images/tmkoc7.jpg", "views": "103K"},
    {"thumbnail": "assets/images/tmkoc8.jpg", "views": "760K"},
    {"thumbnail": "assets/images/tmkoc9.jpg", "views": "1.2M"},
    {"thumbnail": "assets/images/tmkoc10.jpg", "views": "144K"},
  ];

  List<Map<String, dynamic>> sortedVideoList = [];

  @override
  void initState() {
    super.initState();
    sortedVideoList = List.from(videoList);
  }

  void sortVideos(int index) {
    setState(() {
      selectedIndex = index;
      switch (sortList[index]['type']) {
        case 'Latest':
          sortedVideoList = List.from(videoList);
          break;
        case 'Popular':
          sortedVideoList.sort((a, b) {
            return _parseViews(b['views']).compareTo(_parseViews(a['views']));
          });
          break;
        case 'Oldest':
          sortedVideoList = List.from(videoList.reversed);
          break;
      }
    });
  }

  int _parseViews(String views) {
    if (views.endsWith('M')) {
      return (double.parse(views.replaceAll('M', '')) * 1000000).toInt();
    } else if (views.endsWith('K')) {
      return (double.parse(views.replaceAll('K', '')) * 1000).toInt();
    } else {
      return int.parse(views);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
      builder: (BuildContext context, ChannelProfileState state) {
        if(state is ChannelProfileLoaded){
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
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
                      onCategorySelected: (index){
                        sortVideos(index);
                      }
                  ),
                ),

                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      top: 0,
                      bottom: ScreenSize.screenHeight(context) * 0.01,
                    ),
                    itemCount: state.channelData.first.channel!.videos!.length,
                    itemBuilder: (BuildContext context, int index){
                      final videoData = state.channelData.first.channel!.videos?[index];
                      final totalSeconds = videoData!.duration;
                      final formattedDuration = formatDuration(totalSeconds!);
                      return Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                        child: CustomVideoPreview(
                            imageUrl: '${videoData.thumbnails}',
                            videoTitle: 'Tarak Mehta ka Ooltah Chashma Episode - 220',
                            videoViews: sortedVideoList[index]['views'],
                            uploadTime: videoData.createdAtHuman!,
                            videoDuration: formattedDuration
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
