import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_auth.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../config/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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
            top: 510.h,
            right: -10.w,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              // elevation: 10,
              //   shadowColor: Colors.grey,
              child: Container(
                  height: 100.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade900,
                    color: Colors.blue.shade100,
                    borderRadius:
                    BorderRadius.circular(500),
                  )
              ),
            ),
          ),


          // MIDDLE
          // Positioned(
          //   top: 270.h,
          //   left: 190.w,
          //   child: Material(
          //     borderRadius: BorderRadius.circular(500),
          //     // elevation: 10,
          //     //   shadowColor: Colors.grey,
          //     child: Container(
          //         height: 140.h,
          //         width: 160.w,
          //         decoration: BoxDecoration(
          //           // color: Colors.grey.shade900,
          //           color: Colors.blue.shade100,
          //           borderRadius:
          //           BorderRadius.circular(500),
          //         )
          //     ),
          //   ),
          // ),



          Positioned(
            top: 400.h,
            left: -30.w,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              // elevation: 10,
              //   shadowColor: Colors.grey,
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
            top: 150.h,
           right: -55.w,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              // elevation: 10,
              //   shadowColor: Colors.grey,
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
            top: -50.h,
            left: -50.w,
            child: Material(
              borderRadius: BorderRadius.circular(500),
              // elevation: 10,
              // shadowColor: Colors.grey,
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
              physics: const NeverScrollableScrollPhysics(),
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
                          color: Colors.black.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Sign-in with account',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
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
                                          color: Theme.of(context).colorScheme.primaryFixedDim
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
                                        isPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash,
                                      color: greyShade600,
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
                                  color: greyShade600
                              ),
                            ),
                          ),
                                                ),
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (BuildContext context, state) {
                                   if(state is LoginAuthSuccess) {
                                    ToastManager().showToast(
                                        context: context,
                                        message: 'Login successfully'
                                    );
                                    Future.delayed(const Duration(seconds: 1),(){
                                      GoRouter.of(context).pushReplacementNamed('homePage');
                                      // router.goNamed('homePage');
                                    });

                                  }else if(state is LoginAuthFailure){
                                     ToastManager().showToast(
                                         context: context,
                                         message: 'Login failed'
                                     );
                                  }else if(state is LoginAuthLoading){
                                     return const Center(child: CircularProgressIndicator());
                                   }

                                  return ElevatedButton(
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()){
                                        final String email = _emailController.text;
                                        final String password = _passwordController.text;
                                        context.read<AuthBloc>().add(OnUserLoginRequestEvent(email: email, password: password));
                                      }
                                      else{
                                        print('Form is invalid');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: fontFamily,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                              SizedBox(height: 20.h),

                              // const SizedBox(height: 24),
                              Center(
                                child: Row(
                                  children: [
                                    Expanded(child: Divider(thickness: 0.5.r, color: Theme.of(context).colorScheme.secondaryFixedDim,)),
                                    SizedBox(width: 20.w,),
                                    Text(
                                      'or',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                        fontFamily: fontFamily,
                                        color: Theme.of(context).colorScheme.primaryFixedDim
                                      ),
                                    ),
                                    SizedBox(width: 20.w,),
                                    Expanded(child: Divider(thickness: 0.5.r, color: Theme.of(context).colorScheme.secondaryFixedDim,)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocConsumer<AuthBloc, AuthState>(
                                    listener: (BuildContext context, state) {
                                      if(state is AuthSuccess){
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Login successfully'
                                        );
                                        Future.delayed(const Duration(seconds: 1),(){
                                          GoRouter.of(context).pushReplacementNamed('homePage');
                                          // router.goNamed('homePage');
                                        });
                                      } else if (state is AuthFailure) {
                                        ToastManager().showToast(
                                            context: context,
                                            message: 'Login failed'
                                        );
                                      }
                                    },

                                    builder: (BuildContext context, Object? state) {
                                      if(state is AuthProgress){
                                        return const Center(child: CircularProgressIndicator(),);
                                      }
                                      return Container(
                                        height: 42.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            border: Border.all(
                                                color: greyShade400,
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

                                  const SizedBox(width: 16),
                                  Container(
                                    height: 42.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Theme.of(context).colorScheme.tertiary,
                                            width: 0.5.r
                                        )
                                    ),
                                    child: IconButton(
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                        ))
                                      ),
                                      icon: Icon(Remix.apple_fill, color: greyShade800,),
                                      iconSize: 28,
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
                                            width: 0.5.r
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
                              SizedBox(height: 25.h),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'By clicking Create account you agree to our ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: fontFamily,
                                        color: Theme.of(context).colorScheme.primaryFixedDim,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Terms of use',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: fontFamily,
                                            color: blue,
                                            decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // Navigate to Terms of Use screen
                                              GoRouter.of(context).pushNamed('termsAndConditionsPage');
                                            },
                                        ),
                                        TextSpan(
                                          text: ' and ',
                                        ),
                                        TextSpan(
                                          text: 'Privacy policy',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: fontFamily,
                                            color: blue, // Make this a link color
                                            decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // Navigate to Privacy Policy screen
                                              GoRouter.of(context).pushNamed('privacyPolicyPage');
                                            },
                                        ),
                                        TextSpan(
                                          text: '.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
