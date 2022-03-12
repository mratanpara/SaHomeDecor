import 'package:decor/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        onChanged: (text) => setState(() => _errorText),
        decoration: InputDecoration(
            errorText: _errorText,
            suffixIcon: _suffixIcon(),
            hintText: widget.hintText,
            focusedBorder: _underlineInputBorder(),
            enabledBorder: _underlineInputBorder(),
            hintStyle: const TextStyle(color: Colors.grey)),
      );

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = widget.controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

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
