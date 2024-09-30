// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:heroicons_flutter/heroicons_flutter.dart';
// import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
// import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
// import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
// import 'package:vimeo_clone/utils/widgets/customBottomSheet.dart';
// import 'package:vimeo_clone/utils/widgets/custom_channel_video_preview.dart';
// import '../../config/constants.dart';
//
// class YourVideoPage extends StatelessWidget {
//   const YourVideoPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     List<Map<String, dynamic>> bottomSheetListTileField = [
//       {
//         'name': 'Save to playlist',
//         'icon': HeroiconsOutline.bookmark
//       },
//       {
//         'name': 'Share',
//         'icon': HeroiconsOutline.share
//       },
//       {
//         'name': 'Edit',
//         'icon': HeroiconsOutline.pencil
//       },
//       {
//         'name': 'Delete video',
//         'icon': HeroiconsOutline.trash
//       },
//     ];
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//               'Your videos',
//             style: TextStyle(
//               fontFamily: fontFamily,
//               fontSize: 20.sp
//             ),
//           ),
//         ),
//       body: BlocBuilder<YourVideosBloc, YourVideosState>(
//         builder: (BuildContext context, YourVideosState state) {
//           if(state is YourVideosLoading){
//             return ListView.builder(
//               itemCount: 12,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: EdgeInsets.only(
//                       top: 5.h,
//                       bottom: 5.h,
//                       left: 10.w,
//                       right: 10.w
//                   ),
//                   child: ShimmerWidget.rectangular(
//                       height: 100.h,
//                       isBorder: true
//                   ),
//                 );
//               },
//             );
//           }else if(state is YourVideosLoaded){
//             final yourVideoLength = state.yourVideoData.length;
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   yourVideoLength != 0 ? ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: state.yourVideoData.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final videoCount = state.yourVideoData.length;
//                       final videoData = state.yourVideoData[index];
//                       final videoType = videoData.type;
//                       int? totalSeconds = state.yourVideoData[index].duration;
//                       String formattedTime = formatDuration(totalSeconds!);
//                       return videoType == 'video' ? InkWell(
//                         onTap: (){
//                           Future.delayed(const Duration(milliseconds: 200), () {
//                             GoRouter.of(context).pushNamed('videoPage', pathParameters: {
//                               "slug": videoData.slug!
//                             });
//                           });
//                         },
//                         child: Padding(
//                             padding: EdgeInsets.only(
//                               top: 5.h,
//                               bottom: 5.h
//                             ),
//                             child: CustomVideoPreview(
//                                 imageUrl: videoData.thumbnail!,
//                                 videoTitle: videoData.title!,
//                                 videoViews: '${videoData.views}',
//                                 uploadTime: videoData.createdAtHuman!,
//                                 videoDuration: formattedTime,
//                               onShowMorePressed: (){
//                                   customShowMoreBottomSheet(
//                                       context,
//                                       bottomSheetListTileField,
//                                           (int index){
//                                         if(index == 0) {}
//                                         else if(index == 1) {}
//                                         else if(index == 2){
//                                           if(Navigator.canPop(context)){
//                                             Navigator.pop(context);
//                                           }
//                                           GoRouter.of(context).pushNamed(
//                                               'editVideoDetailPage',
//                                               pathParameters: {
//                                                 'slug': videoData.slug!
//                                               }
//                                           );
//                                         }
//                                         else if(index == 3){}
//                                       }
//                                   );
//                               },
//                             ),
//                           ),
//                       ) : Container();
//                     },
//                   ) : Padding(
//                     padding: EdgeInsets.only(top: 150.h),
//                     child: Center(
//                         child: Image.asset(
//                           'assets/images/no_data.png',
//                           width: 200.w,
//                           height: 200.h,
//                         )),
//                   )
//                 ],
//               ),
//             );
//           }
//           return Container();
//         },
//
//       )
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_state.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/utils/widgets/customBottomSheet.dart';
import 'package:vimeo_clone/utils/widgets/custom_channel_video_preview.dart';
import 'package:vimeo_clone/utils/widgets/custom_shorts_preview.dart';
import '../../config/constants.dart';

class YourVideoPage extends StatefulWidget {
  const YourVideoPage({super.key});

