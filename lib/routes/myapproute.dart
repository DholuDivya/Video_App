import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/Screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/Screens/Auth/emailSignup.dart';
import 'package:vimeo_clone/Screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/Screens/Auth/signup.dart';
import 'package:vimeo_clone/Screens/watch.dart';

import '../Screens/HomePage/homepage.dart';

class MyAppRoute {
  final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: 'signupPage',
          path: '/',
          pageBuilder: (context, state) => const MaterialPage (
            child: SignupPage(),
          ),
        ),

        GoRoute(
          name: 'signupWithEmailPage',
          path: '/emailSignUp',
          pageBuilder: (context, state) => const MaterialPage (
            child: SignupWithEmail(),
          ),
        ),

        GoRoute(
          name: 'homePage',
          path: '/home',
          pageBuilder: (context, state) => const MaterialPage (
            child: HomePage(),
          ),
        ),

        GoRoute(
          name: 'libraryPage',
          path: '/library',
          pageBuilder: (context, state) => const MaterialPage (
            child: ShortsPage(),
          ),
        ),

        GoRoute(
          name: 'analyticsPage',
          path: '/analytics',
          pageBuilder: (context, state) => const MaterialPage (
            child: SubscriptionsPage(),
          ),
        ),

        GoRoute(
          name: 'watchPage',
          path: '/watch',
          pageBuilder: (context, state) => const MaterialPage (
            child: WatchPage(),
          ),
        ),
      ]
  );
}