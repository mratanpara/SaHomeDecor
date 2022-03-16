// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import '../constants/constants.dart';
import 'custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomCardTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final Function(String) onPressed;
  final TextInputType type;
  final String hintText;
  final validator;

  const CustomCardTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.onPressed,
    required this.type,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxShadow,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: kSymmetricPaddingHor,
          child: CustomTextField(
            label: label,
            hintText: hintText,
            controller: controller,
            focusNode: focusNode,
            onSubmitted: onPressed,
            type: type,
            validator: validator,
          ),
        ),
      ),
    );
  }
}
