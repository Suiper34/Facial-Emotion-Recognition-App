import 'package:flutter/material.dart';

import 'appColor.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.bodyColor,
  hintColor: AppColor.textColor,
  primaryColorLight: AppColor.buttonBackgroundColor,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Colors.black,
  ),
  colorScheme: ColorScheme.light(
    background: AppColor.bodyColor,
  ),
);
