import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/Screens/NotificationPage/notification_page.dart';
import 'package:vimeo_clone/Screens/SearchScreen/search_screen.dart';
import 'package:vimeo_clone/Screens/SettingPage/setting_page.dart';
import 'package:vimeo_clone/Screens/SplashScreen/splash_screen.dart';
import 'package:vimeo_clone/Screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/Screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/Screens/Auth/signup.dart';
import 'package:vimeo_clone/Screens/VideoPage/videopage.dart';
import 'package:vimeo_clone/config/global_keys.dart';
import 'package:vimeo_clone/screens/app_privacy_content_pages/about_us_page.dart';
import 'package:vimeo_clone/screens/app_privacy_content_pages/privacy_policy_page.dart';
import 'package:vimeo_clone/screens/app_privacy_content_pages/terms_and_condition_page.dart';
import 'package:vimeo_clone/screens/auth/forgot_password_page.dart';
import 'package:vimeo_clone/screens/auth/registration_page.dart';
import 'package:vimeo_clone/screens/auth/number_signup.dart';
import 'package:vimeo_clone/screens/auth/reset_password.dart';
import 'package:vimeo_clone/screens/auth/verification_page.dart';
import 'package:vimeo_clone/screens/download_video/play_downloaded_video_page.dart';
import 'package:vimeo_clone/screens/edit_channel_page/edit_channel_page.dart';
import 'package:vimeo_clone/screens/help_and_support/help_and_support_page.dart';
import 'package:vimeo_clone/screens/history_page/all_history_page.dart';
import 'package:vimeo_clone/screens/plans_page/plans_page.dart';
import 'package:vimeo_clone/screens/searchScreen/search_data_page.dart';
import 'package:vimeo_clone/screens/transactions_page/transactions_page.dart';
import 'package:vimeo_clone/screens/upload_shorts/crop_shorts_page.dart';
import 'package:vimeo_clone/screens/upload_shorts/get_shorts_thumbnail_page.dart';
import 'package:vimeo_clone/screens/upload_shorts/upload_shorts_page.dart';
import 'package:vimeo_clone/screens/upload_video/upload_video_page.dart';
import 'package:vimeo_clone/screens/upload_video_from_url/upload_video_from_url_page.dart';
import 'package:vimeo_clone/screens/user_page/user_page.dart';
import 'package:vimeo_clone/screens/user_playlist_page/single_playlist_page.dart';
import 'package:vimeo_clone/screens/user_playlist_page/user_playlist_page.dart';
import 'package:vimeo_clone/screens/your_videos/your_video_page.dart';
import '../Screens/HomePage/homepage.dart';
import '../model/hive_model/downloaded_video_model/downloaded_video_model.dart';
import '../screens/channel_profile_page/channel_profile_page.dart';
import '../screens/download_video/download_video_page.dart';
import '../screens/edit_video_detail/edit_video_detail_page.dart';

final navigatorContext = GlobalKeys.navigatorKey.currentContext;

