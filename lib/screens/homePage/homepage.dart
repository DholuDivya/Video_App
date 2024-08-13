import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/appLinks.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_state.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_bloc.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_event.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_state.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/screens/upload_shorts/crop_shorts_page.dart';
import 'package:vimeo_clone/utils/widgets/custom_bottom_sheet_button.dart';
import '../../Utils/Widgets/bottom_nav_bar.dart';
import '../../bloc/video_category/video_category_event.dart';
import '../../bloc/video_list/video_list_bloc.dart';
import '../../bloc/video_list/video_list_event.dart';
import '../../config/colors.dart';
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

  List screens = [
    const HomePageContent(),
    ShortsPage(),
    const SubscriptionsPage(),
    const UserPage(),
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
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      // WidgetsBinding.instance.addPostFrameCallback((_){
                      // GoRouter.of(context).pushNamed('getShortsThumbnailPage');
                      // });getShortsThumbnailPage
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => CropShortsPage())
                      );

                    }
                  }, child: BlocBuilder<GetShortsBloc, GetShortsState>(
                          builder: (BuildContext context, GetShortsState state) {
                    return BottomSheetButton(
                      onTap: () {
                        context
                            .read<GetShortsBloc>()
                            .add(GetShortsFromCamera());
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
                    onTap: () {},
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
                      return Center(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Image.asset('assets/images/homepage_logo.png', height: 100.0, width: 180.0,),
            titleSpacing: 1.0,
            floating: true,
            pinned: false,
            snap: false,
            actions: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed('searchPage');
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
                    if (state is VideoListLoading) {
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

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                              top: ScreenSize.screenHeight(context) * 0.02),
                          itemCount: state.videoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final type = state.videoList[index].type;
                            print('!!!!!!!!!!!!!!!!!!!!      ${state.videoList[index].duration}');
                            int totalSeconds = state.videoList[index].duration!;
                            String formattedTime = formatDuration(totalSeconds);

                            return type == "video" ? VideoListItem(
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 200), () {
                                  GoRouter.of(context).pushNamed('videoPage',
                                      pathParameters: {
                                        "slug": state.videoList[index].slug!
                                      });
                                });
                              },
                              channelPhoto: state.videoList[index].channel?.logo ?? 'assets/images/sonysab.jpg',
                              thumbnailUrl: '${state.videoList[index].thumbnail}',
                              // duration: '${state.videoList[index].duration}',
                              duration: formattedTime,
                              title: '${state.videoList[index].title}',
                              author: '${state.videoList[index].channel?.name}',
                              views: '${state.videoList[index].views}',
                              uploadTime:
                                  '${state.videoList[index].createdAtHuman}',
                              onMorePressed: () {
                                // Add your onMorePressed logic here
                              },
                            ) : null;
                          });
                    }
                    return Container();
                  })
                : BlocBuilder<VideoListBloc, VideoListState>(
                    builder: (BuildContext context, state) {
                      if (state is VideoListLoading) {
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
                                      int totalSeconds =
                                      state.videoList[index].duration!;
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
                                    channelPhoto:
                                        state.videoList[index].channel?.logo ?? 'assets/images/sonysab.jpg',
                                    thumbnailUrl:
                                        '${state.videoList[index].thumbnails}',
                                    duration: formattedTime,
                                    title: '${state.videoList[index].title}',
                                    author:
                                        '${state.videoList[index].channel?.name}',
                                    views: '${state.videoList[index].views}',
                                    uploadTime:
                                        '${state.videoList[index].createdAtHuman}',
                                    onMorePressed: () {
                                      // Add your onMorePressed logic here
                                    },
                                  ) : null;
                                })
                            : Padding(
                                padding: EdgeInsets.only(top: 150.h),
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/no_data.jpg',
                                  width: 200,
                                  height: 200,
                                )),
                              );
                      }

                      return Container();
                    },
                  ),
          ),
        ],
      ),
    );
  }

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
                            fontWeight: FontWeight.w400,
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
                                  fontWeight: FontWeight.w400,
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
