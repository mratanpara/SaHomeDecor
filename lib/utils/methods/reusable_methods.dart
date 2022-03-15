import 'package:flutter/material.dart';

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

SnackBar showSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(content),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
  );
}
