import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/Config/theme_data.dart';
import 'package:vimeo_clone/Screens/Auth/signup.dart';
import 'package:vimeo_clone/Screens/SplashScreen/splash_screen.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';

import '../Routes/myapproute.dart';
import '../Screens/HomePage/homepage.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc(Hive.box('theme'))..add(ThemeLoadEvent())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (BuildContext context, themeMode) {
        return MaterialApp.router(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('hi'), // Hindi
          ],
          // home: const SplashScreen(),
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: MyAppRoute().router,
        );
        }
      ),
    );
  }
}





