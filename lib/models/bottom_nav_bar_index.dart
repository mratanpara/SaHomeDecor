import 'package:flutter/material.dart';

class BottomNavBarIndex extends ChangeNotifier {
  late int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
