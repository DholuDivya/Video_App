import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Screens/HomePage/homepage.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../config/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isChecked = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[gmail]+\.[a-zA-Z]{2,}$';
  bool isPasswordVisible = false;


  Future<UserCredential> loginWithApple() async {
    final appleProvider = AppleAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }


  String? _validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Please enter Email !";
    }
    RegExp regexp = RegExp(emailRegex);
    if(!regexp.hasMatch(value)){
      return 'Email is not Valid';
    }
    return null;
  }


  String? _validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Please enter First Name !";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    RegExp regexp = RegExp(pattern);
    if(!regexp.hasMatch(value)){
      return 'Password must be at least 8 characters long, include an uppercase letter, number, and symbol';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            top: 650,
            right: 5,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              elevation: 10,
                // shadowColor: Colors.white12,
              child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade900,
                    color: Colors.blue.shade100,
                    borderRadius:
                    BorderRadius.circular(500),
                  )
              ),
            ),
          ),


          Positioned(
            top: 270.h,
            left: 190.w,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              elevation: 10,
                // shadowColor: Colors.white12,
              child: Container(
                  height: 140.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade900,
                    color: Colors.blue.shade100,
                    borderRadius:
                    BorderRadius.circular(500),
                  )
              ),
            ),
          ),
          Positioned(
            top: 500.h,
            left: 0,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              elevation: 10,
                // shadowColor: Colors.white12,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    // color: Colors.grey.shade900,
                  color: Colors.blue.shade100,
                    borderRadius:
                    BorderRadius.circular(500),
                )
              ),
            ),
          ),
          Positioned(
            top: 90.h,
           right: - 5,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              elevation: 10,
                shadowColor: Colors.white12,
              child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade900,
                    color: Colors.blue.shade100,
                    borderRadius:
                    BorderRadius.circular(500),
                  )
              ),
            ),
          ),
          Positioned(
            top: -15.w,
            left: -20,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              elevation: 10,
              shadowColor: Colors.white12,
              child: Container(
                height: 160.h,
                width: 180.w,
                decoration: BoxDecoration(
                    // color: Colors.grey.shade900,
                    color: Colors.blue.shade100,
                    borderRadius:
                    BorderRadius.circular(500)
                ),
              ),
            ),
          ),
          Container(
            // color: red,
            height: double.infinity,
            width: double.infinity,
          ),






          // Main content with glassmorphism
          Padding(
            padding: EdgeInsets.only(
                left: ScreenSize.screenWidth(context) * 0.05,
                right: ScreenSize.screenWidth(context) * 0.05
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 130.h),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Sign-in with account',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).pushNamed('emailSignup');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 14.sp,
                                        // color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      ' Register',
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                          fontSize: 14.sp,
                                          color: blue
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),

                            CustomTextField(
                              obscureText: false,
                              controller: _emailController,
                              validator: _validateEmail,
                              label: 'Email',
                            ),
                            
                            SizedBox(height: 16),
                            CustomTextField(
                              obscureText: true && !isPasswordVisible,
                              controller: _passwordController,
                              validator: _validatePassword,
                              label: 'Password',
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                      isPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash
                                  )
                              ),
                            ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                'forgotPasswordPage');
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 11,
                                color: Colors.black54
                            ),
                          ),
                        ),
                      ),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (BuildContext context, state) {
                                 if(state is AuthSuccess) {
                                  print('Login Success');
                                  GoRouter.of(context).pushReplacementNamed('homePage');
                                }else if(state is AuthFailure){
                                  print('Login Fail');
                                }

                                return ElevatedButton(
                                  onPressed: () {
                                    // SignInUser();
                                    final String email = _emailController.text;
                                    final String password = _passwordController.text;
                                    context.read<AuthBloc>().add(OnUserLoginRequestEvent(email: email, password: password));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: fontFamily,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                            SizedBox(height: 16),

                            SizedBox(height: 24),
                            Center(
                              child: Row(
                                children: [
                                  Expanded(child: Divider(thickness: 0.5,)),
                                  SizedBox(width: 5,),
                                  Text(
                                    'or sign up with',
                                    style: TextStyle(
                                        fontSize: 14,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(child: Divider(thickness: 0.5,)),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocConsumer<AuthBloc, AuthState>(
                                  listener: (BuildContext context, state) {
                                    if(state is AuthSuccess){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Login Successful')),
                                      );
                                      GoRouter.of(context).pushReplacementNamed('homePage');
                                    } else if (state is AuthFailure) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Login Failed')),
                                      );
                                    }
                                  },

                                  builder: (BuildContext context, Object? state) {
                                    if(state is AuthProgress){
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    return Container(
                                      height: 42.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                              color: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              width: 0.5
                                          )
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // await loginWithGoogle();
                                          BlocProvider.of<AuthBloc>(context).add(LoginWithGoogleSubmitted());
                                        },
                                        child: Image.asset(
                                          'assets/images/google_logo.png',
                                          // height: 10,
                                          // width: 10,
                                        ),
                                      ),
                                    );
                                  }
                                ),

                                SizedBox(width: 16),
                                Container(
                                  height: 42.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Theme.of(context).colorScheme.tertiary,
                                          width: 0.5
                                      )
                                  ),
                                  child: IconButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ))
                                    ),
                                    icon:  const Icon(Remix.apple_fill),
                                    iconSize: 30,
                                    onPressed: () {
                                      loginWithApple();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  height: 42.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Theme.of(context).colorScheme.tertiary,
                                          width: 0.5
                                      )
                                  ),
                                  child: IconButton(
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ))
                                    ),
                                    icon:  const Icon(Remix.phone_fill, color: Colors.blue,),
                                    iconSize: 30,
                                    onPressed: () {
                                      GoRouter.of(context).pushNamed('numberSignup');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50.h),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'By clicking Create account you agree to our Terms of use and Privacy policy',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    fontSize: 12,
                                    // color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          // Skip button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, right: 20.w),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkOpacityColor,
                  ),
                  height: 30.h,
                  width: 55.w,
                  child: TextButton(
                      onPressed: (){
                        GoRouter.of(context).pushReplacementNamed('homePage');
                      },
                      child: Text(
                        'skip',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.tertiary
                        ),
                      )
                  )
              ),
            ),
          ),

        ],
      ),
    );
  }
}
