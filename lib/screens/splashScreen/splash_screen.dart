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
import 'package:lottie/lottie.dart';
import 'package:vimeo_clone/Screens/Auth/signup.dart';

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
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => const SignupPage()),
    // );
    GoRouter.of(context).pushReplacementNamed('signupPage');
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
