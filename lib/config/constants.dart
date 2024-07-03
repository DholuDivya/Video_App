import 'package:flutter/material.dart';

const String appName = "Youtube";
const String apiUrl = "https://backend.com/api/";
const String firebase = "";
// final double screenHeight = MediaQuery.of(context).size.height;
// final double screenWidth = MediaQuery.of(context).size.width;

const String fontFamily = 'Poppins';




class ScreenSize {
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}