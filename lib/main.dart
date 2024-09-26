// import 'package:app_links/app_links.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:vimeo_clone/App/MyApp.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vimeo_clone/config/ApiBaseHelper.dart';
// import 'package:vimeo_clone/config/api_routes.dart';
// import 'package:vimeo_clone/config/global_variable.dart';
// import 'package:vimeo_clone/config/notification_service.dart';
// import 'package:vimeo_clone/firebase_options.dart';
//
// import 'Repo/auth_repo.dart';
// import 'model/user_data_model.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//
//
//   final appDocumentDirectory = await getApplicationDocumentsDirectory();
//   await Hive.initFlutter(appDocumentDirectory.path);
//   // await Hive.initFlutter();
//   Hive.registerAdapter(UserDataModelAdapter());
//
//   await Hive.openBox('themebox');
//
//   await Global.initialize();
//
//
//   if(!kIsWeb){
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   }else{
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
//   }
//
//
//   runApp(const MyApp());
//
// }
//
//










import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/firebase_options.dart';
import 'package:vimeo_clone/model/hive_model/downloaded_video_model/downloaded_video_model.dart';

import 'model/hive_model/user_data_model/user_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  var devices = ["72F1F8AC829C59E59B0462B951137364"];

  RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: ['72F1F8AC829C59E59B0462B951137364']);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  Hive.registerAdapter(UserDataModelAdapter());
  Hive.registerAdapter(DownloadedVideoModelAdapter());

  await Hive.openBox('themebox');

  await Global.initialize();

  if (!kIsWeb) {

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  }


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,);

  runApp(const MyApp());
}

