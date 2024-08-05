import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'Repo/auth_repo.dart';
import 'model/user_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(UserDataModelAdapter());

  await Hive.openBox('themebox');

  await Global.initialize();


  if(!kIsWeb){
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  }else{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  }






  runApp(MyApp());

}

// class GlobalVariable{
//   static String? token;
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         Locale('en'), // English
//         Locale('hi'), // Hindi
//       ],
//       home: HomePage(),
//       // routerConfig: MyAppRoute().router,
//     );
//   }
// }

