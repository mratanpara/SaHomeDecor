import 'package:decor/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({required this.text, required this.onPressed});

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