  @override
  State<YourVideoPage> createState() => _YourVideoPageState();
}

class _YourVideoPageState extends State<YourVideoPage> {
  List<Map<String, dynamic>> bottomSheetListTileField = [
    {'name': 'Save to playlist', 'icon': HeroiconsOutline.bookmark},
    {'name': 'Share', 'icon': HeroiconsOutline.share},
    {'name': 'Edit', 'icon': HeroiconsOutline.pencil},
    {'name': 'Delete video', 'icon': HeroiconsOutline.trash},
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Videos and Shorts
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.yourVideos,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 20.sp,
            ),
          ),
          bottom: TabBar(
            dividerColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.tertiaryFixed,
            labelStyle: TextStyle(
              fontFamily: fontFamily,
            ),
            labelColor: Theme.of(context).colorScheme.tertiaryFixed,
            unselectedLabelColor: Theme.of(context).colorScheme.secondaryContainer,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.videos),
              Tab(text: AppLocalizations.of(context)!.shorts),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<YourVideosBloc, YourVideosState>(
              builder: (BuildContext context, YourVideosState state) {
                if (state is YourVideosLoading) {
                  return ListView.builder(
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                        child: ShimmerWidget.rectangular(
                          height: 100.h,
                          isBorder: true,
                        ),
                      );
                    },
                  );
                } else if (state is YourVideosLoaded) {
                  final yourVideoLength = state.yourVideoData.length;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        yourVideoLength != 0
                            ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.yourVideoData.length,
                          itemBuilder: (BuildContext context, int index) {
                            final videoData = state.yourVideoData[index];
                            final videoType = videoData.type;
                            int? totalSeconds = state.yourVideoData[index].duration;
                            String formattedTime = formatDuration(totalSeconds!);

                            return videoType == 'video'
                                ? InkWell(
                              onTap: () {
                                Future.delayed(const Duration(milliseconds: 200), () {
                                  GoRouter.of(context).pushNamed('videoPage', pathParameters: {
                                    "slug": videoData.slug!
                                  });
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: CustomVideoPreview(
                                  imageUrl: videoData.thumbnail!,
                                  videoTitle: videoData.title!,
                                  videoViews: '${videoData.views}',
                                  uploadTime: videoData.createdAtHuman!,
                                  videoDuration: formattedTime,
                                  onShowMorePressed: () {
                                    customShowMoreBottomSheet(
                                      context,
                                      bottomSheetListTileField,
                                          (int index) {
                                        if (index == 0) {
                                          // Handle Save to Playlist
                                        } else if (index == 1) {
                                          // Handle Share
                                        } else if (index == 2) {
                                          // Handle Edit
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                          GoRouter.of(context).pushNamed(
                                            'editVideoDetailPage',
                                            pathParameters: {
                                              'slug': videoData.slug!,
                                            },
                                          );
                                        } else if (index == 3) {
                                          // Handle Delete video
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                                : Container();
                          },
                        )
                            : Container(
                          // color: yellow,
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // color: red,
                                height: 120.h,
                                width: 250.w,
                                child: Image.asset('assets/images/no_data.png'),
                              ),
                              Text(
                                AppLocalizations.of(context)!.videoNotFound,
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 15.sp
                                ),
                              ),
                            ],
                          ),),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            // Second Tab Content for Shorts
            BlocBuilder<YourShortsBloc, YourShortsState>(
              builder: (BuildContext context, YourShortsState state) {
                if (state is YourVideosLoading) {
                  return ListView.builder(
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                        child: ShimmerWidget.rectangular(
                          height: 100.h,
                          isBorder: true,
                        ),
                      );
                    },
                  );
                } else if (state is YourShortsLoaded) {
                  final shorts = state.yourShortsData;

                  return shorts.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: shorts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final short = shorts[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.w
                        ),
                        child: CustomShortsPreview(
                            thumbNailPath: short.thumbnail!,
                            views: short.views.toString()
                        ),
                      );
                    },
                  )
                      : Container(
                    // color: yellow,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: red,
                          height: 120.h,
                          width: 250.w,
                          child: Image.asset('assets/images/no_data.png'),
                        ),
                        Text(
                          AppLocalizations.of(context)!.shortsNotFound,
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    ),),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
