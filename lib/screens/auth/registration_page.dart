import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/auth/auth_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/auth/auth_bloc.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[gmail]+\.[a-zA-Z]{2,}$';
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isChecked = false;

  String? _validateName(String? value){
    if(value == null || value.isEmpty){
      return AppLocalizations.of(context)!.pleaseEnterName;
    }
    return null;
  }


  String? _validatePassword(String? value){
    if(value == null || value.isEmpty){
      return AppLocalizations.of(context)!.pleaseEnterPassword;
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

  bool _hasText = false;

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

  // Future<void> RegisterUser()async {
  //   try {
  //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //
  //     final idToken = await credential.user?.getIdToken();
  //     print('User Token ~~~~~~~~~ ${idToken}');
  //
  //     GoRouter.of(context).pushNamed('homePage');
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenSize.screenWidth(context) * 0.055,
                right: ScreenSize.screenWidth(context) * 0.055
            ),
            child: Column(
              children: [
                // Text('Welcome!'),
                Container(
                  height: ScreenSize.screenHeight(context) * 0.25,
                  child: SvgPicture.asset('assets/images/register_illustration.svg'),
                ),


              CustomTextField(
                obscureText: false,
                controller: _nameController,
                validator: _validateName,
                label: AppLocalizations.of(context)!.name,
              ),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),


              CustomTextField(
                obscureText: false,
                controller: _emailController,
                validator: _validateEmail,
                label: AppLocalizations.of(context)!.email,
              ),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),


                CustomTextField(
                  obscureText: true && !isPasswordVisible,
                  controller: _passwordController,
                  validator: _validatePassword,
                  label: AppLocalizations.of(context)!.password,
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
                // passwordTextField(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),

                CustomTextField(
                    obscureText: true && !isConfirmPasswordVisible,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                  label: AppLocalizations.of(context)!.confirmPassword,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                      icon: Icon(
                          isConfirmPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash,
                        color: greyShade600,
                      )
                  ),
                ),
                // confirmPasswordTextField(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.03,),


                termsAndCondition(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.028,),




                BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state){
                      if(state is AuthProgress){
                        return const Center(child: CircularProgressIndicator(),);
                      }else if(state is RegisterAuthSuccess){
                        print('success');
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          GoRouter.of(context).pushReplacementNamed('signupPage');
                        });
                        ToastManager().showToast(
                            context: context,
                            message: AppLocalizations.of(context)!.userCreatedSuccessfully
                        );
                      }else if(state is RegisterAuthFailure){
                        print('failure');
                        ToastManager().showToast(
                            context: context,
                            message: ''
                        );
                      }
                      return joinButton();
                    }
                ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.028,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget confirmPasswordTextField(){
    return SizedBox(
      height: ScreenSize.screenHeight(context) * 0.1,
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: true && !isConfirmPasswordVisible,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        validator: _validateConfirmPassword,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: primaryColor,  width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(),
            ),
            suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  });
                },
                icon: Icon(
                    isConfirmPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash
                )
            ),
            labelText: AppLocalizations.of(context)!.confirmPassword,
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary
            ),
            helperText: ''
        ),
      ),
    );
  }


  Widget termsAndCondition() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 0.8.r,
          child: Checkbox(
            activeColor: Colors.blue,
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '${AppLocalizations.of(context)!.by} $appName, ${AppLocalizations.of(context)!.youAgreeToOur} ',
              style: TextStyle(
                fontSize: 10.sp,
                fontFamily: fontFamily,
                color: Theme.of(context).colorScheme.secondaryFixedDim,
              ),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.termsAndService,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: fontFamily,
                    color: blue, // Link color
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to Terms of Service page
                      GoRouter.of(context).pushNamed('termsAndConditionsPage');
                    },
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.andAcknowledgeOur,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: fontFamily,
                    color: Theme.of(context).colorScheme.secondaryFixedDim,
                  ),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.privacypolicy,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: fontFamily,
                    color: blue, // Link color
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to Privacy Policy page
                      GoRouter.of(context).pushNamed('privacyPolicyPage');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget joinButton(){
    return Container(
      height: ScreenSize.screenHeight(context) * 0.070,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
          onPressed: (){
            if (_formkey.currentState!.validate()) {
              print("Form is Valid");
              if(isChecked == true){
                final String name = _nameController.text;
                final String email = _emailController.text;
                final String password = _passwordController.text;

                print('${name}     ${email}   ${password}');
                context.read<AuthBloc>().add(OnUserRegisterRequestEvent(name: name, email: email, password: password));
              }else{
                ToastManager().showToast(
                    context: context,
                    message: AppLocalizations.of(context)!.pleaseAgreeToOurPrivacyFirst
                );
              }


            }
            else{
              print("Form is not Valid");
            }
          },
        child: Text(AppLocalizations.of(context)!.join,
          style: TextStyle(
            fontSize: 17,
              fontFamily: fontFamily,
            color: Colors.white
          ),
        ),
      ),
    );
  }


  Widget orText(){
    return Row(
      children: [
        Expanded(child: Divider(thickness: 0.3,)),
        SizedBox(width: ScreenSize.screenWidth(context) * 0.025,),
        AutoSizeText(AppLocalizations.of(context)!.or, style: TextStyle(color: Colors.grey[500], fontFamily: fontFamily),),
        SizedBox(width: ScreenSize.screenWidth(context) * 0.025,),
        Expanded(child: Divider(thickness: 0.3,)),
      ],
    );
  }





  Widget logInButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          AppLocalizations.of(context)!.haveAnAccount,
          style: TextStyle(
            fontSize: 15,
            fontFamily: fontFamily
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: AutoSizeText(
            AppLocalizations.of(context)!.login,
            style: TextStyle(
                fontWeight: FontWeight.bold,
              fontFamily: fontFamily
            ),
          ),
        )
      ],
    );
  }

}

