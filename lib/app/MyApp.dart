import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/Config/theme_data.dart';
import 'package:vimeo_clone/Repo/auth_repo.dart';
import 'package:vimeo_clone/Repo/video_category_repo.dart';
import 'package:vimeo_clone/Repo/video_list_repo.dart';
import 'package:vimeo_clone/appLinks.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_bloc.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_state.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_bloc.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_bloc.dart';
import 'package:vimeo_clone/bloc/add_user_history/add_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_event.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_bloc.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/routes/myapproute.dart';

import '../bloc/get_subscribed_channel_list/get_subscribed_channel_list_bloc.dart';



final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

// Subscribe to all events (initial link and further)
  final AppLinksDeepLink _appLinksDeepLink = AppLinksDeepLink.instance;


  @override
  Widget build(BuildContext context) {
    _appLinksDeepLink.initDeepLinks();


    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => ThemeBloc(Hive.box('themeBox'))..add(ThemeLoadEvent())),
        BlocProvider(create: (context) => YourVideosBloc()..add(GetYourVideosEvent())),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => AuthBloc(AuthRepository(ApiBaseHelper()))),
        BlocProvider(create: (context) => VideoCategoriesBloc(VideoCategoriesRepo())..add(GetCategoryEvent())),
        BlocProvider(create: (context) => VideoListBloc(VideoListRepo())),
        BlocProvider(create: (context) => CategorySelectionBloc()),
        BlocProvider(create: (context) => AllVideoListBloc()..add(GetAllVideoListEvent())),
        BlocProvider(create: (context) => PlayVideoBloc()),
        BlocProvider(create: (context) => GetVideoBloc()),
        BlocProvider(create: (context) => GetThumbnailBloc()),
        BlocProvider(create: (context) => UploadVideoBloc()),
        BlocProvider(create: (context) => UploadVideoExternalBloc()),
        BlocProvider(create: (context) => ChannelProfileBloc()),
        BlocProvider(create: (context) => GetShortsBloc()),
        BlocProvider(create: (context) => GetShortsThumbnailBloc()),
        BlocProvider(create: (context) => GetShortsListBloc()..add(GetShortsListRequest())),
        BlocProvider(create: (context) => GetSubscribedChannelListBloc()..add(GetSubscribedChannelListRequest()),),
        BlocProvider(create: (context) => SubscribeChannelBloc()),
        BlocProvider(create: (context) => ViewIncrementBloc()),
        BlocProvider(create: (context) => LikeDislikeVideoBloc()),
        BlocProvider(create: (context) => UserHistoryBloc()),
        BlocProvider(create: (context) => GetUserHistoryBloc()..add(GetUserHistoryRequest())),
        BlocProvider(create: (context) => GetUserPlaylistBloc()),
        BlocProvider(create: (context) => PlaylistSelectionBloc()),
        BlocProvider(create: (context) => CreatePlaylistBloc()),
        BlocProvider(create: (context) => AddVideoToPlaylistBloc()),
        BlocProvider(create: (context) => SearchDataBloc()),

      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (BuildContext context, themeMode) {
          return ScreenUtilInit(
            child: MaterialApp.router(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('hi'), // Hindi
              ],
              scaffoldMessengerKey: scaffoldMessengerKey,
              routerConfig: router,
            ),
          );
        }
      ),
    );
  }
}





