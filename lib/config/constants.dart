import 'package:flutter/material.dart';

const String appName = "Cineplex";
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


String formatDuration(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;

  String hoursStr = (hours < 10) ? "0$hours" : "$hours";
  String minutesStr = (minutes < 10) ? "0$minutes" : "$minutes";
  String secondsStr = (remainingSeconds < 10) ? "0$remainingSeconds" : "$remainingSeconds";

  if (hours > 0) {
    return "$hoursStr:$minutesStr:$secondsStr";
  } else {
    return "$minutesStr:$secondsStr";
  }
}