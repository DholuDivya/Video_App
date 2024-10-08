import 'dart:async';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../routes/myapproute.dart';

class VerificationPage extends StatefulWidget {
  final String verificationId;
  // final String name;
  const VerificationPage({super.key, required this.verificationId});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  late String _code;
  bool _onEditing = true;
  int _resendCodeTime = 120;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCodeTime == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _resendCodeTime--;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      _resendCodeTime = 120;
    });
    _startResendTimer();
    // Add your code to resend the OTP here
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Future<void> verifyCode() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   String smsCode = _code.trim();
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: widget.verificationId,
  //     smsCode: smsCode,
  //   );
  //
  //   try {
  //     await auth.signInWithCredential(credential);
  //     // Handle successful sign-in
  //     GoRouter.of(context).pushReplacementNamed('homePage');
  //
  //   } catch (e) {
  //     // Handle error, such as incorrect code
  //     print(e.toString());
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            Text(
              AppLocalizations.of(context)!.otpVerification,
              style: TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),

            Text('${AppLocalizations.of(context)!.weHaveSendAnOtpOnGivenNumber} \n ${AppLocalizations.of(context)!.number} +91-98****4571',
              style: TextStyle(
                fontFamily: fontFamily
              ),
            ),
            SizedBox(height: 40,),

            BlocConsumer<AuthBloc, AuthState>(
              listener: (BuildContext context, state) {
                if(state is AuthSuccess){
                  log('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${Global.userData}');
                  // log('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${Global.userName}');
                  // GoRouter.of(context).pushReplacementNamed('homePage');
                  router.goNamed('homePage');
                }else if(state is AuthFailure){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP')));
                }
              },
              builder: (BuildContext context, state) {
                if (state is AuthProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return VerificationCode(
                  // isSecure: true,
                  itemSize: 40.h,
                  // autofocus: true,
                  fullBorder: true,
                  // digitsOnly: true,
                  keyboardType: TextInputType.number,
                  underlineColor: primaryColor,
                  length: 6,
                  cursorColor: primaryColor,
                  textStyle: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15
                  ),

                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                      context.read<AuthBloc>().add(VerifySentOtp(otpCode: _code, verificationId: widget.verificationId));
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                );
              }
            ),


            // SizedBox(height: 20.h),
            Container(
              height: 50.h,
              width: double.maxFinite,
              child: Center(
                child: _resendCodeTime == 0
                    ? TextButton(
                  onPressed: _resendCode,
                  child: Text(
                    AppLocalizations.of(context)!.resendCode,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15.sp,
                      color: primaryColor,
                    ),
                  ),
                )
                    : Text(
                  '${AppLocalizations.of(context)!.resendCodeIn} ${_resendCodeTime ~/ 60}:${(_resendCodeTime % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 15.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
