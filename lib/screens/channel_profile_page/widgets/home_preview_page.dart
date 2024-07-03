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
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_channal_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/custom_for_you_preview.dart';

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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
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
                  ),
                ),
              ),
              ForYouPreview(
                videoTitle: 'Tarak Mehta ka Ooltah Chashma - Episode 2384',
                channelName: 'Sony Sab',
                uploadTime: '4 days ago',
              ),
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
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return CustomVideoPreview(
                imageUrl: videoList[index]['thumbnail'],
                videoTitle: 'Tarak Mehta ka Ooltah Chashma Episode - 220',
                videoViews: videoList[index]['views'],
                uploadTime: 5,
                videoDuration: '29:33',
              );
            },
            childCount: videoList.length,
          ),
        ),
      ],
    );
  }
}
