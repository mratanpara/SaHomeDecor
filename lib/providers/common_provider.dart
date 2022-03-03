import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  late int _selectedIndex = 0;
  late int _addressCount = 0;
  late double _totalAmount = 0.0;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void getCount(int count, [int val = 0]) {
    _addressCount = val;
    _addressCount = count;
    notifyListeners();
  }

  void getTotalAmount(dynamic data, [double val = 0]) {
    _totalAmount = val;
    for (int i = 0; i < data.length; i++) {
      _totalAmount = _totalAmount + (double.parse(data[i]['price']));
    }
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  int get addressCount => _addressCount;

  double get totalAmount => _totalAmount.roundToDouble();
}
