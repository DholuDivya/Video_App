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



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';

import 'package:vimeo_clone/routes/myapproute.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2), () {});

    print('${Global.token}');
    print('${Global.userName}');
    print('${Global.userEmail}');
    print('${Global.userNumber}');

    if(Global.token == null){
      print('Token: --- NULLLLLLLl');
        // GoRouter.of(context).pushReplacementNamed('signupPage');
      router.go('/signupPage');
    }else{
      print('-----------------------------');
      GoRouter.of(context).pushReplacementNamed('homePage');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: LottieBuilder.asset(
          'assets/animation/demo.json',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

