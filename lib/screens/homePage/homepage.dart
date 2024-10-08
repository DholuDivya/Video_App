import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_state.dart';
import 'package:vimeo_clone/bloc/download_video/download_video_bloc.dart';
import 'package:vimeo_clone/bloc/download_video/download_video_state.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_bloc.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_state.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_bloc.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_event.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_state.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_event.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_bloc.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_event.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_state.dart';
import 'package:vimeo_clone/bloc/shorts_visible/shorts_visible_bloc.dart';
import 'package:vimeo_clone/bloc/shorts_visible/shorts_visible_state.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_keys.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/notification_service.dart';
import 'package:vimeo_clone/screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/utils/widgets/custom_bottom_sheet_button.dart';
import 'package:vimeo_clone/utils/widgets/custom_shorts_preview_homepage.dart';
import 'package:vimeo_clone/utils/widgets/no_internet_screen.dart';
import '../../Utils/Widgets/bottom_nav_bar.dart';
import '../../bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import '../../bloc/add_video_to_playlist/add_video_playlist_event.dart';
import '../../bloc/download_video/download_video_event.dart';
import '../../bloc/get_notification/get_notification_bloc.dart';
import '../../bloc/get_notification/get_notification_event.dart';
import '../../bloc/playlist_selection/playlist_selection_bloc.dart';
import '../../bloc/video_category/video_category_event.dart';
import '../../bloc/video_list/video_list_bloc.dart';
import '../../bloc/video_list/video_list_event.dart';
import '../../config/colors.dart';
import '../../config/internet_connectivity.dart';
import '../../utils/widgets/customBottomSheet.dart';
import '../../utils/widgets/custom_radio_button_list.dart';
import '../../utils/widgets/custom_save_to_playlist.dart';
import '../../utils/widgets/video_container.dart';
import '../user_page/user_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';





class HomePage extends StatefulWidget {
  final int index;
  const HomePage({super.key, this.index = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _picker = ImagePicker();
  late File _video;
  bool shortsVisible = false;
  late String slug = "";
  final channelId = Global.userData!.userChannelId;

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

    NotificationService(context: context);

    context.read<VideoCategoriesBloc>().add(GetCategoryEvent());
    context.read<GetSubscribedChannelListBloc>().add(GetSubscribedChannelListRequest());
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(channelId!)));
    context.read<GetPlansBloc>().add(GetPlansRequest());
    context.read<GetNotificationBloc>().add(GetNotificationRequest());
    _currentIndex = widget.index;
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

    // _navigateToIndex();_navigateToIndex

    return Scaffold(
      body: WillPopScope(
          child: screens[_currentIndex],
          onWillPop: () async {
      if(_currentIndex == 0) {
        SystemNavigator.pop();
      } else if (GlobalKeys.navigatorKey.currentState!.canPop()) {
    GlobalKeys.navigatorKey.currentState!.pop();
        setState(() {
          _currentIndex = 0;
          // _lastIndex = _selectedIndex;
        });
        return false;
      }
      return true;
    },
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
                            if(state is GetShortsSuccess){
                              if(Navigator.canPop(context)){
                                Navigator.pop(context);
                              }
                              WidgetsBinding.instance.addPostFrameCallback((_){
                                GoRouter.of(context).pushNamed('getShortsThumbnailPage');
                              });

                            }
                    return BottomSheetButton(
                      onTap: () {
                        context.read<GetShortsBloc>().add(GetShortsFromFile(context: context));
                      },
                      buttonName: AppLocalizations.of(context)!.createShort,
                      buttonIcon: HeroiconsOutline.camera,
                    );
                  })),
                  BottomSheetButton(
                    onTap: uploadVideoBottomSheet,
                    buttonName: AppLocalizations.of(context)!.uploadAVideo,
                    buttonIcon: HeroiconsOutline.arrowUpOnSquare,
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
                    if (state is GetVideoFailure) {
                      ToastManager().showToast(
                          context: context,
                          message: AppLocalizations.of(context)!.failToPickVideo
                      );
                    }
                    return BottomSheetButton(
                      onTap: () {
                        // if (Navigator.canPop(context)) {
                        //   Navigator.pop(context);
                        // }
                        context.read<GetVideoBloc>().add(OpenFilesToGetVideo());
                      },
                      buttonName: AppLocalizations.of(context)!.fromFiles,
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
                    buttonName: AppLocalizations.of(context)!.fromExternalSources,
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
  late final GlobalKey _menuKey;
  var progressString = "";
  String localFilePath = "";
  late var shortsLength = 0;
  final userChannelId = Global.userData!.userChannelId;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {


    CheckInternet.initConnectivity().then((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        setState(() {
          _connectionStatus = results;
        });
      }
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        CheckInternet.updateConnectionStatus(results).then((value) {
          setState(() {
            _connectionStatus = value;
          });
        });
      }
    });


    context.read<GetShortsListBloc>().add(GetShortsListRequest());
    final shortBloc = context.read<GetShortsListBloc>();

    shortBloc.stream.listen((state){
      if(state is GetShortsListLoaded){
        shortsLength = state.shortsList.length;
      }
    });


    super.initState();
    _menuKey = GlobalKey();
    // getTheme();
  }


  Future<void> _refreshVideosList() async {
    if (isAllCategorySelected) {
      context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
      context.read<GetShortsListBloc>().add(GetShortsListRequest());
      final shortBloc = context.read<GetShortsListBloc>();

      shortBloc.stream.listen((state){
        if(state is GetShortsListLoaded){
          shortsLength = state.shortsList.length;
        }
      });
    } else {
      // context.read<VideoListBloc>().add(GetVideoListEvent(categoryId: categoryId));
    }
  }


  List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context){
    return [
      {
        'name': AppLocalizations.of(context)!.saveToPlaylist,
        'icon': HeroiconsOutline.bookmark
      },
      {
        'name': AppLocalizations.of(context)!.downloadVideo,
        'icon': HeroiconsOutline.arrowDownTray
      },
      {
        'name': AppLocalizations.of(context)!.share,
        'icon': HeroiconsOutline.share
      },
      {
        'name': AppLocalizations.of(context)!.report,
        'icon': HeroiconsOutline.chatBubbleBottomCenterText
      },
    ];
  }

  void showReportDialog(BuildContext context, int videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(videoId: videoId,);
      },
    );
  }

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


  int _calculateExtraItems(int videoLength, int shortsLength) {
    if (shortsLength < 4) return 0; // If there are less than 4 shorts, don't show any shorts
    return 1 + (videoLength ~/ 4); // Shorts after every 4 videos and one after 1st
  }

