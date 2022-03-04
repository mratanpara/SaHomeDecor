import 'package:decor/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {required this.text, required this.trailing, required this.onTap});

  final String text;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxShadow,
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          title: Text(
            text,
            style: const TextStyle(fontSize: kNormalFontSize),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
