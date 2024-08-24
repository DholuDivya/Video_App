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
    super.initState();
    getTheme();
    _navigateToNextScreen();
  }

  void getTheme() async {
    final box = await Hive.openBox('themebox');
    mode = box.get('themeMode');
    log('ooooooooooooo    ${mode}');
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
      GoRouter.of(context).pushReplacementNamed('signupPage');  // Make sure this route is correctly defined
    }


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: mode == 1
            ? Image.asset('assets/images/splash_logo_light.png', height: 100.h, width: 100.w,)
            : Image.asset('assets/images/splash_logo_dark.png', height: 100.h, width: 100.w,)
      ),
    );
  }
}

