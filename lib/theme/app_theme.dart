import 'package:flutter/material.dart';
import 'app_color.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(background: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColor.primColor,
      backgroundColor: Colors.white,
    ),
    primaryColorLight: AppColor.primColor,
    scaffoldBackgroundColor: AppColor.bgColor,
    textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: 12, color: AppColor.secColor),
        bodyLarge: TextStyle(color: AppColor.primColor, fontSize: 25)),
    appBarTheme: AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(background: AppColor.blackColor),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColor.primColorDark,
      backgroundColor: AppColor.blackColor,
    ),
    primaryColorDark: AppColor.primColorDark,
    scaffoldBackgroundColor: AppColor.bgColorDark,
    textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: 12, color: AppColor.secColorDark),
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