// class MyAppRoute {
  final GoRouter router = GoRouter(
    // initialLocation: '/cropShortsPage',
      navigatorKey: GlobalKeys.navigatorKey,
      routes: [
        GoRoute(
          name: 'splashScreen',
          path: '/',
          pageBuilder: (context, state) => const CupertinoPage (
            child: SplashScreen(),
          ),
        ),

        GoRoute(
          name: 'signupPage',
          path: '/signupPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: SignupPage(),
          ),
        ),

        GoRoute(
          name: 'emailSignup',
          path: '/emailSignup',
          pageBuilder: (context, state) => const CupertinoPage (
            child: RegistrationPage(),
          ),
        ),

        GoRoute(
          name: 'verificationPage',
          path: '/verificationPage/:verificationId',
          builder: (context, state) {
            final verificationId = state.pathParameters['verificationId']!;
            return VerificationPage(verificationId: verificationId);
          },
        ),

        GoRoute(
          name: 'forgotPasswordPage',
          path: '/forgotPasswordPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: ForgotPasswordPage(),
          ),
        ),

        GoRoute(
          name: 'resetPasswordPage',
          path: '/resetPasswordPage/:email',
          builder: (context, state) => ResetPasswordPage(
              email: state.pathParameters['email']!
          ),
        ),

        GoRoute(
          name: 'numberSignup',
          path: '/numberSignup',
          pageBuilder: (context, state) => const CupertinoPage (
            child: SignupWithPhoneNumber(),
            // child: SignupScreen(),
          ),
        ),

        GoRoute(
          name: 'homePage',
          path: '/homePage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: HomePage(),
          ),
        ),

        GoRoute(
          name: 'libraryPage',
          path: '/libraryPage',
          pageBuilder: (context, state) => CupertinoPage (
            child: ShortsPage(),
          ),
        ),

        GoRoute(
          name: 'analyticsPage',
          path: '/analyticsPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: SubscriptionsPage(),
          ),
        ),

        GoRoute(
          name: 'userPage',
          path: '/userPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: UserPage(),
          ),
        ),

        GoRoute(
          name: 'notificationPage',
          path: '/notificationPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: NotificationPage(),
          ),
        ),

        GoRoute(
          name: 'searchSuggestionPage',
          path: '/searchSuggestionPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: SearchScreen(),
          ),
        ),

        GoRoute(
          name: 'searchDataPage',
          path: '/searchDataPage/:searchQuery',
          builder: (context, state) => SearchDataPage(
              searchQuery: state.pathParameters['searchQuery']!
          ),
        ),

        GoRoute(
          name: 'settingPage',
          path: '/settingPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: SettingPage(),
          ),
        ),

        GoRoute(
          name: 'channelProfilePage',
          path: '/channelProfilePage/:channelId',
          builder: (context, state) => ChannelProfilePage(
              channelId: state.pathParameters['channelId']!
          ),
        ),

        // GoRoute(
        //   name: 'videoPage',
        //   path: '/videoPage',
        //   pageBuilder: (context, state) => const MaterialPage (
        //     child: VideoPage(),
        //   ),
        // ),
        GoRoute(
          name: 'videoPage',
          path: '/videoPage/:slug',  // 👈 Defination of params in the path is important
          builder: (context, state) => VideoPage(
              slug: state.pathParameters['slug']!
          ),
        ),

        GoRoute(
          name: 'uploadVideoPage',
          path: '/uploadVideoPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: UploadVideoPage(),
          ),
        ),


        GoRoute(
          name: 'uploadVideoFromUrl',
          path: '/uploadVideoFromUrl',
          pageBuilder: (context, state) => const CupertinoPage (
            child: UploadVideoFromUrlPage(),
          ),
        ),

        GoRoute(
          name: 'yourVideoPage',
          path: '/yourVideoPage',
          builder: (context, state) => YourVideoPage()
        ),

        GoRoute(
          name: 'getShortsThumbnailPage',
          path: '/getShortsThumbnailPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: GetShortsThumbnailPage(),
          ),
        ),

        GoRoute(
          name: 'uploadShortsPage',
          path: '/uploadShortsPage',
          builder: (context, state) {
            // Expect the File to be passed as an extra argument
            final file = state.extra as CroppedFile;
            return UploadShortsPage(
              thumbnail: file,
            );
          },
        ),

        // GoRoute(
        //   name: 'cropShortsPage',
        //     path: '/cropShortsPage',
        //   pageBuilder: (context, state) => const CupertinoPage(child: CropShortsPage())
        // ),

        GoRoute(
          name: 'allHistoryPage',
          path: '/allHistoryPage',
          pageBuilder: (context, state) => const CupertinoPage(child: AllHistoryPage())
        ),

        GoRoute(
            name: 'userPlaylistPage',
            path: '/userPlaylistPage',
            pageBuilder: (context, state) => const CupertinoPage(child: UserPlaylistPage())
        ),

        GoRoute(
            name: 'singlePlaylistPage',
            path: '/singlePlaylistPage/:playlistId',
            builder: (context, state) => SinglePlaylistPage(
                playlistId: int.parse(state.pathParameters['playlistId']!),
          ),
        ),

        GoRoute(
          name: 'editChannelPage',
          path: '/editChannelPage',
          pageBuilder: (context, state) => const CupertinoPage(child: EditChannelPage())
        ),

        GoRoute(
            name: 'plansPage',
            path: '/plansPage',
            pageBuilder: (context, state) => const CupertinoPage(child: PlansPage())
        ),

        GoRoute(
            name: 'editVideoDetailPage',
            path: '/editVideoDetailPage/:slug',
          builder: (context, state) => EditVideoDetailPage(
              videoSlug: state.pathParameters['slug']!
          ),
        ),


        GoRoute(
          name: 'downloadedVideoPage',
          path: '/downloadedVideoPage',
            pageBuilder: (context, state) => const CupertinoPage(child: DownloadedVideosPage())
        ),

        GoRoute(
            name: 'playDownloadedVideo',
            path: '/playDownloadedVideo',
            builder: (context, state) {
            // Extract the DownloadedVideoModel from the state.extra
              final downloadedVideo = state.extra as DownloadedVideoModel;
              return PlayDownloadedVideoPage(downloadedVideo: downloadedVideo);
          },
        ),


        GoRoute(
            name: 'aboutUsPage',
            path: '/aboutUsPage',
            pageBuilder: (context, state) => const CupertinoPage(child: AboutUsPage())
        ),

        GoRoute(
            name: 'termsAndConditionsPage',
            path: '/termsAndConditionsPage',
            pageBuilder: (context, state) => const CupertinoPage(child: TermsAndConditionPage())
        ),

        GoRoute(
            name: 'privacyPolicyPage',
            path: '/privacyPolicyPage',
            pageBuilder: (context, state) => const CupertinoPage(child: PrivacyPolicyPage())
        ),

        GoRoute(
            name: 'helpAndSupportPage',
            path: '/helpAndSupportPage',
            pageBuilder: (context, state) => const CupertinoPage(child: HelpAndSupportPage())
        ),

        GoRoute(
          name: 'transactionsPage',
          path: '/transactionsPage',
          pageBuilder: (context, state) => const CupertinoPage (
            child: TransactionsPage(),
          ),
        ),


      ]
  );
