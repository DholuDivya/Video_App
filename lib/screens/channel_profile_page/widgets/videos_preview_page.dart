import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/latest_popular_oldest.dart';

class VideosPreviewPage extends StatefulWidget {
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
            itemCount: videoList.length,
              itemBuilder: (BuildContext context, int index){
                return CustomVideoPreview(
                    imageUrl: sortedVideoList[index]['thumbnail'],
                    videoTitle: 'Tarak Mehta ka Ooltah Chashma Episode - 220',
                    videoViews: sortedVideoList[index]['views'],
                    uploadTime: 5,
                    videoDuration: '29:33'
                );
              }
          )
        ],
      ),
    );
  }
}
