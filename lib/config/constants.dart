import 'package:flutter/material.dart';

const String appName = "Divya";
const String apiUrl = "https://videoapp.taskhub.company/api/";
const String firebase = "";


// FONT FAMILY
const String fontFamily = 'Poppins';



class ScreenSize {
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}