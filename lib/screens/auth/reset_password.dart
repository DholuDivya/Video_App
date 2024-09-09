import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_bloc.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_event.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';

import '../../config/constants.dart';
import '../../utils/widgets/custom_text_field_auth.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  bool _hasText = false;

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


  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password!";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }


  @override
  void initState() {
    _passwordController.addListener(_updateText);
    _confirmPasswordController.addListener(_confirmPassUpdateText);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateText);
    _confirmPasswordController.addListener(_confirmPassUpdateText);
    super.dispose();
  }

  void _updateText(){
    _hasText = _passwordController.text.isNotEmpty;
  }

  void _confirmPassUpdateText(){
    _hasText = _confirmPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: ScreenSize.screenWidth(context) * 0.05,
            right: ScreenSize.screenWidth(context) * 0.05
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            Text(
              'Reset Password',
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),

            Text('Create a strong password that has at least 8 characters long.',
              style: TextStyle(
                  fontFamily: fontFamily
              ),
            ),
            SizedBox(height: 40.h),


            CustomTextFieldUpload(
              readOnly: false,
                isEnabled: false,
                controller: TextEditingController(
                  text: widget.email
                ),
                fieldLabel: 'Email'
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),

            CustomTextField(
              obscureText: true && !_isPasswordVisible,
              controller: _passwordController,
              validator: _validatePassword,
              label: 'Password',
              suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                      _isPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash
                  )
              ),
            ),
            // passwordTextField(),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),

            CustomTextField(
              obscureText: true && !_isConfirmPasswordVisible,
              controller: _confirmPasswordController,
              validator: _validateConfirmPassword,
              label: 'Confirm Password',
              suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  icon: Icon(
                      _isConfirmPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash
                  )
              ),
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),


            CustomTextFieldUpload(
                readOnly: false,
                isEnabled: true,
                controller: _tokenController,
                fieldLabel: 'Token'
            ),
            SizedBox(height: 50.h,),

            BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
              builder: (BuildContext context, ResetPasswordState state) {
                if(state is ResetPasswordSuccess){

                  WidgetsBinding.instance.addPostFrameCallback((_){
                    GoRouter.of(context).pushReplacementNamed('signupPage');
                  });

                }
                return ElevatedButton(
                  onPressed: () {
                    String password = _passwordController.text;
                    String confirmPassword = _confirmPasswordController.text;
                    String token = _tokenController.text;

                    context.read<ResetPasswordBloc>().add(ResetPasswordRequest(
                      email: widget.email,
                      newPassword: password,
                        confirmPassword: confirmPassword,
                      token: token
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
