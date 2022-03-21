import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData selectedTheme;
  bool isSwitchOn = false;

  ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Asap',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white10,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.black)),
    iconTheme: const IconThemeData(color: Colors.grey),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black),
    tabBarTheme: const TabBarTheme(
        labelColor: Colors.black, unselectedLabelColor: Colors.grey),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Colors.black),
        checkColor: MaterialStateProperty.all(Colors.white)),
  );

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Asap',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white10,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.grey),
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.white)),
    iconTheme: const IconThemeData(color: Colors.white),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    tabBarTheme: const TabBarTheme(
        labelColor: Colors.white, unselectedLabelColor: Colors.grey),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Colors.white),
        checkColor: MaterialStateProperty.all(Colors.black)),
  );

  ThemeProvider({required bool isDarkMode}) {
    selectedTheme = isDarkMode ? dark : light;
  }

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (selectedTheme == dark) {
      selectedTheme = light;
      prefs.setBool("isDarkTheme", false);
    } else {
      selectedTheme = dark;
      prefs.setBool("isDarkTheme", true);
    }
    notifyListeners();
  }

  ThemeData get getTheme => selectedTheme;
}
