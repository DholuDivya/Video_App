// import 'package:firebase_messaging/firebase_messaging.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Title: ${message.notification?.body}');
//   print('Title: ${message.data}');
// }
//
// class NotificationService{
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('Token: $fCMToken');
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }
// }












import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background Message Title: ${message.notification?.title}');
  print('Background Message Body: ${message.notification?.body}');
  print('Background Message Data: ${message.data}');
  // Optionally show a local notification using flutter_local_notifications
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification(BuildContext context) async {
    // Ensure Firebase is initialized
    await Firebase.initializeApp();

    // Request notification permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get the FCM token
    String? fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground Message Title: ${message.notification?.title}');
      print('Foreground Message Body: ${message.notification?.body}');
      print('Foreground Message Data: ${message.data}');

      // Show local notification when the app is in the foreground
      _showForegroundNotification(message);
    });

    // Handle when the app is opened from a background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.notification?.title}');
      print('Message opened app: ${message.notification?.body}');
      _handleNavigation(message, context);
    });

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh.listen((String newToken) {
      print('New FCM Token: $newToken');
      // Update your server with the new token
    });
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

  void _handleNavigation(RemoteMessage message, BuildContext context) {
    // Handle navigation based on notification data
    String? route = message.data['notificationPage'];

    if (route != null) {
      Navigator.of(context).pushNamed(route);
    }
  }
}











// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// // Background message handler
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Background Message Title: ${message.notification?.title}');
//   print('Background Message Body: ${message.notification?.body}');
//   print('Background Message Data: ${message.data}');
// }
//
// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initNotification() async {
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
//       // Display a local notification or update the UI
//       // Use flutter_local_notifications plugin to show notifications
//     });
//
//     // Handle when the app is opened from a background state
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message opened app: ${message.notification?.title}');
//       print('Message opened app: ${message.notification?.body}');
//
//       // Navigate to specific screen based on notification data
//       // Use Navigator to handle navigation
//     });
//
//     // Handle token refresh
//     _firebaseMessaging.onTokenRefresh.listen((String newToken) {
//       print('New FCM Token: $newToken');
//       // Update your server with the new token
//     });
//   }
// }
