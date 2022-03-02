import 'package:decor/constants/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Asap',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white10,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
