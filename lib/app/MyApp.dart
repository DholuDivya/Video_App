import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';
import 'package:vimeo_clone/Config/theme_data.dart';
import 'package:vimeo_clone/Repo/auth_repo.dart';
import 'package:vimeo_clone/Repo/video_category_repo.dart';
import 'package:vimeo_clone/Repo/video_list_repo.dart';
import 'package:vimeo_clone/appLinks.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_bloc.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_event.dart';
import 'package:vimeo_clone/bloc/add_comment/add_comment_bloc.dart';
import 'package:vimeo_clone/bloc/add_video_to_playlist/add_video_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_bloc.dart';
import 'package:vimeo_clone/bloc/all_video_list/all_video_list_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/create_playlist/create_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/delete_playlist/delete_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/edit_channel/edit_channel_bloc.dart';
import 'package:vimeo_clone/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:vimeo_clone/bloc/generate_signature/generate_signature_bloc.dart';
import 'package:vimeo_clone/bloc/get_channel_logo/get_channel_logo_bloc.dart';
import 'package:vimeo_clone/bloc/get_comments/get_comments_bloc.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_bloc.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_shorts_list/get_shorts_list_event.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_from_user/get_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_video_from_user/get_video_bloc.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike/like_dislike_bloc.dart';
import 'package:vimeo_clone/bloc/like_dislike_comment/like_dislike_comment_bloc.dart';
import 'package:vimeo_clone/bloc/play_video/play_video_bloc.dart';
import 'package:vimeo_clone/bloc/playlist_selection/playlist_selection_bloc.dart';
import 'package:vimeo_clone/bloc/privacy_policy/privacy_policy_bloc.dart';
import 'package:vimeo_clone/bloc/privacy_policy/privacy_policy_event.dart';
import 'package:vimeo_clone/bloc/remove_video_from_history/remove_video_from_history_bloc.dart';
import 'package:vimeo_clone/bloc/remove_video_from_playlist/remove_video_from_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_bloc.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_bloc.dart';
import 'package:vimeo_clone/bloc/search_data/search_data_bloc.dart';
import 'package:vimeo_clone/bloc/search_suggestion/search_suggestion_bloc.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_bloc.dart';
import 'package:vimeo_clone/bloc/settings_api/settings_api_bloc.dart';
import 'package:vimeo_clone/bloc/shorts_visible/shorts_visible_bloc.dart';
import 'package:vimeo_clone/bloc/show_single_playlist/show_single_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_bloc.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_event.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/upload_shorts/upload_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video/upload_video_bloc.dart';
import 'package:vimeo_clone/bloc/upload_video_external/upload_video_external_bloc.dart';
import 'package:vimeo_clone/bloc/add_user_history/add_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/user_transaction/user_transaction_bloc.dart';
import 'package:vimeo_clone/bloc/verify_payment/verify_payment_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_event.dart';
import 'package:vimeo_clone/bloc/video_list/video_list_bloc.dart';
import 'package:vimeo_clone/bloc/view_increment/view_increment_bloc.dart';
import 'package:vimeo_clone/bloc/your_shorts/your_shorts_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/global_keys.dart';
import 'package:vimeo_clone/routes/myapproute.dart';
import 'package:vimeo_clone/screens/videoPage/videopage.dart';
import '../bloc/download_video/download_video_bloc.dart';
import '../bloc/edit_video_detail/edit_video_detail_bloc.dart';
import '../bloc/get_subscribed_channel_list/get_subscribed_channel_list_bloc.dart';
import '../config/notification_service.dart';
import '../generated/l10n.dart';


//
// final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

// Subscribe to all events (initial link and further)
  final AppLinksDeepLink _appLinksDeepLink = AppLinksDeepLink.instance;

  @override
  void initState() {
    super.initState();
    _initializeNotification();
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // App was launched via a notification
        final videoSlug = message.data['extra_data']; // Extract slug or provide a default
        // final videoSlug = 'sajan';
        // Navigate directly to the videoPage
        _handleDirectNavigation(videoSlug);
      }
    });
  }

  void _handleDirectNavigation(String videoSlug) {
    final navigatorContext = GlobalKeys.navigatorKey.currentContext;
    if (navigatorContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            navigatorContext,
            CupertinoPageRoute(builder: (navigatorContext) => VideoPage(slug: videoSlug))
        );
      });
    }
  }

  Future<void> _initializeNotification() async {
    await NotificationService(context: context).initFirebaseMessaging(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appLinksDeepLink.initDeepLinks(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => YourVideosBloc()),
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
        BlocProvider(create: (context) => ShowSinglePlaylistBloc()),
        BlocProvider(create: (context) => SearchSuggestionBloc()),
        BlocProvider(create: (context) => GetCommentsBloc()),
        BlocProvider(create: (context) => AddCommentBloc()),
        BlocProvider(create: (context) => LikeDislikeCommentBloc()),
        BlocProvider(create: (context) => EditChannelBloc()),
        BlocProvider(create: (context) => GetChannelLogoBloc()),
        BlocProvider(create: (context) => GetPlansBloc()),
        BlocProvider(create: (context) => GenerateSignatureBloc()),
        BlocProvider(create: (context) => VerifyPaymentBloc()),
        BlocProvider(create: (context) => EditVideoDetailBloc()),
        BlocProvider(create: (context) => RemoveVideoFromHistoryBloc()),
        BlocProvider(create: (context) => RemoveVideoFromPlaylistBloc()),
        BlocProvider(create: (context) => DeletePlaylistBloc()),
        BlocProvider(create: (context) => ForgotPasswordBloc()),
        BlocProvider(create: (context) => ResetPasswordBloc()),
        BlocProvider(create: (context) => UploadShortsBloc()),
        BlocProvider(create: (context) => DownloadVideoBloc()),
        BlocProvider(create: (context) => GetNotificationBloc()),
        BlocProvider(create: (context) => AboutUsBloc()..add(AboutUsRequest())),
        BlocProvider(create: (context) => TermsAndConditionsBloc()..add(TermsAndConditionsRequest())),
        BlocProvider(create: (context) => PrivacyPolicyBloc()..add(PrivacyPolicyRequest())),
        BlocProvider(create: (context) => ReportVideoBloc()),
        BlocProvider(create: (context) => HelpAndSupportBloc()),
        BlocProvider(create: (context) => ShortsVisibleBloc()),
        BlocProvider(create: (context) => UserTransactionBloc()),
        BlocProvider(create: (context) => YourShortsBloc()),
        BlocProvider(create: (context) => SettingsApiBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (BuildContext context, themeMode) {
          return ScreenUtilInit(
            child: MaterialApp.router(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              // localizationsDelegates: AppLocalizations.localizationsDelegates,
              // supportedLocales: AppLocalizations.supportedLocales,
              // localeResolutionCallback: (locale, supportedLocales) {
              //   // Add your custom resolution logic
              //   return locale;
              // },
              localizationsDelegates: const [
                // S.delegate,
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // localeResolutionCallback: (locale, supportedLocales) {
              //   return supportedLocales.contains(locale) ? locale : const Locale('en');
              // },
              supportedLocales: const [
                // Locale('en'), // English
                Locale('hi'), // Hindi
              ],
              builder: FToastBuilder(),
              routerConfig: router,
              scaffoldMessengerKey: GlobalKeys.scaffoldMessengerKey,
            ),
          );
        }
      ),
    );
  }
}





