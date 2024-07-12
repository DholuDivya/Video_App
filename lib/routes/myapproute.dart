import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/Screens/NotificationPage/notification_page.dart';
import 'package:vimeo_clone/Screens/SearchScreen/search_screen.dart';
import 'package:vimeo_clone/Screens/SettingPage/setting_page.dart';
import 'package:vimeo_clone/Screens/SplashScreen/splash_screen.dart';
import 'package:vimeo_clone/Screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/Screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/Screens/Auth/signup.dart';
import 'package:vimeo_clone/Screens/VideoPage/videopage.dart';
import 'package:vimeo_clone/screens/auth/forgot_password_page.dart';
import 'package:vimeo_clone/screens/auth/registration_page.dart';
import 'package:vimeo_clone/screens/auth/numebr_signup.dart';
import 'package:vimeo_clone/screens/auth/reset_password.dart';
import 'package:vimeo_clone/screens/auth/verification_page.dart';
import 'package:vimeo_clone/screens/user_page/user_page.dart';
import '../Screens/HomePage/homepage.dart';
import '../screens/channel_profile_page/channel_profile_page.dart';

// class MyAppRoute {
  final GoRouter router = GoRouter(
    // initialLocation: '/SignupPage',
      routes: [
        GoRoute(
          name: 'splashScreen',
          path: '/',
          pageBuilder: (context, state) => const MaterialPage (
            child: SplashScreen(),
          ),
        ),

        GoRoute(
          name: 'signupPage',
          path: '/signupPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: SignupPage(),
          ),
        ),

        GoRoute(
          name: 'emailSignup',
          path: '/emailSignup',
          pageBuilder: (context, state) => const MaterialPage (
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
          pageBuilder: (context, state) => const MaterialPage (
            child: ForgotPasswordPage(),
          ),
        ),

        GoRoute(
          name: 'resetPasswordPage',
          path: '/resetPasswordPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: ResetPasswordPage(),
          ),
        ),

        GoRoute(
          name: 'numberSignup',
          path: '/numberSignup',
          pageBuilder: (context, state) => const MaterialPage (
            child: SignupWithPhoneNumber(),
            // child: SignupScreen(),
          ),
        ),

        GoRoute(
          name: 'homePage',
          path: '/homePage',
          pageBuilder: (context, state) => const MaterialPage (
            child: HomePage(),
          ),
        ),

        GoRoute(
          name: 'libraryPage',
          path: '/libraryPage',
          pageBuilder: (context, state) => MaterialPage (
            child: ShortsPage(),
          ),
        ),

        GoRoute(
          name: 'analyticsPage',
          path: '/analyticsPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: SubscriptionsPage(),
          ),
        ),

        GoRoute(
          name: 'userPage',
          path: '/userPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: UserPage(),
          ),
        ),

        GoRoute(
          name: 'notificationPage',
          path: '/notificationPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: NotificationPage(),
          ),
        ),

        GoRoute(
          name: 'searchPage',
          path: '/searchPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: SearchScreen(),
          ),
        ),

        GoRoute(
          name: 'settingPage',
          path: '/settingPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: SettingPage(),
          ),
        ),

        // GoRoute(
        //   name: 'generalSetting',
        //   path: '/generalSetting',
        //   pageBuilder: (context, state) => const MaterialPage (
        //     child: GeneralSettings(),
        //   ),
        // ),

        GoRoute(
          name: 'channelProfilePage',
          path: '/channelProfilePage',
          pageBuilder: (context, state) => const MaterialPage (
            child: ChannelProfilePage(),
          ),
        ),

        GoRoute(
          name: 'videoPage',
          path: '/videoPage',
          pageBuilder: (context, state) => const MaterialPage (
            child: VideoPage(),
          ),
        ),


      ]
  );
// }
