// import 'dart:async';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class AppLinksDeepLink {
//   AppLinksDeepLink._privateConstructor();
//
//   static final AppLinksDeepLink _instance = AppLinksDeepLink._privateConstructor();
//
//   static AppLinksDeepLink get instance => _instance;
//
//   late AppLinks _appLinks = AppLinks();
//   StreamSubscription<Uri>? _linkSubscription;
//
//
//   Future<void> initDeepLinks() async {
//     print("divya");
//     // Check initial link if app was in cold state (terminated)
//     final appLink = await _appLinks.getInitialLink();
//     if (appLink != null) {
//       var uri = Uri.parse('${appLink.toString()}/videos?testing-3');
//       print('ppppp   $uri');
//     }
//
//     // Handle link when app is in warm state (front or background)
//     _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) {
//       print(' you will listen any url updates ');
//       print('mmmmm   $uriValue');
//     },onError: (err){
//       debugPrint('====>>> error : $err');
//     },onDone: () {
//       _linkSubscription?.cancel();
//     },);
//   }
// }








import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/screens/videoPage/videopage.dart';

import 'config/global_keys.dart';

class AppLinksDeepLink {
  AppLinksDeepLink._privateConstructor();

  static final AppLinksDeepLink _instance = AppLinksDeepLink._privateConstructor();

  static AppLinksDeepLink get instance => _instance;

  late AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks(BuildContext context) async {
    print("Initializing deep links...");

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialLink();
    if (appLink != null) {
      _handleDeepLink(appLink, context);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) {
      print('Received URI: $uriValue');
      _handleDeepLink(uriValue, context);
    }, onError: (err) {
      debugPrint('Error: $err');
    }, onDone: () {
      _linkSubscription?.cancel();
    });
  }

  void _handleDeepLink(Uri uri, BuildContext context) {
    print('Handling deep link: $uri');
    if (uri.host == 'video') {
      final slug = uri.pathSegments.last;
      print('uuuuuuuuuuuu u u u u uu u uu u    $slug');
      if (slug.isNotEmpty) {
        print('Navigating to video page with slug: $slug');
        final navigatorContext = GlobalKeys.navigatorKey.currentContext;

        if (navigatorContext != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                navigatorContext,
                CupertinoPageRoute(builder: (navigatorContext) => VideoPage(slug: slug))
            );
          });
        }
      } else {
        print('Slug is undefined. Cannot navigate to video page.');
      }
    }
  }
}
