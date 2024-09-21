import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const String appName = "Cineplex";
const String apiUrl = "https://cineplex.infinitietech.com/api/";
const String firebase = "";
const String adUnitId = "ca-app-pub-2734509756038446/1670883979";


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


String formatDate(String videoCreatedDate){
  String date = videoCreatedDate;
  DateTime dateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('MMMM dd, yyyy');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}


String formatLastDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (hours >= 0) {
    return '${hours}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }
}


class ToastManager {
  static final ToastManager _instance = ToastManager._internal();
  factory ToastManager() => _instance;
  ToastManager._internal();

  Timer? _toastTimer;
  bool _isToastShowing = false;

  void showToast({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    double fontSize = 16.0,
    Toast? toastLength,
    ToastGravity? gravity,
  }) {
    if (_isToastShowing) {
      return;
    }

    _isToastShowing = true;

    Fluttertoast.showToast(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.tertiary,
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: textColor ?? Theme.of(context).colorScheme.surface,
      fontSize: fontSize,
    );

    _toastTimer?.cancel();
    _toastTimer = Timer(Duration(seconds: 1), () {
      _isToastShowing = false;
    });
  }
}




Future<void> launchAppStoreOrPlayStore(String packageName) async {
  String url;

  // Check if the platform is Android or iOS and set the appropriate store URL
  if (Platform.isAndroid) {
    // Redirect to Google Play Store
    url = 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (Platform.isIOS) {
    // Redirect to Apple App Store
    url = 'https://apps.apple.com/app/id$packageName';
  } else {
    throw Exception('Unsupported platform');
  }

  // Attempt to launch the URL
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}