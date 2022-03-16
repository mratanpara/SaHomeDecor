// ignore_for_file: use_key_in_widget_constructors

import '../../../constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
      onPressed: onPressed,
      child: Text(
        text,
        style: kForgotPasswordTextStyle,
      ),
    );
  }
}
