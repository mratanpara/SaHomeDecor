import 'package:decor/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Asap',
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white10,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
