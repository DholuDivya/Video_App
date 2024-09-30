import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_bloc.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_event.dart';
import 'package:vimeo_clone/bloc/reset_password/reset_password_state.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/colors.dart';
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
      return AppLocalizations.of(context)!.pleaseEnterFirstName;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMustBeAtLeast6Characters;
    }
    RegExp regexp = RegExp(pattern);
    if(!regexp.hasMatch(value)){
      return AppLocalizations.of(context)!.passwordMustBeAtLeast8Characters;
    }
    return null;
  }


  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterConfirmPassword;
    }
    if (value != _passwordController.text) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
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
              AppLocalizations.of(context)!.resetPassword,
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),

            Text(AppLocalizations.of(context)!.createStrongPassword,
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
                fieldLabel: AppLocalizations.of(context)!.email
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),

            CustomTextField(
              obscureText: true && !_isPasswordVisible,
              controller: _passwordController,
              validator: _validatePassword,
              label: AppLocalizations.of(context)!.password,
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
              label: AppLocalizations.of(context)!.confirmPassword,
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
                fieldLabel: AppLocalizations.of(context)!.token
            ),
            SizedBox(height: 50.h,),

            // BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            //   builder: (BuildContext context, ResetPasswordState state) {
            //     if(state is ResetPasswordSuccess){
            //
            //       WidgetsBinding.instance.addPostFrameCallback((_){
            //         GoRouter.of(context).pushReplacementNamed('signupPage');
            //       });
            //       ToastManager().showToast(
            //           context: context,
            //           message: 'Reset password successfully'
            //       );
            //     }else if(state is ResetPasswordFailure){
            //       ToastManager().showToast(
            //           context: context,
            //           message: 'Something went wrong'
            //       );
            //     }
            //     return ElevatedButton(
            //       onPressed: () {
            //         String password = _passwordController.text;
            //         String confirmPassword = _confirmPasswordController.text;
            //         String token = _tokenController.text;
            //
            //         context.read<ResetPasswordBloc>().add(ResetPasswordRequest(
            //           email: widget.email,
            //           newPassword: password,
            //             confirmPassword: confirmPassword,
            //           token: token
            //         ));
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue,
            //         padding: const EdgeInsets.symmetric(vertical: 16),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           'Continue',
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontFamily: fontFamily,
            //               color: Colors.white
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),

      floatingActionButton: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (BuildContext context, ResetPasswordState state) {
          if(state is ResetPasswordSuccess){

            WidgetsBinding.instance.addPostFrameCallback((_){
              GoRouter.of(context).pushReplacementNamed('signupPage');
            });
            ToastManager().showToast(
                context: context,
                message: AppLocalizations.of(context)!.resetPasswordSuccessfully
            );
          }else if(state is ResetPasswordFailure){
            ToastManager().showToast(
                context: context,
                message: AppLocalizations.of(context)!.somethingWentWrong
            );
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
                padding: EdgeInsets.symmetric(
                    horizontal: 138.w, vertical: 13.h),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.submit,
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16.sp
                ),
              )
          );
        },
      ),
    );
  }
}
