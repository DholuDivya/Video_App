import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/notification_service.dart';
import 'package:vimeo_clone/firebase_options.dart';

import 'Repo/auth_repo.dart';
import 'model/user_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  // await Hive.initFlutter();
  Hive.registerAdapter(UserDataModelAdapter());

  await Hive.openBox('themebox');

  await Global.initialize();


  if(!kIsWeb){
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  }else{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  }


  runApp(const MyApp());

}


