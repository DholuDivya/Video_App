import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/colors.dart';



// LIGHT MODE
ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(

      primary: Colors.grey.shade200,
      surface: Colors.white,
      secondary: Colors.grey.shade300,
      tertiary: Colors.grey.shade900,

      primaryFixedDim: textFieldLabelLight,
      surfaceDim: greyShade100,
      secondaryFixedDim: greyShade500,
      tertiaryFixedDim: greyShade200,


      primaryContainer: greyShade200,

        // TEXT
        onPrimaryFixedVariant: greyShade800

    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor
    ),


    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0)
            ),
            shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                primaryColor
            )
        )
    ),

    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     shape: MaterialStateProperty.all<OutlinedBorder>(
    //       RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //     ),
    //     backgroundColor: MaterialStateProperty.all<Color>(
    //       primaryColor,
    //     ),
    //   ),
    // ),


    checkboxTheme: CheckboxThemeData(
      side: BorderSide(
        color: darkOpacityColor
      )
    )
);



// DARK MODE
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(


      primary: Colors.grey.shade500,
      surface: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
      tertiary: Colors.white,


      primaryFixedDim: textFieldLabelDark,
      surfaceDim : white12,
      secondaryFixedDim: white54,
      tertiaryFixedDim: white24,


      onPrimaryContainer: white24,

      // TEXT
      onPrimaryFixedVariant: white70

    ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkPrimaryColor
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0)
          ),
          shape: WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              darkPrimaryColor
          )
      )
  ),

    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     // textStyle: WidgetStatePropertyAll<TextStyle>(
    //     //
    //     // ),
    //     shape: MaterialStateProperty.all<OutlinedBorder>(
    //       RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //     ),
    //     backgroundColor: MaterialStateProperty.all<Color>(
    //       primaryColor,
    //     ),
    //   ),
    // ),

    checkboxTheme: CheckboxThemeData(
        side: BorderSide(
            color: lightOpacityColor
        )
    )
);