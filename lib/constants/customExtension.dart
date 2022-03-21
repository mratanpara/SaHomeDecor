import 'constants.dart';
import 'package:flutter/material.dart';

extension CustomExtension on Widget {
  Widget padAll() => Padding(padding: kAllPadding, child: this);
  Widget padTop() =>
      Padding(padding: const EdgeInsets.only(top: 20), child: this);
}
