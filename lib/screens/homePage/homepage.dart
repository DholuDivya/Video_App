import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_state.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_bloc.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_bloc.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_event.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_state.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/screens/upload_shorts/crop_shorts_page.dart';
import 'package:vimeo_clone/utils/widgets/custom_bottom_sheet_button.dart';
import 'package:vimeo_clone/utils/widgets/custom_shorts_preview.dart';
import 'package:vimeo_clone/utils/widgets/custom_shorts_preview_homepage.dart';
import '../../Utils/Widgets/bottom_nav_bar.dart';
import '../../bloc/video_category/video_category_event.dart';
import '../../bloc/video_list/video_list_bloc.dart';
import '../../bloc/video_list/video_list_event.dart';
import '../../config/colors.dart';
import '../../model/all_video_list_model.dart';
import '../../utils/widgets/video_container.dart';
import '../user_page/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _picker = ImagePicker();
  late File _video;

  int _currentIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;

  bool _isIndex1 = false;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _isIndex1 = false;
    });

    // Toggle dark based on index
    if (index == 1) {
      setState(() {
        _isIndex1 = true;
      });
    }
  }

  @override
  void initState() {
    context.read<GetSubscribedChannelListBloc>().add(GetSubscribedChannelListRequest());
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
    super.initState();
  }
  List screens = [
    HomePageContent(),
    ShortsPage(),
    SubscriptionsPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        backgroundColor:
            _isIndex1 ? greyShade900 : Theme.of(context).colorScheme.surface,
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        onAddButtonPressed: addButton,
        screenHeight: ScreenSize.screenHeight(context) * 0,
        screenWidth: ScreenSize.screenWidth(context) * 0,
      ),
    );
  }

  void addButton() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200.h,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocListener<GetShortsBloc, GetShortsState>(
                      listener: (BuildContext context, GetShortsState state) {
                    if (state is GetShortsLoading) {
                      // return Center(child: CircularProgressIndicator(),);child
                    } else if (state is GetShortsSuccess) {
                      // if (Navigator.canPop(context)) {
                      //   Navigator.pop(context);
                      // }
                      // GoRouter.of(context).pushNamed('cropShortsPage');
                    }
                  }, child: BlocBuilder<GetShortsBloc, GetShortsState>(
                          builder: (BuildContext context, GetShortsState state) {
                    return BottomSheetButton(
                      onTap: () {
                        context
                            .read<GetShortsBloc>()
                            .add(GetShortsFromFile());
                      },
                      buttonName: 'Create short',
                      buttonIcon: HeroiconsOutline.camera,
                    );
                  })),
                  BottomSheetButton(
                    onTap: uploadVideoBottomSheet,
                    buttonName: 'Upload a Video',
                    buttonIcon: HeroiconsOutline.arrowUpOnSquare,
                  ),
                  BottomSheetButton(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(builder: (context) => CropShortsPage())
                      // );
                    },
                    buttonName: 'Go Live',
                    buttonIcon: HeroiconsOutline.tv,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void uploadVideoBottomSheet() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200.h,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<GetVideoBloc, GetVideoState>(
                      builder: (BuildContext context, state) {
                    if (state is GetVideoLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return BottomSheetButton(
                      onTap: () {
                        // if (Navigator.canPop(context)) {
                        //   Navigator.pop(context);
                        // }
                        context.read<GetVideoBloc>().add(OpenFilesToGetVideo());
                      },
                      buttonName: 'From Files',
                      buttonIcon: HeroiconsOutline.folder,
                    );
                  }, listener: (context, state) {
                    if (state is GetVideoSuccess) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      log('Video Fetch Successfully from user');
                      GoRouter.of(context).pushNamed('uploadVideoPage');
                    }
                  }),
                  BottomSheetButton(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      GoRouter.of(context).pushNamed('uploadVideoFromUrl');
                    },
                    buttonName: 'From Youtube',
                    buttonIcon: HeroiconsOutline.link,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool isAllCategorySelected = true;
  int? mode;

  @override
  void initState() {
    super.initState();
    // getTheme();
  }

  // final ScrollController _scrollController = ScrollController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_onScroll);
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  //
  // Future<void> _onRefresh() async {
  //   _postBloc.add(PostRefresh());
  // }
  //
  // void _onScroll() {
  //   double maxScroll = _scrollController.position.maxScrollExtent;
  //   double currentScroll = _scrollController.position.pixels;
  //   if (currentScroll == maxScroll) _postBloc.add(PostFetched());
  // }




  Future<void> _refreshVideosList() async {
    if (isAllCategorySelected) {
      // Trigger refresh for "All" category
      context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
    } else {
      // Trigger refresh for selected category
      // context.read<VideoListBloc>().add(GetVideoListEvent(categoryId: categoryId));
    }
  }
  // void getTheme() async {
  //   final box = await Hive.openBox('themebox');
  //   setState(() {
  //     mode = box.get('themeMode');
  //   });
  // }




  @override
  Widget build(BuildContext context) {
    mode = context.read<ThemeBloc>().mode;
    print('$mode   222222');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: _refreshVideosList,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Container(
                padding: EdgeInsets.only(left: 15.w),
                child: mode == 1
                    ? Image.asset('assets/images/homepage_logo_light.png', height: 75.h, width: 115.w,)
                    : Image.asset('assets/images/homepage_logo_dark.png', height: 75.h, width: 115.w,),
              ),

              titleSpacing: 1.0,
              floating: true,
              pinned: false,
              snap: false,
              actions: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('searchSuggestionPage');
                  },
                  icon: const Icon(
                    HeroiconsOutline.magnifyingGlass,
                    size: 22,
                  ),
                ),
                // SizedBox(width: screenWidth * 0.01),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('notificationPage');
                  },
                  icon: const Icon(
                    HeroiconsOutline.bell,
                    size: 22,
                  ),
                ),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
              ],

              bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(ScreenSize.screenHeight(context) * 0.05),
                  child: Column(
                    children: [
                      categoryListView(),
                      SizedBox(
                        height: ScreenSize.screenHeight(context) * 0.006,
                      )
                    ],
                  )),
            ),
            SliverToBoxAdapter(
              // child: AllCategory(category: categoryList[isCategory]['type']),
              child: isAllCategorySelected
                  ? BlocBuilder<AllVideoListBloc, AllVideoListState>(
                      builder: (BuildContext context, state) {
                      if (state is AllVideoListLoading) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: ShimmerWidget.rectangular(
                                          // width: double.infinity,
                                          // height: 200,
                                          isBorder: false,
                                          height: 50,
                                        )),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        SizedBox(width: 8),
                                        ShimmerWidget.circular(
                                            width: 40,
                                            height: 40,
                                            isBorder: true),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ShimmerWidget.rectangular(
                                              height: 16,
                                              width: 120,
                                              isBorder: true,
                                            ),
                                            SizedBox(height: 8),
                                            ShimmerWidget.rectangular(
                                              height: 16,
                                              width: 200,
                                              isBorder: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                        // return Center(child: CircularProgressIndicator(),);
                      } else if (state is AllVideoListLoaded) {

                        final videoLength = state.videoList.length;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: ScreenSize.screenHeight(context) * 0.02),
                          itemCount: videoLength + 1, // Add 1 to account for the inserted container
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 2) { // Insert the container between index 2 and 3
                              return Column(
                                children: [
                                  _shortsView(),
                                  SizedBox(
                                    height: 15.h,
                                  )
                                ],
                              );
                            }

                            // Adjust the index to access the correct video item
                            final adjustedIndex = index > 2 ? index - 1 : index;
                            final type = state.videoList[adjustedIndex].type;

                            print('!!!!!!!!!!!!!!!!!!!!      ${state.videoList[adjustedIndex].duration}');
                            int totalSeconds = state.videoList[adjustedIndex].duration!;
                            String formattedTime = formatDuration(totalSeconds);

                            return type == "video"
                                ? VideoListItem(
                              onTap: () {
                                Future.delayed(const Duration(milliseconds: 200), () {
                                  GoRouter.of(context).pushNamed('videoPage', pathParameters: {
                                    "slug": state.videoList[adjustedIndex].slug!
                                  });
                                });
                              },
                              onTapChannel: () {
                                final String channelId =
                                state.videoList[adjustedIndex].channel!.id.toString();
                                GoRouter.of(context).pushNamed('channelProfilePage',
                                    pathParameters: {'channelId': channelId});
                              },
                              channelPhoto: state.videoList[adjustedIndex].channel?.logo ??
                                  'assets/images/sonysab.jpg',
                              thumbnailUrl: '${state.videoList[adjustedIndex].thumbnail}',
                              duration: formattedTime,
                              title: '${state.videoList[adjustedIndex].title}',
                              author: '${state.videoList[adjustedIndex].channel?.name}',
                              views: '${state.videoList[adjustedIndex].views}',
                              uploadTime: '${state.videoList[adjustedIndex].createdAtHuman}',
                              onMorePressed: () {
                                showPopupMenu(context);
                              },
                            )
                                : null;
                          },
                        );





                        // final videoLength = state.videoList.length;
                        // return ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     padding: EdgeInsets.only(
                        //         top: ScreenSize.screenHeight(context) * 0.02),
                        //     itemCount: videoLength,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       final type = state.videoList[index].type;
                        //       print('!!!!!!!!!!!!!!!!!!!!      ${state.videoList[index].duration}');
                        //       int totalSeconds = state.videoList[index].duration!;
                        //       String formattedTime = formatDuration(totalSeconds);
                        //
                        //       if(videoLength == 2){
                        //         return Container(
                        //           height: 100,
                        //           width: 100,
                        //           color: red,
                        //         );
                        //       }
                        //
                        //
                        //       return type == "video" ? VideoListItem(
                        //         onTap: () {
                        //           Future.delayed(
                        //               const Duration(milliseconds: 200), () {
                        //             GoRouter.of(context).pushNamed('videoPage',
                        //                 pathParameters: {
                        //                   "slug": state.videoList[index].slug!
                        //                 });
                        //           });
                        //         },
                        //         onTapChannel: (){
                        //           final String channelId = state.videoList[index].channel!.id.toString();
                        //           GoRouter.of(context).pushNamed(
                        //             'channelProfilePage',
                        //             pathParameters: {
                        //               'channelId': channelId
                        //             }
                        //           );
                        //         },
                        //         channelPhoto: state.videoList[index].channel?.logo ?? 'assets/images/sonysab.jpg',
                        //         thumbnailUrl: '${state.videoList[index].thumbnail}',
                        //         duration: formattedTime,
                        //         title: '${state.videoList[index].title}',
                        //         author: '${state.videoList[index].channel?.name}',
                        //         views: '${state.videoList[index].views}',
                        //         uploadTime:
                        //             '${state.videoList[index].createdAtHuman}',
                        //         onMorePressed: () {
                        //           // final RenderBox renderBox = context.findRenderObject() as RenderBox;
                        //           // final Offset offset = renderBox.localToGlobal(Offset.zero);
                        //           // showPopupMenu(context, offset);
                        //           showPopupMenu(context);
                        //         },
                        //       ) : null;
                        //     });
                      }
                      return Container();
                    })
                  : BlocBuilder<VideoListBloc, VideoListState>(
                      builder: (BuildContext context, state) {
                        if (state is VideoListLoading) {
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 8,
                              itemBuilder: (context, index) {

                                return Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: ShimmerWidget.rectangular(
                                            // width: double.infinity,
                                            // height: 200,
                                            isBorder: false,
                                            height: 50,
                                          )),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          const ShimmerWidget.circular(
                                              width: 40,
                                              height: 40,
                                              isBorder: true),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ShimmerWidget.rectangular(
                                                height: 16,
                                                width: 120,
                                                isBorder: true,
                                              ),
                                              const SizedBox(height: 8),
                                              ShimmerWidget.rectangular(
                                                height: 16,
                                                width: 200,
                                                isBorder: true,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                          // return Center(child: CircularProgressIndicator(),);
                        } else if (state is VideoListLoaded) {
                          return state.videoList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                      top: ScreenSize.screenHeight(context) *
                                          0.02),
                                  itemCount: state.videoList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final type = state.videoList[index].type;
                                        int totalSeconds = state.videoList[index].duration!;
                                    String formattedTime =
                                        formatDuration(totalSeconds);

                                    return type == "video" ? VideoListItem(
                                      onTap: () {
                                        print(
                                            '***************    ${state.videoList[index].slug}');
                                        Future.delayed(
                                            const Duration(milliseconds: 200),
                                            () {
                                              print('Video clicked>>>>>>>>>>>>>.');
                                          GoRouter.of(context).pushNamed('videoPage',
                                              pathParameters: {
                                                "slug":
                                                    state.videoList[index].slug!
                                              });



                                        });
                                      },
                                      channelPhoto: state.videoList[index].channel?.logo ?? 'assets/images/sonysab.jpg',
                                      thumbnailUrl: '${state.videoList[index].thumbnails}',
                                      duration: formattedTime,
                                      title: '${state.videoList[index].title}',
                                      author: '${state.videoList[index].channel?.name}',
                                      views: '${state.videoList[index].views}',
                                      uploadTime: '${state.videoList[index].createdAtHuman}',
                                      onMorePressed: () {
                                        // final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                        // final Offset offset = renderBox.localToGlobal(Offset.zero);
                                        // showPopupMenu(context, offset);
                                        showPopupMenu(context);
                                      },
                                    ) : null;
                                  })
                              : Padding(
                                  padding: EdgeInsets.only(top: 150.h),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/no_data.png',
                                    width: 200.w,
                                    height: 200.h,
                                  )),
                                );
                        }

                        return Container();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _shortsView(){
    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(HeroiconsSolid.fire, color: Theme.of(context).colorScheme.onSecondaryFixedVariant,),
              SizedBox(width: 3.w,),
              Text(
                'Shorts',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          Container( // Wrap the GridView in a SizedBox with a fixed height
            // height: 600,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),

              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.h,
                maxCrossAxisExtent: 200,
                // childAspectRatio: 9/16
              ),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return CustomShortsPreviewHomepage(
                  localImage: 'assets/images/tmkoc4.jpg',
                    thumbNailPath: '',
                    views: 20
                );
              },
            ),
          ),
        ],
      ),
    );
  }




  // Widget _shortsView(){
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: 10.w,
  //       right: 10.w
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //                 'Shorts',
  //               style: TextStyle(
  //                 fontFamily: fontFamily,
  //                 fontWeight: FontWeight.w700,
  //                 fontSize: 20
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           // height: 350.h,
  //           color: red,
  //           child: GridView.builder(
  //             physics: const NeverScrollableScrollPhysics(),
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 2,
  //               mainAxisSpacing: 8.h,
  //               crossAxisSpacing: 8.h,
  //               // childAspectRatio: 9/16
  //             ),
  //             // scrollDirection: Axis.horizontal,
  //             shrinkWrap: true,
  //             itemCount: 4,
  //               itemBuilder: (BuildContext context, int index){
  //                 return Container(
  //                   height: 280,
  //                   // width: 120,
  //                   color: blue,
  //                 );
  //               },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  Widget _buildLoadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ShimmerWidget.rectangular(
            isBorder: false,
            height: 50,
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            const SizedBox(width: 8),
            const ShimmerWidget.circular(width: 40, height: 40, isBorder: true),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rectangular(
                  height: 16,
                  width: 120,
                  isBorder: true,
                ),
                const SizedBox(height: 8),
                ShimmerWidget.rectangular(
                  height: 16,
                  width: 200,
                  isBorder: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }



  Widget _buildVideoItem(VideoData video) {
    String formattedTime = formatDuration(video.duration!);
    return VideoListItem(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 200), () {
          GoRouter.of(context).pushNamed('videoPage', pathParameters: {
            "slug": video.slug!,
          });
        });
      },
      onTapChannel: () {
        final String channelId = video.channel!.id.toString();
        GoRouter.of(context).pushNamed('channelProfilePage', pathParameters: {
          'channelId': channelId,
        });
      },
      channelPhoto: video.channel?.logo ?? 'assets/images/sonysab.jpg',
      thumbnailUrl: video.thumbnail!,
      duration: formattedTime,
      title: video.title!,
      author: video.channel!.name!,
      views: video.views!.toString(),
      uploadTime: video.createdAtHuman!,
      onMorePressed: () {
        showPopupMenu(context);
      },
    );
  }




  void showPopupMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: MenuAnchor(
            builder: (BuildContext context, MenuController controller, Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_horiz),
                tooltip: 'Show menu',
              );
            },
            menuChildren: List<MenuItemButton>.generate(3, (int index) {
              return MenuItemButton(
                onPressed: () {
                  // Add your action here
                  Navigator.of(context).pop(); // Close the menu after selection
                },
                child: Text('Item ${index + 1}'),
              );
            }),
          ),
        );
      },
    );
  }






  // void showPopupMenu(BuildContext context, Offset offset) async {
  //   final RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   final Offset buttonOffset = renderBox.localToGlobal(Offset.zero);
  //
  //   await showMenu<int>(
  //     context: context,
  //     position: RelativeRect.fromLTRB(
  //       buttonOffset.dx,
  //       buttonOffset.dy,
  //       MediaQuery.of(context).size.width - buttonOffset.dx,
  //       MediaQuery.of(context).size.height - buttonOffset.dy,
  //     ),
  //     items: [
  //       PopupMenuItem<int>(
  //         value: 0,
  //         child: Text('Item 1'),
  //       ),
  //       PopupMenuItem<int>(
  //         value: 1,
  //         child: Text('Item 2'),
  //       ),
  //       PopupMenuItem<int>(
  //         value: 2,
  //         child: Text('Item 3'),
  //       ),
  //     ],
  //   ).then((int? result) {
  //     if (result != null) {
  //       // Handle menu item selection
  //       print("Item $result clicked");
  //     }
  //   });
  // }



  Widget categoryListView() {
    return BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
      builder: (BuildContext context, state) {
        if (state is VideoCategoriesLoading) {
          return Container(
            // color: red,
            height: ScreenSize.screenHeight(context) * 0.04,
            child: ListView.builder(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ShimmerWidget.rectangular(
                          width: 100, height: 40.h, isBorder: true),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  );
                }),
          );
          // return Center(child: CircularProgressIndicator(),);
        } else if (state is VideoCategoriesLoaded) {
          return Container(
            height: ScreenSize.screenHeight(context) * 0.04,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllCategorySelected = true;
                      });
                      // Call the specific API for "All" category
                      // context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isAllCategorySelected
                            ? primaryColor
                            : primaryLightColor,
                        // color: isAllCategorySelected ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(25),
                        // border: Border.all(
                        //   color: isAllCategorySelected ? selectedTabOutline : unSelectedTabOutline,
                        //   width: 0.5,
                        // ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.screenWidth(context) * 0.05,
                      ),
                      child: Center(
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: isAllCategorySelected
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 11,
                            fontFamily: fontFamily,
                            fontWeight: isAllCategorySelected ? FontWeight.bold : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: ScreenSize.screenWidth(context) * 0.02,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllCategorySelected = false;
                            });
                            // Trigger the specific category selection
                            context
                                .read<VideoCategoriesBloc>()
                                .add(SelectCategory(selectedCategory: index));
                            context.read<VideoListBloc>().add(GetVideoListEvent(
                                categoryId: state.categories[index].id!));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isAllCategorySelected
                                  ? Colors.blue.shade50
                                  : index == state.selectedCategory
                                      ? primaryColor
                                      : primaryLightColor,
                              // color:  isAllCategorySelected
                              //     ? Theme.of(context).colorScheme.primary
                              //     : index == state.selectedCategory ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenSize.screenWidth(context) * 0.05,
                            ),
                            child: Center(
                              child: Text(
                                '${state.categories[index].name}',
                                style: TextStyle(
                                  color: isAllCategorySelected
                                      ? Colors.black87
                                      : index == state.selectedCategory
                                          ? Colors.white
                                          : Colors.black87,
                                  fontSize: 11,
                                  fontFamily: fontFamily,
                                  fontWeight: isAllCategorySelected
                                      ? FontWeight.w400
                                      : index == state.selectedCategory
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
