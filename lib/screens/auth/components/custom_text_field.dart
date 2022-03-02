import 'package:decor/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.type,
    required this.hintText,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextInputType type;
  final String hintText;

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
      child: _textField(),
    );
  }

  Column _textField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label, style: kTextFieldLabelStyle),
        TextFormField(
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          controller: widget.controller,
          keyboardType: widget.type,
          obscureText: _isObscureText(),
          cursorColor: Colors.black,
          decoration: InputDecoration(
              suffixIcon: _suffixIcon(),
              hintText: widget.hintText,
              focusedBorder: _underlineInputBorder(),
              enabledBorder: _underlineInputBorder(),
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  bool _isObscureText() {
    if (!isSecure) {
      if (widget.label == 'Password' || widget.label == 'Confirm Password') {
        return true;
      }
    }
    return false;
  }

  Widget? _suffixIcon() {
    if (widget.label == 'Password' || widget.label == 'Confirm Password') {
      return IconButton(
        onPressed: () {
          setState(() {
            isSecure = !isSecure;
          });
        },
        icon: const Icon(
          CupertinoIcons.eye,
          size: kIconSize,
          color: Colors.grey,
        ),
      );
    }
    return null;
  }

  UnderlineInputBorder _underlineInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      );
}
