import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:vimeo_clone/config/global_keys.dart';
import 'package:vimeo_clone/routes/myapproute.dart';
import 'package:vimeo_clone/screens/notificationPage/notification_page.dart';

class NotificationService {
  late BuildContext? context;
  NotificationService({this.context}) ;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    Future<void> initFirebaseMessaging(BuildContext context) async {
      await Firebase.initializeApp();

      await _requestNotificationPermissions();

      String? fCMToken = await getFcmToken();
      print('FCM Token: $fCMToken');

      FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Foreground Message: ${message.notification?.title}');
        print('Foreground Message: ${message.notification?.body}');

        _showForegroundNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message opened app: ${message.notification?.title}');
        _handleNavigation(message);
      });

      _firebaseMessaging.onTokenRefresh.listen((String newToken) {
        print('New FCM Token: $newToken');
      });
    }

    Future<void> _requestNotificationPermissions() async {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    Future<String?> getFcmToken() async {
      return await _firebaseMessaging.getToken();
    }

    Future<void> _firebaseBackgroundHandler(
        RemoteMessage message) async {
      await Firebase.initializeApp();
      print('Background Message: ${message.notification?.title}, ${message
          .notification?.body}');

    }

    void _showForegroundNotification(RemoteMessage message) async {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
      );
    }


  void _handleNavigation(RemoteMessage message) {
    // Extract videoSlug from message data
    print('MESSAGE ::::::::::::       ${message.data['extra_data']}');
    // final videoSlug = message.data['extra_data'];

    final videoSlug = 'sajan';
    // Get the current navigator context using GlobalKeys.navigatorKey
    final navigatorContext = GlobalKeys.navigatorKey.currentContext;

    // Check if the context is available
    if (navigatorContext != null) {
      // Use WidgetsBinding to ensure we are navigating at the right time
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigate to the notification page using GoRouter
        navigatorContext.pushNamed('notificationPage');
        // GoRouter.of(navigatorContext).pushNamed(
        //   'videoPage',
        //   pathParameters: {
        //     'slug': videoSlug,  // Pass videoSlug if needed
        //   },
        // );
      });
    }
  }




    // void _handleNavigation(BuildContext context, RemoteMessage message) {
    //   // final router = GoRouter.of(context);
    //   // router.goNamed('notificationPage');
    //   print('MESSSSAAGEE ::::::::::::       ${message.data['extra_data']}');
    //   final videoSlug = message.data['extra_data'];
    //   router.pushNamed('notificationPage');
    //   final context = GlobalKeys.navigatorKey.currentContext;
    //   if (context != null) {
    //
    //   }
    // }
}


