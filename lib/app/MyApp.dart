import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:vimeo_clone/Config/theme_data.dart';
import 'package:vimeo_clone/Repo/auth_repo.dart';
import 'package:vimeo_clone/Repo/video_category_repo.dart';
import 'package:vimeo_clone/bloc/auth/auth_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_event.dart';
import 'package:vimeo_clone/config/ApiBaseHelper.dart';
import 'package:vimeo_clone/routes/myapproute.dart';



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
        // BlocProvider(create: (context) => ThemeBloc(Hive.box('themeBox'))..add(ThemeLoadEvent())),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => AuthBloc(AuthRepository(ApiBaseHelper()))),
        BlocProvider(create: (context) => VideoCategoriesBloc(VideoCategoriesRepo())..add(GetCategoryEvent()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (BuildContext context, themeMode) {
        return ScreenUtilInit(
          child: MaterialApp.router(
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
            scaffoldMessengerKey: scaffoldMessengerKey,
            routerConfig: router,
          ),
        );
        }
      ),
    );
  }
}





