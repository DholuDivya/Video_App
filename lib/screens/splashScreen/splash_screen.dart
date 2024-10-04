// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:vimeo_clone/Screens/Auth/signup.dart';
// import 'package:vimeo_clone/Screens/HomePage/homepage.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   get splash => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       centered: true,
//       duration: 1000,
//       splash:
//           Center(
//             child: LottieBuilder.asset('assets/animation/demo.json', width: 200, height: 200,),
//           ),
//
//        nextScreen: SignupPage(),
//       splashIconSize: 600,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//     );
//   }
// }



import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:vimeo_clone/bloc/settings_api/settings_api_bloc.dart';
import 'package:vimeo_clone/bloc/settings_api/settings_api_event.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';

import 'package:vimeo_clone/routes/myapproute.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int? mode;


  @override
  void initState() {
    context.read<SettingsApiBloc>().add(SettingsApiRequest());
    super.initState();
    // getTheme();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2), () {});

    print('${Global.userData}');

    String? token;

    if (Global.userData != null && Global.userData!.userToken != null) {
      token = Global.userData!.userToken;
    }

    if (token != null) {

      print('-----------------------------');
      GoRouter.of(context).pushReplacementNamed('homePage');
    } else {
      print('Token: --- NULLLLLLLl');
      GoRouter.of(context).pushReplacementNamed('signupPage');
    }
  }





  @override
  Widget build(BuildContext context) {

    // print('1111   ::::    ${Global.userData!.userProfilePhoto}');
    // print('1111   ::::    ${Global.userData!.userName}');
    // print('1111   ::::    ${Global.userData!.userChannelId}');
    // print('1111   ::::    ${Global.userData!.userNumber}');
    // print('1111   ::::    ${Global.userData!.userToken}');
    // print('1111   ::::    ${Global.userData!.userEmail}');
    // print('1111   ::::    ${Global.userData!.userId}');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (BuildContext context, ThemeMode state) {
          final box = Hive.box('themebox');
          final currentTheme = state;
          return Center(
              child: currentTheme == ThemeMode.light
                  ? Image.asset('assets/images/splash_logo_light.png', height: 100.h, width: 100.w,)
                  : Image.asset('assets/images/splash_logo_dark.png', height: 100.h, width: 100.w,)
          );
        },
      ),
    );
  }
}

