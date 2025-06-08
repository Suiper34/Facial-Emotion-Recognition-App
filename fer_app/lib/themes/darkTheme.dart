import 'package:flutter/material.dart';

import 'appColor.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.bodyColorDark,
  hintColor: AppColor.textColor,
  primaryColorLight: AppColor.buttonBackgroundColorDark,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Colors.white,
  ),
  colorScheme: ColorScheme(
    background: AppColor.bodyColorDark,
    brightness: Brightness.dark,
    primary: AppColor.bodyColorDark,
    onPrimary: AppColor.bodyColorDark,
    secondary: const Color.fromARGB(
      255,
      54,
      54,
      55,
    ),
    onSecondary: const Color.fromARGB(
      255,
      54,
      54,
      55,
    ),
    error: const Color.fromARGB(
      255,
      143,
      13,
      13,
    ),
    onError: const Color.fromARGB(
      255,
      143,
      13,
      13,
    ),
    onBackground: AppColor.bodyColorDark,
    surface: Colors.transparent,
    onSurface: Colors.transparent,
  ),
);