// }













//
//
// class AppRoutes {
//   static final GoRouter router = GoRouter(
//     navigatorKey: GlobalKeys.navigatorKey,
//     routes: [
//       GoRoute(
//         name: 'splashScreen',
//         path: '/',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: SplashScreen(),
//         ),
//       ),
//       GoRoute(
//         name: 'signupPage',
//         path: '/signupPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: SignupPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'emailSignup',
//         path: '/emailSignup',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: RegistrationPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'verificationPage',
//         path: '/verificationPage/:verificationId',
//         builder: (context, state) {
//           final verificationId = state.pathParameters['verificationId']!;
//           return VerificationPage(verificationId: verificationId);
//         },
//       ),
//       GoRoute(
//         name: 'forgotPasswordPage',
//         path: '/forgotPasswordPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: ForgotPasswordPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'resetPasswordPage',
//         path: '/resetPasswordPage/:email',
//         builder: (context, state) => ResetPasswordPage(
//           email: state.pathParameters['email']!,
//         ),
//       ),
//       GoRoute(
//         name: 'numberSignup',
//         path: '/numberSignup',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: SignupWithPhoneNumber(),
//         ),
//       ),
//       GoRoute(
//         name: 'homePage',
//         path: '/homePage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: HomePage(),
//         ),
//       ),
//       GoRoute(
//         name: 'libraryPage',
//         path: '/libraryPage',
//         pageBuilder: (context, state) => CupertinoPage(
//           child: ShortsPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'analyticsPage',
//         path: '/analyticsPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: SubscriptionsPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'userPage',
//         path: '/userPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: UserPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'notificationPage',
//         path: '/notificationPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: NotificationPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'searchSuggestionPage',
//         path: '/searchSuggestionPage',
//         pageBuilder: (context, state) => const MaterialPage(
//           child: SearchScreen(),
//         ),
//       ),
//       GoRoute(
//         name: 'searchDataPage',
//         path: '/searchDataPage/:searchQuery',
//         builder: (context, state) => SearchDataPage(
//           searchQuery: state.pathParameters['searchQuery']!,
//         ),
//       ),
//       GoRoute(
//         name: 'settingPage',
//         path: '/settingPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: SettingPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'channelProfilePage',
//         path: '/channelProfilePage/:channelId',
//         builder: (context, state) => ChannelProfilePage(
//           channelId: state.pathParameters['channelId']!,
//         ),
//       ),
//       GoRoute(
//         name: 'videoPage',
//         path: '/videoPage/:slug',
//         builder: (context, state) => VideoPage(
//           slug: state.pathParameters['slug']!,
//         ),
//       ),
//       GoRoute(
//         name: 'uploadVideoPage',
//         path: '/uploadVideoPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: UploadVideoPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'uploadVideoFromUrl',
//         path: '/uploadVideoFromUrl',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: UploadVideoFromUrlPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'yourVideoPage',
//         path: '/yourVideoPage',
//         builder: (context, state) => YourVideoPage(),
//       ),
//       GoRoute(
//         name: 'getShortsThumbnailPage',
//         path: '/getShortsThumbnailPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: GetShortsThumbnailPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'uploadShortsPage',
//         path: '/uploadShortsPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: UploadShortsPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'cropShortsPage',
//         path: '/cropShortsPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: CropShortsPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'allHistoryPage',
//         path: '/allHistoryPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: AllHistoryPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'userPlaylistPage',
//         path: '/userPlaylistPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: UserPlaylistPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'singlePlaylistPage',
//         path: '/singlePlaylistPage/:playlistId',
//         builder: (context, state) => SinglePlaylistPage(
//           playlistId: int.parse(state.pathParameters['playlistId']!),
//         ),
//       ),
//       GoRoute(
//         name: 'editChannelPage',
//         path: '/editChannelPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: EditChannelPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'plansPage',
//         path: '/plansPage',
//         pageBuilder: (context, state) => const CupertinoPage(
//           child: PlansPage(),
//         ),
//       ),
//       GoRoute(
//         name: 'editVideoDetailPage',
//         path: '/editVideoDetailPage/:slug',
//         builder: (context, state) => EditVideoDetailPage(
//           videoSlug: state.pathParameters['slug']!,
//         ),
//       ),
//     ],
//   );
// }