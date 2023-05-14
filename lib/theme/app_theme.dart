import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColor.primColor,
      backgroundColor: Colors.white,

    ),
    primaryColorLight: AppColor.primColor,
    scaffoldBackgroundColor: AppColor.bgColor,
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColor.primColor, fontSize: 25)),
    appBarTheme: AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColor.primColorDark,
      backgroundColor: AppColor.secColorDark,
    ),
    primaryColorDark: AppColor.primColorDark,
    scaffoldBackgroundColor: AppColor.bgColorDark,
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColor.secColorDark, fontSize: 25)),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primColor,
      titleTextStyle: TextStyle(
          color: AppColor.secColorDark,
          fontSize: 30,
          fontWeight: FontWeight.bold),
    ),
  );
}
