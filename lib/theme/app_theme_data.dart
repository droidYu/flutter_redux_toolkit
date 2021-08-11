import 'package:flutter/material.dart';

import 'light_theme.dart';

class AppThemeData {
  static ThemeData get lightTheme {
    var lightTheme = LightTheme();
    return ThemeData(
      // primarySwatch: MaterialColor(0xFFADABAB, <int, Color>{
      //   50: Color(0xFFFAFAFA),
      //   100: Color(0xFFF5F5F5),
      //   200: Color(0xFFEEEEEE),
      //   300: Color(0xFFE0E0E0),
      //   350: Color(
      //       0xFFD6D6D6), // only for raised button while pressed in light theme
      //   400: Color(0xFFBDBDBD),
      //   500: Color(0xFFADABAB),
      //   600: Color(0xFF757575),
      //   700: Color(0xFF616161),
      //   800: Color(0xFF424242),
      //   850: Color(0xFF303030), // only for background color in dark theme
      //   900: Color(0xFF212121),
      // }),
      primarySwatch: Colors.grey,

      //primaryColor: CustomColors.purple,
      scaffoldBackgroundColor: lightTheme.appBackgroundColor(), // 0xFFF6F3F0
      appBarTheme: AppBarTheme(
          backgroundColor: lightTheme.appBarColor(),
          foregroundColor: Colors.white), // 0xFFAA2B2F

      inputDecorationTheme: InputDecorationTheme(
        fillColor: lightTheme.inputDecorationFillColor(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xFFADABAB))),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //     borderSide: BorderSide(color: Color(0xFFADABAB))),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //     borderSide: BorderSide(color: Color(0xFFADABAB))),
      ),
      fontFamily: 'SF Pro Display',
    );
  }
}