// Helper function to adjust the index for "shorts" inserted in the list
  int _calculateShortsBeforeIndex(int index, int videoLength, int shortsLength) {
    if (shortsLength < 4) return 0; // If there are less than 4 shorts, don't adjust the index
    return (index == 1) ? 1 : (index ~/ 5); // 1st shorts at index 1, then every 5th position
  }





  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print('7777777777777777777    ${_connectionStatus}');

    // mode = context.read<ThemeBloc>().mode;
    // print('$mode   222222');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  title: BlocBuilder<ThemeBloc, ThemeMode>(
                    builder: (BuildContext context, ThemeMode state) {
                      final box = Hive.box('themebox');
                      final currentTheme = state;
                      return Container(
                        padding: EdgeInsets.only(left: 15.w),
                        child: currentTheme == ThemeMode.light
                            ? Image.asset('assets/images/homepage_logo_light.png', height: 75.h, width: 115.w,)
                            : Image.asset('assets/images/homepage_logo_dark.png', height: 75.h, width: 115.w,),
                      );
                    },
                  ),

                  titleSpacing: 1.0,
                  // floating: true,
                  // pinned: false,
                  // snap: false,
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
                  body: _connectionStatus.contains(connectivityCheck)
                      ? const NoInternetScreen()
                      : RefreshIndicator(
                    onRefresh: _refreshVideosList,
                    child: Column(
                    children: [
                      isAllCategorySelected
                          ? Expanded(
                            child: BlocBuilder<AllVideoListBloc, AllVideoListState>(
                                builder: (BuildContext context, state) {
                                if (state is AllVideoListLoading) {
                                  return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 8,
                                      itemBuilder: (context, index) {

                                        if (index == 2) {
                                          return Container(
                                            height: 400.h,
                                            child: GridView.builder(
                                              padding: EdgeInsets.only(
                                                top: 30.h,
                                                bottom: 25.h
                                              ),
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 300,
                                                mainAxisSpacing: 5.h,
                                                crossAxisSpacing: 5.h,
                                                childAspectRatio: 0.75,
                                              ),
                                              semanticChildCount: 2,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (BuildContext context, int index) {
                                                return ShimmerWidget.rectangular(
                                                  isBorder: true,
                                                  height: 120.h,
                                                  width: 80.w,
                                                );
                                              },
                                            ),
                                          );
                                        }


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
                                  return NotificationListener<ScrollNotification>(
                                        onNotification: (scrollInfo) {
                                          print('4787874466646946');
                                          print('******88    ${state.hasReachedMax}');
                                          print(
                                              "Current Scroll Position: ${scrollInfo.metrics.pixels}");
                                          print("Max Scroll Position: ${scrollInfo.metrics.maxScrollExtent}");
                                          print("Max Scroll Position:vhvh ${scrollInfo.metrics.pixels ==
                                              scrollInfo.metrics.maxScrollExtent}");

                                          // Check if the user has scrolled to the end and load more notes if needed
                                          if (!state.hasReachedMax &&
                                              scrollInfo.metrics.pixels ==
                                                  scrollInfo.metrics.maxScrollExtent) {
                                            print('hfghafyhgf');
                                            context.read<AllVideoListBloc>().add(LoadMoreVideoList());
                                          }
                                          return false;
                                        },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      // physics: const AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: ScreenSize.screenHeight(context) * 0.02),
                                      itemCount: state.hasReachedMax
                                          ? videoLength + _calculateExtraItems(videoLength, shortsLength) // Calculate extra items (shorts)
                                          : videoLength + _calculateExtraItems(videoLength, shortsLength) + 1, // Extra one for progress indicator
                                      itemBuilder: (BuildContext context, int index) {

                                        // if(state.videoList.isNotEmpty){
                                        //   // if ((index+1) % 3 == 0) {
                                        //   if (index == 1 || ((index > 1) && ((index - 1) % 5 == 0))) {
                                        //     return Column(
                                        //       children: [
                                        //         _shortsView(),
                                        //         SizedBox(
                                        //           height: 15.h,
                                        //         )
                                        //       ],
                                        //     );
                                        //   }
                                        // }


                                        if (shortsLength >= 4) {
                                          // Show shorts after 1st video, and then every 4 videos
                                          if (index == 1 || ((index > 1) && ((index - 1) % 5 == 0))) {
                                            return Column(
                                              children: [
                                                _shortsView(),
                                                SizedBox(height: 15.h),
                                              ],
                                            );
                                          }
                                        }

                                        // Show Circular Progress Indicator when loading more data
                                        if (index == videoLength + _calculateExtraItems(videoLength, shortsLength)) {
                                          if (!state.hasReachedMax) {
                                            return Center(child: CircularProgressIndicator());
                                          }
                                        }




                                        // if (state.videoList.isNotEmpty) {
                                        //   // Check if shortsList has at least 4 items before displaying shorts
                                        //   if (shortsLength >= 4) {
                                        //     // Show shorts logic based on video length
                                        //     if (videoLength <= 3) {
                                        //       // If there are 3 or fewer videos, show shorts only once after the first video
                                        //       if (index == 1) {
                                        //         return Column(
                                        //           children: [
                                        //             _shortsView(),
                                        //             SizedBox(height: 15.h),
                                        //           ],
                                        //         );
                                        //       }
                                        //     } else {
                                        //       // For more than 5 videos, show shorts after every 4 videos
                                        //       if (index == 1 || ((index > 1) && ((index - 1) % 5 == 0))) {
                                        //         return Column(
                                        //           children: [
                                        //             _shortsView(),
                                        //             SizedBox(height: 15.h),
                                        //           ],
                                        //         );
                                        //       }
                                        //     }
                                        //   }
                                        // }

                                        // Adjust the index to access the correct video item
                                        // final adjustedIndex = index - ((index + 4) ~/ 5);
                                        final adjustedIndex = index - _calculateShortsBeforeIndex(index, videoLength, shortsLength);
                                        // final adjustedIndex = index > 1 ? index - 1 : index;
                                        print('!!!!!!!!!!!!!!!!!!!!      ${state.videoList[adjustedIndex].duration}');
                                        int totalSeconds = state.videoList[adjustedIndex].duration!;
                                        String formattedTime = formatDuration(totalSeconds);
                                        final videoData = state.videoList[adjustedIndex];
;
                                        if(adjustedIndex < videoLength){
                                          return BlocListener<DownloadVideoBloc, DownloadVideoState>(
                                            listener: (context, state) {
                                              if (state is DownloadVideoInProgress) {}
                                              else if (state is DownloadVideoSuccess) {
                                                ToastManager().showToast(
                                                    context: context,
                                                    message: AppLocalizations.of(context)!.videoDownloadedSuccessfully
                                                );
                                              } else if (state is DownloadVideoFailure) {
                                                ToastManager().showToast(
                                                    context: context,
                                                    message: AppLocalizations.of(context)!.errorInHive
                                                );
                                              }

                                            },
                                            child: VideoListItem(
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
                                              onShowMorePressed: (){
                                                customShowMoreBottomSheet(
                                                    context,
                                                    bottomSheetListTileField(context),
                                                        (int index){
                                                      if(index == 0){
                                                        if(Navigator.canPop(context)){
                                                          Navigator.pop(context);
                                                        }
                                                        context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                                        showPlaylistBottomSheet(state.videoList[adjustedIndex].id!, userChannelId!);
                                                      }
                                                      else if(index == 1){
                                                        context.read<DownloadVideoBloc>().add(DownloadVideoRequest(
                                                          videoId: videoData.id.toString(),
                                                          videoSlug: videoData.slug!,
                                                          videoType: videoData.type!,
                                                          videoSource: videoData.video!,
                                                          videoThumbnail: videoData.thumbnail!,
                                                          videoTitle: videoData.title!,
                                                          videoDescription: videoData.description!,
                                                          videoHashtag: videoData.hashtag!,
                                                          videoCreateAtHuman: videoData.createdAtHuman!,
                                                          videoDuration: videoData.duration.toString(),
                                                          videoViews: videoData.views.toString(),
                                                          videoCategory: videoData.categories.toString(),
                                                          videoComments: "hey",
                                                          videoLikes: videoData.likes.toString(),
                                                          channelLogo: videoData.channel!.logo!,
                                                          channelName: videoData.channel!.name!,
                                                          contentType: "content-type",
                                                        ));
                                                        Navigator.pop(context);
                                                      }
                                                      else if(index == 2){

                                                        final String appLink = '${baseUrl}share?video=${videoData.slug}';
                                                        if(Navigator.canPop(context)){
                                                          Navigator.pop(context);
                                                        }
                                                        // Use the share_plus package to share the link
                                                        Share.share('Check out this video: $appLink');

                                                      }
                                                      else if(index == 3){
                                                        if(Navigator.canPop(context)){
                                                          Navigator.pop(context);
                                                        }
                                                        showReportDialog(context, videoData.id!);
                                                      }
                                                    }
                                                );
                                              },
                                            ),
                                          );
                                        }else{
                                          return const Center(child: CircularProgressIndicator(),);
                                        }

                                      },
                                    ),
                                  );
                                }
                                return Container();
                              }),
                          )
                          : BlocBuilder<VideoListBloc, VideoListState>(
                              builder: (BuildContext context, state) {
                                if (state is VideoListLoading) {
                                  return Expanded(
                                    child: ListView.builder(
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
                                                const SizedBox(height: 4),
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
                                        }),
                                  );
                                  // return Center(child: CircularProgressIndicator(),);
                                } else if (state is VideoListLoaded) {
                                  return Expanded(
                                        child: NotificationListener<ScrollNotification>(
                                          onNotification: (scrollInfo) {
                                            // Check if the user has scrolled to the end and load more notes if needed
                                            if (!state.hasReachedMax &&
                                                scrollInfo.metrics.pixels ==
                                                    scrollInfo.metrics.maxScrollExtent) {
                                              context.read<VideoListBloc>().add(LoadMoreVideoListCategory());
                                            }
                                            return false;
                                          },
                                          child: state.videoList.isNotEmpty ? ListView.builder(
                                              shrinkWrap: true,
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              padding: EdgeInsets.only(
                                                  top: ScreenSize.screenHeight(context) * 0.02),
                                              itemCount: state.hasReachedMax
                                                  ? state.videoList.length
                                                  : state.videoList.length + 1,
                                              itemBuilder: (BuildContext context, int index) {
                                                if (index == state.videoList.length) {
                                                  return Center(child: CircularProgressIndicator());
                                                }
                                                int totalSeconds = state.videoList[index].duration!;
                                                String formattedTime = formatDuration(totalSeconds);
                                                return VideoListItem(
                                                  onTap: () {
                                                    print('***************    ${state.videoList[index].slug}');
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
                                                  // uploadTime: '${state.videoList[index].createdAtHuman}',
                                                  uploadTime: '${state.videoList[index].createdAt}',
                                                  onShowMorePressed: (){
                                                    customShowMoreBottomSheet(
                                                        context,
                                                        bottomSheetListTileField(context),
                                                            (int index){
                                                          if(index == 0){
                                                            if(Navigator.canPop(context)){
                                                              Navigator.pop(context);
                                                            }
                                                            context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(userChannelId!)));
                                                            showPlaylistBottomSheet(state.videoList[index].id!, userChannelId!);
                                                          }
                                                          else if(index == 1){}
                                                          else if(index == 2){
                                                            final String appLink = '${baseUrl}share?video=${state.videoList[index].slug}';
                                                            if(Navigator.canPop(context)){
                                                              Navigator.pop(context);
                                                            }
                                                            // Use the share_plus package to share the link
                                                            Share.share('Check out this video: $appLink');
                                                          }
                                                          else if(index == 3){}
                                                        }
                                                    );
                                                  },
                                                );
                                              }) : Container(
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
                                        ),
                                      );
                                }

                                return Container();
                              },
                            ),
          ],
        ),
      ),

      // body: RefreshIndicator(
      //   onRefresh: _refreshVideosList,
      //   child: NotificationListener<ScrollNotification>(
      //     onNotification: (scrollInfo) {
      //       print('4787874466646946');
      //       print('******88    ${state.hasReachedMax}');
      //       print(
      //           "Current Scroll Position: ${scrollInfo.metrics.pixels}");
      //       print(
      //           "Max Scroll Position: ${scrollInfo.metrics.maxScrollExtent}");
      //
      //       // Check if the user has scrolled to the end and load more notes if needed
      //       if (!state.hasReachedMax &&
      //           scrollInfo.metrics.pixels ==
      //               scrollInfo.metrics.maxScrollExtent) {
      //         context.read<AllVideoListBloc>().add(LoadMoreVideoList());
      //       }
      //       return false;
      //     },
      //     child: CustomScrollView(
      //       slivers: [
      //         SliverAppBar(
      //           backgroundColor: Theme.of(context).colorScheme.surface,
      //           title: Container(
      //             padding: EdgeInsets.only(left: 15.w),
      //             child: mode == 1
      //                 ? Image.asset('assets/images/homepage_logo_light.png', height: 75.h, width: 115.w,)
      //                 : Image.asset('assets/images/homepage_logo_dark.png', height: 75.h, width: 115.w,),
      //           ),
      //
      //           titleSpacing: 1.0,
      //           floating: true,
      //           pinned: false,
      //           snap: false,
      //           actions: [
      //             IconButton(
      //               onPressed: () {
      //                 GoRouter.of(context).pushNamed('searchSuggestionPage');
      //               },
      //               icon: const Icon(
      //                 HeroiconsOutline.magnifyingGlass,
      //                 size: 22,
      //               ),
      //             ),
      //             // SizedBox(width: screenWidth * 0.01),
      //             IconButton(
      //               onPressed: () {
      //                 GoRouter.of(context).pushNamed('notificationPage');
      //               },
      //               icon: const Icon(
      //                 HeroiconsOutline.bell,
      //                 size: 22,
      //               ),
      //             ),
      //             SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
      //           ],
      //
      //           bottom: PreferredSize(
      //               preferredSize:
      //                   Size.fromHeight(ScreenSize.screenHeight(context) * 0.05),
      //               child: Column(
      //                 children: [
      //                   categoryListView(),
      //                   SizedBox(
      //                     height: ScreenSize.screenHeight(context) * 0.006,
      //                   )
      //                 ],
      //               )),
      //         ),
      //         SliverToBoxAdapter(
      //           // child: AllCategory(category: categoryList[isCategory]['type']),
      //           child: isAllCategorySelected
      //               ? BlocBuilder<AllVideoListBloc, AllVideoListState>(
      //                   builder: (BuildContext context, state) {
      //                   if (state is AllVideoListLoading) {
      //                     return ListView.builder(
      //                         padding: EdgeInsets.zero,
      //                         physics: NeverScrollableScrollPhysics(),
      //                         shrinkWrap: true,
      //                         itemCount: 8,
      //                         itemBuilder: (context, index) {
      //
      //                           if (index == 2) {
      //                             return Container(
      //                               height: 400.h,
      //                               child: GridView.builder(
      //                                 padding: EdgeInsets.only(
      //                                   top: 30.h,
      //                                   bottom: 25.h
      //                                 ),
      //                                 physics: const NeverScrollableScrollPhysics(),
      //                                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //                                   maxCrossAxisExtent: 300,
      //                                   mainAxisSpacing: 5.h,
      //                                   crossAxisSpacing: 5.h,
      //                                   childAspectRatio: 0.75,
      //                                 ),
      //                                 semanticChildCount: 2,
      //                                 shrinkWrap: true,
      //                                 itemCount: 4,
      //                                 itemBuilder: (BuildContext context, int index) {
      //                                   return ShimmerWidget.rectangular(
      //                                     isBorder: true,
      //                                     height: 120.h,
      //                                     width: 80.w,
      //                                   );
      //                                 },
      //                               ),
      //                             );
      //                           }
      //
      //
      //                           return Padding(
      //                             padding: EdgeInsets.only(top: 20.h),
      //                             child: Column(
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 AspectRatio(
      //                                     aspectRatio: 16 / 9,
      //                                     child: ShimmerWidget.rectangular(
      //                                       // width: double.infinity,
      //                                       // height: 200,
      //                                       isBorder: false,
      //                                       height: 50,
      //                                     )),
      //                                 SizedBox(height: 4),
      //                                 Row(
      //                                   children: [
      //                                     SizedBox(width: 8),
      //                                     ShimmerWidget.circular(
      //                                         width: 40,
      //                                         height: 40,
      //                                         isBorder: true),
      //                                     SizedBox(width: 8),
      //                                     Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         ShimmerWidget.rectangular(
      //                                           height: 16,
      //                                           width: 120,
      //                                           isBorder: true,
      //                                         ),
      //                                         SizedBox(height: 8),
      //                                         ShimmerWidget.rectangular(
      //                                           height: 16,
      //                                           width: 200,
      //                                           isBorder: true,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           );
      //                         });
      //                     // return Center(child: CircularProgressIndicator(),);
      //                   } else if (state is AllVideoListLoaded) {
      //                     final videoLength = state.videoList.length;
      //                     return ListView.builder(
      //                       shrinkWrap: true,
      //                       physics: const NeverScrollableScrollPhysics(),
      //                       padding: EdgeInsets.only(top: ScreenSize.screenHeight(context) * 0.02),
      //                       itemCount: state.hasReachedMax
      //                           ? videoLength + (videoLength ~/ 2) // For shortsContainer after every 2 videos
      //                           : videoLength + (videoLength ~/ 2) + 1,
      //                       itemBuilder: (BuildContext context, int index) {
      //                         if(state.videoList.length >= 2){
      //                           if ((index+1) % 2 == 0) {
      //                             return Column(
      //                               children: [
      //                                 // shortsLength == 4 ?
      //                                 _shortsView() ,
      //                                     // : Container(),
      //                                 // state.videoList.length > 3 ? _shortsView() : Container(),
      //                                 SizedBox(
      //                                   height: 15.h,
      //                                 )
      //                               ],
      //                             );
      //                           }
      //                         }
      //
      //
      //
      //                         // if (index == 6) {
      //                         //   return Column(
      //                         //     children: [
      //                         //       _shortsView(),
      //                         //       SizedBox(
      //                         //         height: 15.h,
      //                         //       )
      //                         //     ],
      //                         //   );
      //                         // }
      //
      //
      //                         // Adjust the index to access the correct video item
      //                         final adjustedIndex = index - (index ~/ 2);
      //                         // final adjustedIndex = index > 1 ? index - 1 : index;
      //                         print('!!!!!!!!!!!!!!!!!!!!      ${state.videoList[adjustedIndex].duration}');
      //                         int totalSeconds = state.videoList[adjustedIndex].duration!;
      //                         String formattedTime = formatDuration(totalSeconds);
      //                         final videoData = state.videoList[adjustedIndex];
      //
      //                         final type = state.videoList[adjustedIndex].type;
      //                         if(adjustedIndex < videoLength){
      //                           return BlocListener<DownloadVideoBloc, DownloadVideoState>(
      //                             listener: (context, state) {
      //                               if (state is DownloadVideoInProgress) {
      //                                 // int progressPercentage = (state.progress * 100).toInt();
      //                                 //
      //                                 // // Show or update the snackbar with the current progress
      //                                 // DownloadVideoSnackbar().updateProgressSnackbar(context, progressPercentage);
      //
      //                               } else if (state is DownloadVideoSuccess) {
      //
      //                                 // Dismiss the progress snackbar and show a success snackbar
      //                                 // DownloadVideoSnackbar().dismissSnackbar(context);
      //                                 // DownloadVideoSnackbar().showSuccessSnackbar(context, "Download complete!");
      //                                 ToastManager().showToast(
      //                                     context: context,
      //                                     message: 'Video downloaded successfully'
      //                                 );
      //                               } else if (state is DownloadVideoFailure) {
      //                                 ToastManager().showToast(
      //                                     context: context,
      //                                     message: 'Errrrroorr in Hive'
      //                                 );
      //                                 // Dismiss the progress snackbar and show an error snackbar
      //                                 // DownloadVideoSnackbar().dismissSnackbar(context);
      //                                 // DownloadVideoSnackbar().showErrorSnackbar(context, state.error);
      //                               }
      //
      //                             },
      //                             child: VideoListItem(
      //                               onTap: () {
      //                                 Future.delayed(const Duration(milliseconds: 200), () {
      //                                   GoRouter.of(context).pushNamed('videoPage', pathParameters: {
      //                                     "slug": state.videoList[adjustedIndex].slug!
      //                                   });
      //                                 });
      //                               },
      //                               onTapChannel: () {
      //                                 final String channelId =
      //                                 state.videoList[adjustedIndex].channel!.id.toString();
      //                                 GoRouter.of(context).pushNamed('channelProfilePage',
      //                                     pathParameters: {'channelId': channelId});
      //                               },
      //                               channelPhoto: state.videoList[adjustedIndex].channel?.logo ??
      //                                   'assets/images/sonysab.jpg',
      //                               thumbnailUrl: '${state.videoList[adjustedIndex].thumbnail}',
      //                               duration: formattedTime,
      //                               title: '${state.videoList[adjustedIndex].title}',
      //                               author: '${state.videoList[adjustedIndex].channel?.name}',
      //                               views: '${state.videoList[adjustedIndex].views}',
      //                               uploadTime: '${state.videoList[adjustedIndex].createdAtHuman}',
      //                               onMorePressed: (){
      //                                 customShowMoreBottomSheet(
      //                                     context,
      //                                     bottomSheetListTileField,
      //                                         (int index){
      //                                       if(index == 1){
      //                                         context.read<DownloadVideoBloc>().add(DownloadVideoRequest(
      //                                           videoId: videoData.id.toString(),
      //                                           videoSlug: videoData.slug!,
      //                                           videoType: videoData.type!,
      //                                           videoSource: videoData.video!,
      //                                           videoThumbnail: videoData.thumbnail!,
      //                                           videoTitle: videoData.title!,
      //                                           videoDescription: videoData.description!,
      //                                           videoHashtag: videoData.hashtag!,
      //                                           videoCreateAtHuman: videoData.createdAtHuman!,
      //                                           videoDuration: videoData.duration.toString(),
      //                                           videoViews: videoData.views.toString(),
      //                                           videoCategory: videoData.categories.toString(),
      //                                           videoComments: "hey",
      //                                           videoLikes: videoData.likes.toString(),
      //                                           channelLogo: videoData.channel!.logo!,
      //                                           channelName: videoData.channel!.name!,
      //                                           contentType: "content-type",
      //                                         ));
      //                                         Navigator.pop(context);
      //                                       }
      //                                       else if(index == 2){
      //                                         GoRouter.of(context).pushNamed('settingPage');
      //                                       }
      //                                       else if(index == 3){
      //                                         if(Navigator.canPop(context)){
      //                                           Navigator.pop(context);
      //                                         }
      //                                         showReportDialog(context, videoData.id!);
      //                                       }
      //                                     }
      //                                 );
      //                               },
      //                             ),
      //                           );
      //                         }else{
      //                           return Center(child: CircularProgressIndicator(),);
      //                         }
      //
      //                       },
      //                     );
      //                   }
      //                   return Container();
      //                 })
      //               : BlocBuilder<VideoListBloc, VideoListState>(
      //                   builder: (BuildContext context, state) {
      //                     if (state is VideoListLoading) {
      //                       return ListView.builder(
      //                           padding: EdgeInsets.zero,
      //                           physics: const NeverScrollableScrollPhysics(),
      //                           shrinkWrap: true,
      //                           itemCount: 8,
      //                           itemBuilder: (context, index) {
      //
      //                             return Padding(
      //                               padding: EdgeInsets.only(top: 20.h),
      //                               child: Column(
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   AspectRatio(
      //                                       aspectRatio: 16 / 9,
      //                                       child: ShimmerWidget.rectangular(
      //                                         // width: double.infinity,
      //                                         // height: 200,
      //                                         isBorder: false,
      //                                         height: 50,
      //                                       )),
      //                                   const SizedBox(height: 4),
      //                                   Row(
      //                                     children: [
      //                                       const SizedBox(width: 8),
      //                                       const ShimmerWidget.circular(
      //                                           width: 40,
      //                                           height: 40,
      //                                           isBorder: true),
      //                                       const SizedBox(width: 8),
      //                                       Column(
      //                                         crossAxisAlignment:
      //                                             CrossAxisAlignment.start,
      //                                         children: [
      //                                           ShimmerWidget.rectangular(
      //                                             height: 16,
      //                                             width: 120,
      //                                             isBorder: true,
      //                                           ),
      //                                           const SizedBox(height: 8),
      //                                           ShimmerWidget.rectangular(
      //                                             height: 16,
      //                                             width: 200,
      //                                             isBorder: true,
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ],
      //                               ),
      //                             );
      //                           });
      //                       // return Center(child: CircularProgressIndicator(),);
      //                     } else if (state is VideoListLoaded) {
      //                       return state.videoList.isNotEmpty
      //                           ? ListView.builder(
      //                               shrinkWrap: true,
      //                               physics: const NeverScrollableScrollPhysics(),
      //                               padding: EdgeInsets.only(
      //                                   top: ScreenSize.screenHeight(context) * 0.02),
      //                               itemCount: state.videoList.length,
      //                               itemBuilder: (BuildContext context, int index) {
      //                                 final type = state.videoList[index].type;
      //                                     int totalSeconds = state.videoList[index].duration!;
      //                                 String formattedTime =
      //                                     formatDuration(totalSeconds);
      //
      //                                 return type == "video" ? VideoListItem(
      //                                   onTap: () {
      //                                     print(
      //                                         '***************    ${state.videoList[index].slug}');
      //                                     Future.delayed(
      //                                         const Duration(milliseconds: 200),
      //                                         () {
      //                                           print('Video clicked>>>>>>>>>>>>>.');
      //                                       GoRouter.of(context).pushNamed('videoPage',
      //                                           pathParameters: {
      //                                             "slug":
      //                                                 state.videoList[index].slug!
      //                                           });
      //                                     });
      //                                   },
      //                                   channelPhoto: state.videoList[index].channel?.logo ?? 'assets/images/sonysab.jpg',
      //                                   thumbnailUrl: '${state.videoList[index].thumbnails}',
      //                                   duration: formattedTime,
      //                                   title: '${state.videoList[index].title}',
      //                                   author: '${state.videoList[index].channel?.name}',
      //                                   views: '${state.videoList[index].views}',
      //                                   uploadTime: '${state.videoList[index].createdAtHuman}',
      //                                   onMorePressed: (){
      //                                     customShowMoreBottomSheet(
      //                                         context,
      //                                         bottomSheetListTileField,
      //                                             (int index){
      //                                           if(index == 2){
      //                                             GoRouter.of(context).pushNamed('settingPage');
      //                                           }
      //                                         }
      //                                     );
      //                                   },
      //                                 ) : null;
      //                               })
      //                           : Padding(
      //                               padding: EdgeInsets.only(top: 150.h),
      //                               child: Center(
      //                                   child: Image.asset(
      //                                 'assets/images/no_data.png',
      //                                 width: 200.w,
      //                                 height: 200.h,
      //                               )),
      //                             );
      //                     }
      //
      //                     return Container();
      //                   },
      //                 ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
              Icon(HeroiconsSolid.fire, color: primaryColor),
              SizedBox(width: 3.w,),
              Text(
                AppLocalizations.of(context)!.shorts,
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
          BlocBuilder<GetShortsListBloc, GetShortsListState>(
            builder: (BuildContext context, GetShortsListState state) {
              if(state is GetShortsListLoaded){
                return SizedBox(
                  height: 430.h,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220.h,
                      mainAxisSpacing: 5.h,
                      crossAxisSpacing: 5.h,
                      childAspectRatio: 0.71,
                    ),
                    semanticChildCount: 2,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      final shortsData = state.shortsList[index];
                      return CustomShortsPreviewHomepage(
                        onTap: (){


                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(
                          //         index: 1), // Navigate to index 1
                          //   ),
                          // );


                          // context.read<ShortsVisibleBloc>().add(ShortsVisibleRequest(
                          //     slug: shortsData.slug!,
                          //   shortVisible: true
                          // ));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => PlayHomeShortsPage(shortsSlug: shortsData.slug!))
                          // );

                          // PlayHomeShortsPage(shortsSlug: shortsData.slug!,);
                        },
                        localImage: '',
                        thumbNailPath: '${shortsData.thumbnail}',
                        title: '${shortsData.title}',
                      );
                    },
                  ),
                );
              }
              return Container(
                height: 400.h,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 5.h,
                    crossAxisSpacing: 5.h,
                    childAspectRatio: 0.75,
                  ),
                  semanticChildCount: 2,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return ShimmerWidget.rectangular(
                        isBorder: true,
                      height: 120.h,
                      width: 80.w,
                    );
                  },
                ),
              );
            },
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
                padding: const EdgeInsets.only(
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
          return _connectionStatus.contains(connectivityCheck)
              ? SizedBox.shrink() : Container(
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



class ReportDialog extends StatefulWidget {
  final int videoId;
  const ReportDialog({super.key, required this.videoId});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      title: Text(AppLocalizations.of(context)!.reportContent),
      content: RadioButtonList<String>(
        options: [
          AppLocalizations.of(context)!.violentContent,
          AppLocalizations.of(context)!.hatefulContent,
          AppLocalizations.of(context)!.harmfulContent,
          AppLocalizations.of(context)!.spam,
          AppLocalizations.of(context)!.childAbuse
        ],
        selectedValue: _selectedValue,
        onChanged: (String newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              fontFamily: fontFamily,
              color: greyShade500
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle the selected value here
            final userId = int.parse(Global.userData!.userId!);
            print('Selected value: $_selectedValue');
            context.read<ReportVideoBloc>().add(ReportVideoRequest(
                userId: userId,
                videoId: widget.videoId,
                reportContent: _selectedValue
            ));
            Navigator.of(context).pop();
            final reportBloc = context.read<ReportVideoBloc>();
            reportBloc.stream.listen((state){
              if(state is ReportVideoSuccess){
                if(mounted){
                  ToastManager().showToast(
                      context: context,
                      message: state.reportApiMessage
                  );
                }
              }
            });

          },
          child: Text(
            AppLocalizations.of(context)!.report,
            style: TextStyle(
              fontFamily: fontFamily,
              color: primaryColor
            ),
          ),
        ),
      ],
    );
  }
}


