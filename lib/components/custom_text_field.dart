// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import '../constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.type,
    required this.hintText,
    required this.validator,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextInputType type;
  final String hintText;
  final validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSecure = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
      child: _cardWithLabelAndTextField(),
    );
  }

  Column _cardWithLabelAndTextField() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.label, style: kTextFieldLabelStyle),
          _textFormField(),
        ],
      );

  TextFormField _textFormField() => TextFormField(
        onFieldSubmitted: widget.onSubmitted,
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.type,
        obscureText: _isObscureText(),
        cursorColor: Colors.black,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            suffixIcon: _suffixIcon(),
            hintText: widget.hintText,
            focusedBorder: _underlineInputBorder(),
            enabledBorder: _underlineInputBorder(),
            hintStyle: const TextStyle(color: Colors.grey)),
      );

  bool _isObscureText() {
    if (!isSecure) {
      if (widget.label.contains('Password')) {
        return true;
      }
    }
    return false;
  }

  Widget? _suffixIcon() {
    if (widget.label.contains('Password')) {
      return IconButton(
        onPressed: () {
          setState(() {
            isSecure = !isSecure;
          });
        },
        icon: isSecure
            ? eyeIcon(CupertinoIcons.eye_slash)
            : eyeIcon(CupertinoIcons.eye),
      );
    }
    return null;
  }

  Icon eyeIcon(IconData icon) {
    return Icon(
      icon,
      size: kIconSize,
      color: Colors.grey,
    );
  }

  UnderlineInputBorder _underlineInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      );
}
