import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';


class SignupWithEmail extends StatefulWidget {
  const SignupWithEmail({super.key});

  @override
  State<SignupWithEmail> createState() => _SignupWithEmailState();
}

class _SignupWithEmailState extends State<SignupWithEmail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[gmail]+\.[a-zA-Z]{2,}$';
  bool isPasswordVisible = false;
  bool isChecked = false;

  String? _validateName(String? value){
    if(value == null || value.isEmpty){
      return "Please enter Name !";
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

  bool _hasText = false;

  @override
  void initState() {
    _passwordController.addListener(_updateText);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateText);
    super.dispose();
  }

  void _updateText(){
    _hasText = _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                CustomAppName(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.04,),

                nameTextField(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.005,),


                emailTextField(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.005,),


                passwordTextField(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.001,),


                termsAndCondition(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.028,),


                joinButton(),
                SizedBox(height: ScreenSize.screenHeight(context) * 0.028,),


                // orText(),
                // SizedBox(height: ScreenSize.screenHeight(context) * 0.03,),
                //
                //
                // // googleLogin(),
                // // SizedBox(height: ScreenSize.screenHeight(context) * 0.08,),
                //
                //
                // logInButton(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // App Name/ Label
  Widget CustomAppName(){
    return const AutoSizeText(
        appName,
      style: TextStyle(
        fontSize: 35,
        fontFamily: fontFamily
      ),
    );
  }


  Widget nameTextField(){
    return Container(
      height: ScreenSize.screenHeight(context) * 0.1,
      child: TextFormField(
        controller: _nameController,
        validator: _validateName,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(),
            ),
          // filled: true,
          // fillColor: Colors.grey[100],
          labelText: "Name",
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary
            ),

          helperText: ''
        ),

      ),
    );
  }



  Widget emailTextField(){
    return SizedBox(
      height: ScreenSize.screenHeight(context) * 0.1,
      child: TextFormField(
        controller: _emailController,
        validator: _validateEmail,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(),
            ),
            // filled: true,
            // fillColor: Colors.grey[100],
            // fillColor: Colors.grey[100],
            labelText: "Email",
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary
            ),
          helperText: ''
        ),
      ),
    );
  }


  Widget passwordTextField(){
    return SizedBox(
      height: ScreenSize.screenHeight(context) * 0.1,
      child: TextFormField(
        controller: _passwordController,
        obscureText: true && !isPasswordVisible,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        validator: _validatePassword,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(),
            ),
          suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off
              )
          ),
            labelText: "Password",
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary
            ),
            helperText: ''
        ),
      ),
    );
  }


  Widget termsAndCondition(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: Colors.blue,
            value: isChecked,
            onChanged: (value){
              setState(() {
                isChecked = value!;
              });
            }
        ),
        const Expanded(
            child: AutoSizeText(""
                "By $appName, you agree to our Terms of Service and "
                "acknowledge our Privacy Policy and Cookie Policy.",
              style: TextStyle(
                fontSize: 12,
                fontFamily: fontFamily
              ),
            )
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
          onPressed: (){
            if (_formkey.currentState!.validate()) {
              print("Form is Valid");
              // getData();
            }
            else{
              print("Form is not Valid");
            }
          },
        child: const AutoSizeText("Join", style: TextStyle(fontSize: 17, fontFamily: fontFamily),),
      ),
    );
  }


  Widget orText(){
    return Row(
      children: [
        Expanded(child: Divider(thickness: 0.3,)),
        SizedBox(width: ScreenSize.screenWidth(context) * 0.025,),
        AutoSizeText("or", style: TextStyle(color: Colors.grey[500], fontFamily: fontFamily),),
        SizedBox(width: ScreenSize.screenWidth(context) * 0.025,),
        Expanded(child: Divider(thickness: 0.3,)),
      ],
    );
  }


  Widget googleLogin(){
    return Container(
      height: ScreenSize.screenHeight(context) * 0.070,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15)
      ),
      child: ElevatedButton(
        onPressed: (){},
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Remix.google_fill),
            AutoSizeText("Continue with Google", style: TextStyle(fontSize: 17, fontFamily: fontFamily),),
          ],
        ),
      ),
    );
  }


  Widget logInButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AutoSizeText(
          'Have an account? ',
          style: TextStyle(
            fontSize: 15,
            fontFamily: fontFamily
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const AutoSizeText(
            'Log in.',
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

