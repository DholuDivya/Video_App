// import 'package:flutter/material.dart';
// import 'package:vimeo_clone/config/colors.dart';
// import 'package:vimeo_clone/utils/widgets/horizontal_list.dart';
// import 'package:vimeo_clone/utils/widgets/latest_popular_oldest.dart';
//
// import '../../config/constants.dart';
// import '../../utils/widgets/custom_shorts_preview.dart';
//
// class ShortsPreviewPage extends StatefulWidget {
//   const ShortsPreviewPage({super.key});
//
//   @override
//   State<ShortsPreviewPage> createState() => _ShortsPreviewPageState();
// }
//
// class _ShortsPreviewPageState extends State<ShortsPreviewPage> {
//   int selectedIndex = 0;
//
//   List<Map<String, dynamic>> sortList = [
//     {"type": "Latest", "isSelected": true},
//     {"type": "Popular", "isSelected": false},
//     {"type": "Oldest", "isSelected": false},
//   ];
//
//   List<Map<String, dynamic>> shortsThumbNail = [
//     {"thumbnail": "assets/images/tmkoc10.jpg", "views": "1.2M"},
//     {"thumbnail": "assets/images/tmkoc9.jpg", "views": "876K"},
//     {"thumbnail": "assets/images/tmkoc8.jpg", "views": "1M"},
//     {"thumbnail": "assets/images/tmkoc7.jpg", "views": "432K"},
//     {"thumbnail": "assets/images/tmkoc6.jpg", "views": "200k"},
//     {"thumbnail": "assets/images/tmkoc5.jpg", "views": "56.9k"},
//     {"thumbnail": "assets/images/tmkoc4.jpg", "views": "103k"},
//     {"thumbnail": "assets/images/tmkoc3.jpg", "views": "760k"},
//     {"thumbnail": "assets/images/tmkoc2.jpg", "views": "1.2M"},
//     {"thumbnail": "assets/images/tmkoc1.jpg", "views": "144K"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       child: Column(
//         children: [
//           VideoSortList(
//             sortCategoryList: sortList,
//             selectedIndex: selectedIndex,
//             onCategorySelected: (index) {
//               setState(() {
//                 selectedIndex = index;
//               });
//             },
//           ),
//           GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: shortsThumbNail.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 2.0,
//                   mainAxisSpacing: 2.0,
//                   mainAxisExtent: 200),
//               itemBuilder: (context, index) {
//                 return CustomShortsPreview(
//                   thumbNailPath: shortsThumbNail[index]['thumbnail'],
//                   views: '${shortsThumbNail[index]['views']} views',
//                 );
//               }),
//         ],
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_state.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_state.dart';
import 'package:vimeo_clone/model/get_channel_detail_model.dart';
import 'package:vimeo_clone/utils/widgets/latest_popular_oldest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/constants.dart';
import '../../../utils/widgets/custom_shorts_preview.dart';

class ShortsPreviewPage extends StatefulWidget {
  final int channelId;
  // final GetChannelDetailModel channelData;
  const ShortsPreviewPage({super.key, required this.channelId});

  @override
  State<ShortsPreviewPage> createState() => _ShortsPreviewPageState();
}

class _ShortsPreviewPageState extends State<ShortsPreviewPage> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> sortList = [
    {"type": "Latest", "isSelected": true},
    {"type": "Popular", "isSelected": false},
    {"type": "Oldest", "isSelected": false},
  ];

  List<Map<String, dynamic>> shortsThumbNail = [
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

  List<Map<String, dynamic>> sortedShortsThumbNail = [];

  @override
  void initState() {
    super.initState();
    sortedShortsThumbNail = List.from(shortsThumbNail);
  }

  void sortShorts(int index) {
    setState(() {
      selectedIndex = index;
      switch (sortList[index]['type']) {
        case 'Latest':
          sortedShortsThumbNail = List.from(shortsThumbNail);
          break;
        case 'Popular':
          sortedShortsThumbNail.sort((a, b) {
            return _parseViews(b['views']).compareTo(_parseViews(a['views']));
          });
          break;
        case 'Oldest':
          sortedShortsThumbNail = List.from(shortsThumbNail.reversed);
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
    return BlocBuilder<YourShortsBloc, YourShortsState>(
      builder: (BuildContext context, YourShortsState state) {
        if(state is YourShortsLoaded){
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: state.yourShortsData.isNotEmpty ? Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0
                  ),
                  child: VideoSortCategory(
                    sortCategoryList: sortList,
                    selectedIndex: selectedIndex,
                    onCategorySelected: (index) {
                      sortShorts(index);
                    },
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: ScreenSize.screenHeight(context) * 0.01,
                  ),
                  itemCount: state.yourShortsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.4,
                    mainAxisSpacing: 0.4,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (context, index) {
                    final shortsData = state.yourShortsData[index];
                    final type = shortsData.type;
                    return CustomShortsPreview(
                      thumbNailPath: shortsData.thumbnail!,
                      views: shortsData.views.toString(),
                    );
                  },
                ),
              ],
            ) : Container(
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
                      AppLocalizations.of(context)!.noVideosDownloadedYet,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 15.sp
                      ),
                    ),
                  ],
                ),)
            )
          );
        }
        return Container();
      },
    );
  }
}
