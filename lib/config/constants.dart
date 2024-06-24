import 'package:flutter/material.dart';

const String appName = "Youtube Clone";
const String apiUrl = "https://backend.com/api/";
const String firebase = "";
// final double screenHeight = MediaQuery.of(context).size.height;
// final double screenWidth = MediaQuery.of(context).size.width;




class ScreenSize {
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}