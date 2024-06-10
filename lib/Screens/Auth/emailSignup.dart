import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/colors.dart';


class SignupWithEmail extends StatefulWidget {
  const SignupWithEmail({super.key});

  @override
  State<SignupWithEmail> createState() => _SignupWithEmailState();
}

class _SignupWithEmailState extends State<SignupWithEmail> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
      return "Passowrd must be at least 6 characters";
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth*0.055,
                right: screenWidth*0.055
            ),
            child: Column(
              children: [
                appName(),
                SizedBox(height: screenHeight*0.04,),
          
          
                nameTextField(),
                SizedBox(height: screenHeight*0.015,),
          
          
                emailTextField(),
                SizedBox(height: screenHeight*0.015,),
          
          
                passwordTextField(),
                SizedBox(height: screenHeight*0.025,),
          
          
                termsAndCondition(),
                SizedBox(height: screenHeight*0.028,),
          
          
                joinButton(),
                SizedBox(height: screenHeight*0.028,),
          
          
                orText(),
                SizedBox(height: screenHeight*0.03,),
          
          
                googleLogin(),
                SizedBox(height: screenHeight*0.08,),
          
          
                logInButton(),
          
              ],
            ),
          ),
        ),
      ),
    );
  }

  // App Name/ Label
  Widget appName(){
    return const AutoSizeText(
        "Join Vimeo",
      style: TextStyle(
        fontSize: 40,
      ),
    );
  }


  Widget nameTextField(){
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight*0.075,
      child: TextFormField(
        controller: _nameController,
        validator: _validateName,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          labelText: "Name"
        ),
      ),
    );
  }



  Widget emailTextField(){
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight*0.075,
      child: TextFormField(
        controller: _emailController,
        validator: _validateEmail,
        decoration: InputDecoration(
          filled: true,
            fillColor: Colors.grey[100],
            labelText: "Email"
        ),
      ),
    );
  }


  Widget passwordTextField(){
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight*0.075,
      child: TextFormField(
        controller: _passwordController,
        obscureText: true && !isPasswordVisible,
        validator: _validatePassword,
        decoration: InputDecoration(
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
          filled: true,
            fillColor: Colors.grey[100],
            labelText: "Password"
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
            activeColor: Colors.black,
            value: isChecked,
            onChanged: (value){
              setState(() {
                isChecked = value!;
              });
            }
        ),
        const Expanded(
            child: AutoSizeText(""
                "By Joining Vimeo, you agree to our Terms of Service and "
                "acknowledge our Privacy Policy and Cookie Policy.",
              style: TextStyle(
                fontSize: 12
              ),
            )
        ),


      ],
    );
  }

  Widget joinButton(){
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.070,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
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
        child: const AutoSizeText("Join", style: TextStyle(fontSize: 17),),
      ),
    );
  }


  Widget orText(){
    // final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(child: Divider(thickness: 0.3,)),
        SizedBox(width: screenWidth*0.025,),
        AutoSizeText("or", style: TextStyle(color: Colors.grey[500]),),
        SizedBox(width: screenWidth*0.025,),
        Expanded(child: Divider(thickness: 0.3,)),
      ],
    );
  }


  Widget googleLogin(){
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.070,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15)
      ),
      child: ElevatedButton(
        onPressed: (){},
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Remix.google_fill),
            AutoSizeText("Continue with Google", style: TextStyle(fontSize: 17),),
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
            fontSize: 15
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const AutoSizeText(
            'Log in.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

}

