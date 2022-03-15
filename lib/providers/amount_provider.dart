import 'package:decor/constants/params_constants.dart';
import 'package:flutter/material.dart';

class AmountProvider extends ChangeNotifier {
  late double _totalAmount = 0.0;

  void setTotalAmount(dynamic data, [double val = 0]) {
    _totalAmount = val;
    for (int i = 0; i < data.length; i++) {
      _totalAmount = _totalAmount +
          (double.parse(data[i][paramPrice]) * data[i][paramItemCount]);
    }
    notifyListeners();
  }

  double get getTotalAmount => _totalAmount.roundToDouble();
}
