import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';

import '../../config/colors.dart';
import '../../config/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? _code;
  bool _onEditing = true;
  int _resendCodeTime = 120;
  late Timer _timer;

  @override
  void initState() {
    _startResendTimer();
    super.initState();

  }

  void _startResendTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      if(_resendCodeTime == 0){
        _timer.cancel();
      }else{
        setState(() {
          _resendCodeTime--;
        });
      }
    });
  }

  void _resendCode(){
    setState(() {
      _resendCodeTime = 120;
    });
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
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
              'Forgot Password',
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),

            const Text('To reset your password, please enter the OTP code sent to your email ',
              style: TextStyle(
                  fontFamily: fontFamily
              ),
            ),
            SizedBox(height: 40.h,),

            VerificationCode(
              // isSecure: true,
              itemSize: 40.h,
              autofocus: true,
              fullBorder: true,
              digitsOnly: true,
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
                });
                GoRouter.of(context).pushNamed('resetPasswordPage');
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
            ),

            // SizedBox(height: 20.h),
            Container(
              // color: red,
              height: 50.h,
              width: double.maxFinite,
              child: Center(
                child: _resendCodeTime == 0
                    ? TextButton(
                  onPressed: _resendCode,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15.sp,
                      color: primaryColor,
                    ),
                  ),
                )
                    : Text(
                  'Resend Code in ${_resendCodeTime ~/ 60}:${(_resendCodeTime % 60).toString().padLeft(2, '0')}',
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
      ),
    );
  }
}
