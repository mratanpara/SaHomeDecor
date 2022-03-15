import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  late int _addressCount = 0;

  void setAddressCount(int count, [int val = 0]) {
    _addressCount = val;
    _addressCount = count;
    notifyListeners();
  }

  int get getAddressCount => _addressCount;
}
