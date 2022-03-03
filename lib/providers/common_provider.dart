import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  late int _selectedIndex = 0;
  late int _addressCount = 0;
  late double _totalAmount = 0.0;

  void setUpdatedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get getSelectedIndex => _selectedIndex;

  void setAddressCount(int count, [int val = 0]) {
    _addressCount = val;
    _addressCount = count;
    notifyListeners();
  }

  int get getAddressCount => _addressCount;

  void setTotalAmount(dynamic data, [double val = 0]) {
    _totalAmount = val;
    for (int i = 0; i < data.length; i++) {
      _totalAmount = _totalAmount +
          (double.parse(data[i]['price']) * data[i]['itemCount']);
    }
    notifyListeners();
  }

  double get getTotalAmount => _totalAmount.roundToDouble();
}
