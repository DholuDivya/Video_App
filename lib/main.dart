import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:vimeo_clone/Screens/HomePage/homepage.dart';

void main() {
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

