import 'package:flutter/material.dart';

const Color_Primary = Colors.blue;
const Color_Accent = Colors.blueAccent;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color_Primary,

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color_Accent
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0)
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        )
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        Color_Accent
      )
    )
  )
);





ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark
);