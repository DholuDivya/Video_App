import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:vimeo_clone/bloc/forgot_password/forgot_password_event.dart';
import 'package:vimeo_clone/bloc/forgot_password/forgot_password_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_auth.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  TextEditingController _emailController = TextEditingController();
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[gmail]+\.[a-zA-Z]{2,}$';
  
  // String? _code;
  // bool _onEditing = true;
  // int _resendCodeTime = 120;
  // late Timer _timer;

  @override
  void initState() {
    // _startResendTimer();
    super.initState();

  }

  // void _startResendTimer(){
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer){
  //     if(_resendCodeTime == 0){
  //       _timer.cancel();
  //     }else{
  //       setState(() {
  //         _resendCodeTime--;
  //       });
  //     }
  //   });
  // }
  //
  // void _resendCode(){
  //   setState(() {
  //     _resendCodeTime = 120;
  //   });
  //   _startResendTimer();
  // }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }


  String? _validateEmail(String? value){
    if(value == null || value.isEmpty){
      return AppLocalizations.of(context)!.pleaseEnterEmail;
    }
    RegExp regexp = RegExp(emailRegex);
    if(!regexp.hasMatch(value)){
      return AppLocalizations.of(context)!.emailIsNotValid;
    }
    return null;
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
              AppLocalizations.of(context)!.forgotPassword,
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),

            Text(AppLocalizations.of(context)!.toResetYourPasswordPleaseEnterYourEmail,
              style: TextStyle(
                  fontFamily: fontFamily
              ),
            ),
            SizedBox(height: 40.h,),


            CustomTextField(
              obscureText: false,
              controller: _emailController,
              validator: _validateEmail,
              label: AppLocalizations.of(context)!.email,
            ),
            
            
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (BuildContext context, ForgotPasswordState state) {
          if(state is ForgotPasswordSuccess){
            WidgetsBinding.instance.addPostFrameCallback((_){
              GoRouter.of(context).pushNamed(
                  'resetPasswordPage',
                  pathParameters: {
                    'email': _emailController.text
                  }
              );
            });

          }

          return ElevatedButton(
              onPressed: (){
                String email = _emailController.text;
                context.read<ForgotPasswordBloc>().add(ForgotPasswordRequest(userEmail: email));

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 135.w, vertical: 10.h),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.verify,
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18.sp
                ),
              )
          );
        },
      ),
    );
  }
}
