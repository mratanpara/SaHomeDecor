import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  late int _selectedIndex = 0;

  void setUpdatedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get getSelectedIndex => _selectedIndex;
}
