import 'package:decor/constants/constants.dart';
import 'package:decor/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomCardTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final Function(String) onPressed;
  final TextInputType type;
  final String hintText;

  CustomCardTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.onPressed,
    required this.type,
    required this.hintText,
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
          ),
        ),
      ),
    );
  }
}
