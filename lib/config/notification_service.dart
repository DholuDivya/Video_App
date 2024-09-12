// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Background Message Title: ${message.notification?.title}');
//   print('Background Message Body: ${message.notification?.body}');
//   print('Background Message Data: ${message.data}');
//   // Optionally show a local notification using flutter_local_notifications
// }
//
// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> initNotification(BuildContext context) async {
//     // Ensure Firebase is initialized
//     await Firebase.initializeApp();
//
//     // Request notification permissions
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // Get the FCM token
//     String? fCMToken = await _firebaseMessaging.getToken();
//     print('FCM Token: $fCMToken');
//
//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground Message Title: ${message.notification?.title}');
//       print('Foreground Message Body: ${message.notification?.body}');
//       print('Foreground Message Data: ${message.data}');
//
//       // Show local notification when the app is in the foreground
//       _showForegroundNotification(message);
//     });
//
//     // Handle when the app is opened from a background state
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message opened app: ${message.notification?.title}');
//       print('Message opened app: ${message.notification?.body}');
//       _handleNavigation(message, context);
//     });
//
//     // Handle token refresh
//     _firebaseMessaging.onTokenRefresh.listen((String newToken) {
//       print('New FCM Token: $newToken');
//       // Update your server with the new token
//     });
//   }
//
//   void _showForegroundNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       notificationDetails,
//     );
//   }
//
//   void _handleNavigation(RemoteMessage message, BuildContext context) {
//     // Handle navigation based on notification data
//     String? route = message.data['notificationPage'];
//
//     if (route != null) {
//       Navigator.of(context).pushNamed(route);
//     }
//   }
// }















import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize Firebase and Notification Services
  Future<void> initFirebaseMessaging(BuildContext context) async {
    await Firebase.initializeApp();

    // Request Notification Permissions
    await _requestNotificationPermissions();

    // Get the FCM token
    String? fCMToken = await getFcmToken();
    print('FCM Token: $fCMToken');

    // Set up background message handling
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    // Set up foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground Message: ${message.notification?.title}');
      print('Foreground Message: ${message.notification?.body}');
      _showForegroundNotification(message, );
    });

    // Handle messages when the app is opened from the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.notification?.title}');
      _handleNavigation(message, context);
    });

    // Listen for FCM token refresh
    _firebaseMessaging.onTokenRefresh.listen((String newToken) {
      print('New FCM Token: $newToken');
      // Update your server with the new token
    });
  }

  // Request Notification Permissions
  Future<void> _requestNotificationPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Get the FCM Token
  Future<String?> getFcmToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Handle background messages
  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Background Message: ${message.notification?.title}, ${message.notification?.body}');
  }

  // Show a notification while the app is in the foreground
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

  // Handle navigation when a notification is opened
  void _handleNavigation(RemoteMessage message, BuildContext context) {
    // String? route = message.data['notificationPage'];
    Navigator.of(context).pushNamed('notificationPage');
    // showCustomNotification(message, context);
  }

  // Show a custom notification when needed
  // void showCustomNotification(RemoteMessage message, BuildContext context) async {
  //   // Display an Alert Dialog for notifications when the app is in the foreground
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(message.notification?.title ?? 'Notification'),
  //         content: Text(message.notification?.body ?? 'You have a new notification'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               // Close the dialog
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Close'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Handle navigation when user taps on the notification
  //               Navigator.of(context).pop();
  //               _handleNavigation(message, context);
  //             },
  //             child: const Text('View'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   // Optionally, still show a system notification
  //   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidDetails,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title,
  //     message.notification?.body,
  //     notificationDetails,
  //   );
  // }


  // Set a specific notification channel for Android
  // Future<void> setupNotificationChannel(String channelId, String channelName) async {
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // name
  //     importance: Importance.high,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  // }
}













