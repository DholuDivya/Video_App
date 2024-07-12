import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field.dart';
import '../../Repo/auth_repo.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../config/colors.dart';

class SignupWithPhoneNumber extends StatefulWidget {
  const SignupWithPhoneNumber({super.key});

  @override
  State<SignupWithPhoneNumber> createState() => _SignupWithPhoneNumberState();
}

class _SignupWithPhoneNumberState extends State<SignupWithPhoneNumber> {
  // final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _phoneNumber = '';
  String _countryCode = '';

  // String verifyPhone = '${_countryCode}+_phoneNumber';
  late AuthBloc _authBloc;

  // @override
  // void initState() {
  //   super.initState();
  //   _authBloc = AuthBloc(AuthRepository());
  // }
  //
  // @override
  // void dispose() {
  //   _authBloc.close();
  //   super.dispose();
  // }

  void _phoneNumberAuthentication() {
    final phoneNumber = _countryCode+_phoneNumber;
    // context.read<AuthBloc>().authRepository()
    context.read<AuthBloc>().add(SendOtpToPhoneEvent(number: phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          if (state is LoginPhoneCodeSentState) {
            // Navigate to OTP verification page and pass verificationId
            GoRouter.of(context).push('/verificationPage/${state.verificationId}');

          } else if (state is AuthSuccess) {
            // Navigate to the home page or show a success message
            GoRouter.of(context).pushReplacementNamed('homePage');
          } else if (state is AuthFailure) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Authentication Failed')),
            );
          }
        },

        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.055,
              right: ScreenSize.screenWidth(context) * 0.055
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Chief!',
                      style: TextStyle(
                        fontFamily: fontFamily,
                          fontSize: 22,
                          // fontWeight: FontWeight.bold
                      ),
                      // textAlign: TextAlign.center,
                    ),
                    Text(
                        'Please enter your name and phone number to log in ',
                      style: TextStyle(
                        fontFamily: fontFamily,
                          fontSize: 15,
                        color: Colors.grey.shade500
                      ),
                    )
                  ],
                ),

                Container(
                  height: ScreenSize.screenHeight(context) * 0.3,
                  child: SvgPicture.asset('assets/images/number_signup_illustration.svg'),
                ),
                // SizedBox(height: ScreenSize.screenHeight(context) * 0.01),

                CustomTextField(
                  obscureText: false,
                  label: 'Name',
                ),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.025,),

                IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixedDim
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: primaryColor,
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0
                      ),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    setState(() {
                      _phoneNumber = phone.number;
                      _countryCode = phone.countryCode;
                    });
                  },
                  onCountryChanged: (country) {
                    setState(() {
                      _countryCode = country.dialCode;
                    });
                  },
                  validator: (phone) {
                    if (phone == null || phone.number.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.18,),


                MaterialButton(
                  color: primaryColor,
                  minWidth: double.infinity,
                  height: ScreenSize.screenHeight(context) * 0.070,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  onPressed: (){_phoneNumberAuthentication();},
                    // GoRouter.of(context).pushNamed('verificationPage');
                    // if (_formKey.currentState!.validate()) {
                    //   print('Phone Number: $_countryCode $_phoneNumber');
                    // }
                  child: Text(
                    'Send Code',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



















// import 'package:flutter/material.dart';
// import 'package:remixicon/remixicon.dart';
// import 'package:vimeo_clone/config/colors.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController emailController = TextEditingController();
//
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Spacer(flex: 1),
//                 SizedBox(height: 80,),
//                 Center(
//                   child: Text(
//                     'Create an account',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigate to login page
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Already have an account?',
//                           style: TextStyle(
//                             fontSize: 14,
//                             // color: Colors.blue,
//                           ),
//                         ),
//                         Text(
//                           ' Login',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: blue
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 32),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email address',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     suffixIcon: Icon(Icons.visibility_off),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     style: ButtonStyle(
//
//                     ),
//                     onPressed: () {
//                     },
//                     child: Text(
//                       'Forgot Password',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.black54
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle continue action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 Center(
//                   child: Text(
//                     'or sign up with',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.black54,
//                           width: 0.5
//                         )
//                       ),
//                       child: IconButton(
//                         style: ButtonStyle(
//                             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)
//                                 )
//                               // border: BorderRadius.circular(10)
//                             )
//                         ),
//                         icon: Icon(Remix.google_fill),
//                         iconSize: 30,
//                         onPressed: () {
//                           // Handle Google sign-up
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Container(
//                       width: 80,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.black54,
//                           width: 0.5
//                         )
//                       ),
//                       child: IconButton(
//                         style: ButtonStyle(
//                             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)
//                                 )
//                               // border: BorderRadius.circular(10)
//                             )
//                         ),
//                         icon:  Icon(Remix.apple_fill),
//                         iconSize: 30,
//                         onPressed: () {
//                           // Handle Apple sign-up
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Container(
//                       width: 80,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                               color: Colors.black54,
//                               width: 0.5
//                           )
//                       ),
//                       child: IconButton(
//                         style: ButtonStyle(
//                           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)
//                             )
//                             // border: BorderRadius.circular(10)
//                           )
//                         ),
//                         icon:  Icon(Remix.facebook_fill),
//                         iconSize: 30,
//                         onPressed: () {
//                           // Handle Facebook sign-up
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Spacer(flex: 2),
//                 SizedBox(height: 100,),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       'By clicking Create account you agree to Recognotes Terms of use and Privacy policy',
//                       textAlign: TextAlign.center,
//                       style:TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Spacer(flex: 1),
//                 SizedBox(height: 10,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }