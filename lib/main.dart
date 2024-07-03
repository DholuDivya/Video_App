import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('theme');

  runApp(const MyApp());

}

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

