import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
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
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/notification_service.dart';
import 'package:vimeo_clone/screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/utils/widgets/custom_bottom_sheet_button.dart';
import 'package:vimeo_clone/utils/widgets/custom_download_progress_dialog.dart';
import 'package:vimeo_clone/utils/widgets/custom_shorts_preview_homepage.dart';
import '../../Utils/Widgets/bottom_nav_bar.dart';
import '../../bloc/download_video/download_video_event.dart';
import '../../bloc/video_category/video_category_event.dart';
import '../../bloc/video_list/video_list_bloc.dart';
import '../../bloc/video_list/video_list_event.dart';
import '../../config/colors.dart';
import '../../utils/widgets/customBottomSheet.dart';
import '../../utils/widgets/video_container.dart';
import '../download_video/download_video_page.dart';
import '../user_page/user_page.dart';
import 'package:dio/dio.dart';

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

    NotificationService(context: context);

    context.read<GetSubscribedChannelListBloc>().add(GetSubscribedChannelListRequest());
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
    context.read<GetPlansBloc>().add(GetPlansRequest());
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
                      buttonName: 'Create short',
                      buttonIcon: HeroiconsOutline.camera,
                    );
                  })),
                  BottomSheetButton(
                    onTap: uploadVideoBottomSheet,
                    buttonName: 'Upload a Video',
                    buttonIcon: HeroiconsOutline.arrowUpOnSquare,
                  ),
                  // BottomSheetButton(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     CupertinoPageRoute(builder: (context) => CropShortsPage())
                  //     // );
                  //   },
                  //   buttonName: 'Go Live',
                  //   buttonIcon: HeroiconsOutline.tv,
                  // ),
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
                          message: 'Fail to pick video'
                      );
                    }
                    return BottomSheetButton(
                      onTap: () {
                        // if (Navigator.canPop(context)) {
                        //   Navigator.pop(context);
                        // }
                        context.read<GetVideoBloc>().add(OpenFilesToGetVideo());
                      },
                      buttonName: 'From files',
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
                    buttonName: 'From external sources',
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

  final imgUrl = "https://videoapp.taskhub.company//storage/shorts/6A05pLVmYdLl6HN6zfGc4wCixHDrISmeiUGcucB0.mp4";
  bool downloading = false;
  var progressString = "";
  String localFilePath = "";
  late var shortsLength = 0;

  @override
  void initState() {

    context.read<GetShortsListBloc>().add(GetShortsListRequest());
    final shortBloc = context.read<GetShortsListBloc>();

    shortBloc.stream.listen((state){
      if(state is GetShortsListLoaded){
        shortsLength = state.shortsData.first.data!.data!.length;
      }
    });


    super.initState();
    _menuKey = GlobalKey();
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
      context.read<AllVideoListBloc>().add(GetAllVideoListEvent());
    } else {
      // context.read<VideoListBloc>().add(GetVideoListEvent(categoryId: categoryId));
    }
  }

  List<Map<String, dynamic>> bottomSheetListTileField = [
    {
      'name': 'Save to playlist',
      'icon': HeroiconsOutline.bookmark
    },
    {
      'name': 'Download video',
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


  // DOWNLOAD VIDEO ________________________________________________________
  // Future<void> downloadFile() async {
  //   Dio dio = Dio();
  //
  //   try {
  //     // Get the app's documents directory (internal storage)
  //     var dir = await getApplicationDocumentsDirectory();
  //     print("App Documents path: ${dir.path}");
  //
  //     // File path to save in the app's internal files folder
  //     String filePath = "${dir.path}/demo.mp4";
  //
  //     // Start downloading the file
  //     await dio.download(
  //       imgUrl, filePath,
  //       onReceiveProgress: (rec, total) {
  //         print("Rec: $rec , Total: $total");
  //
  //         setState(() {
  //           downloading = true;
  //           progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
  //         });
  //       },
  //     );
  //
  //     // After download completion
  //     setState(() {
  //       downloading = false;
  //       progressString = "Completed";
  //       localFilePath = filePath;
  //     });
  //
  //     // The video is now saved only in the app's files folder
  //     print("Video saved to app's files folder: $filePath");
  //
  //   } catch (e) {
  //     print(e);
  //   }
  // }





  Future<void> downloadFile(BuildContext context) async {
    Dio dio = Dio();

    try {
      // Request storage permission
      bool hasPermission = await requestStoragePermission(context);
      if (!hasPermission) return;

      // Get the app's Documents directory
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/test_shorts.mp4";

      // Start downloading the file
      await dio.download(
        imgUrl, filePath,
        onReceiveProgress: (rec, total) {
          print("Rec: $rec , Total: $total");

          // Update UI with download progress
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Download progress: ${((rec / total) * 100).toStringAsFixed(0)}%')),
          // );
        },
      );

      // After download completion
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Download completed')),
      // );

      if (Platform.isAndroid) {
        // Move the file to Downloads folder on Android
        final externalDir = Directory('/storage/emulated/0/Download');
        if (!await externalDir.exists()) {
          await externalDir.create(recursive: true);
        }
        String newFilePath = "${externalDir.path}/test_shorts.mp4";
        final file = File(filePath);
        await file.copy(newFilePath);
        print("Video saved to Downloads folder: $newFilePath");

        // Optionally, delete the original file from internal storage
        await file.delete();

      } else if (Platform.isIOS) {
        // Save the video to the Photos library on iOS
        final asset = await PhotoManager.editor.saveVideo(filePath as File);
        print('Video saved to photo library: $filePath');
      }

    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while downloading the file.')),
      );
    }
  }

// Request permission to access storage
  Future<bool> requestStoragePermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission is required to save the file.')),
        );
        return false;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      if (status.isGranted) {
        return true;
      } else if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo library permission is required to save the file.')),
        );
        return false;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
    }
    return false;
  }



  // Future<bool> requestStoragePermission(BuildContext context) async {
  //   if (Platform.isAndroid) {
  //     final status = await Permission.storage.status;
  //
  //     if (status.isGranted) {
  //       // Permission already granted
  //       return true;
  //     } else if (status.isDenied) {
  //       // Request permission
  //       final newStatus = await Permission.storage.request();
  //       if (newStatus.isGranted) {
  //         return true;
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Storage permission is required to save the file.')),
  //         );
  //         return false;
  //       }
  //     } else if (status.isPermanentlyDenied) {
  //       // Redirect to app settings
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please enable storage permission in settings.')),
  //       );
  //       await Future.delayed(Duration(seconds: 3)); // Optional delay
  //       await openAppSettings();
  //       return false;
  //     }
  //   } else if (Platform.isIOS) {
  //     final status = await Permission.photos.status;
  //
  //     if (status.isGranted) {
  //       // Permission already granted
  //       return true;
  //     } else if (status.isDenied) {
  //       // Request permission
  //       final newStatus = await Permission.photos.request();
  //       if (newStatus.isGranted) {
  //         return true;
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Photo library permission is required to save the file.')),
  //         );
  //         return false;
  //       }
  //     } else if (status.isPermanentlyDenied) {
  //       // Redirect to app settings
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please enable photo library access in settings.')),
  //       );
  //       await Future.delayed(Duration(seconds: 3)); // Optional delay
  //       await openAppSettings();
  //       return false;
  //     }
  //   }
  //   return false;
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
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: ScreenSize.screenHeight(context) * 0.02),
                          itemCount: videoLength + 1, // Add 1 to account for the inserted container
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 2) { // Insert the container between index 2 and 3
                              return Column(
                                children: [
                                  shortsLength == 4 ? _shortsView() : Container(),
                                  SizedBox(
                                    height: 15.h,
                                  )
                                ],
                              );
                            }

                            // if (index == 6) {
                            //   return Column(
                            //     children: [
                            //       _shortsView(),
                            //       SizedBox(
                            //         height: 15.h,
                            //       )
                            //     ],
                            //   );
                            // }


                            // Adjust the index to access the correct video item
                            final adjustedIndex = index > 2 ? index - 1 : index;
                            final type = state.videoList[adjustedIndex].type;
                            print('!!!!!!!!!!!!!!!!!!!!      ${state.videoList[adjustedIndex].duration}');
                            int totalSeconds = state.videoList[adjustedIndex].duration!;
                            String formattedTime = formatDuration(totalSeconds);
                            final videoData = state.videoList[adjustedIndex];
                            return type == "video" ? BlocListener<DownloadVideoBloc, DownloadVideoState>(
                              listener: (context, state) {
                                if (state is DownloadVideoInProgress) {

                                  int progressPercentage = (state.progress * 100).toInt();
                                  DownloadVideoAlertDialog().showDownloadProgressDialog(context, progressPercentage);

                                } else if (state is DownloadVideoSuccess) {

                                  DownloadVideoAlertDialog().showSuccessDialog(context, "Download complete!");
                                } else if (state is DownloadVideoFailure) {
                                  // Show error dialog
                                  DownloadVideoAlertDialog().showErrorDialog(context, state.error);
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
                                      onMorePressed: (){
                                      customShowMoreBottomSheet(
                                        context,
                                        bottomSheetListTileField,
                                        (int index){
                                          if(index == 1){
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
                                              videoComments: "0",
                                              videoLikes: videoData.likes.toString(),
                                              channelLogo: videoData.channel!.logo!,
                                              channelName: videoData.channel!.name!,
                                              contentType: "content-type",
                                            ));
                                          }
                                          else if(index == 2){
                                            GoRouter.of(context).pushNamed('settingPage');
                                          }
                                        }
                                      );
                                      },
                                  ),
                                )
                                : null;
                          },
                        );
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
                              });
                          // return Center(child: CircularProgressIndicator(),);
                        } else if (state is VideoListLoaded) {
                          return state.videoList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                      top: ScreenSize.screenHeight(context) * 0.02),
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
                                      onMorePressed: (){
                                        customShowMoreBottomSheet(
                                            context,
                                            bottomSheetListTileField,
                                                (int index){
                                              if(index == 2){
                                                GoRouter.of(context).pushNamed('settingPage');
                                              }
                                            }
                                        );
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




  List<Map<String, dynamic>> shortsThumbnail = [
    {
      'thumbnail': 'assets/images/tmkoc8.jpg',
      'title': 'Tarak mehta ka ooltah chashma',
    },
    {
      'thumbnail': 'assets/images/tmkoc2.jpg',
      'title': 'Jab boss aapko last minute koi kaam dede',
    },
    {
      'thumbnail': 'assets/images/tmkoc6.jpg',
      'title': 'When your friend believes too much in superstition',
    },
    {
      'thumbnail': 'assets/images/tmkoc10.jpg',
      'title': 'Mood Nowadays..',
    }
  ];

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
                      final shortsData = state.shortsData.first.data!.data![index];
                      return CustomShortsPreviewHomepage(
                        onTap: (){},
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
