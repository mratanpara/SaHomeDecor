// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomRectButton extends StatelessWidget {
  const CustomRectButton({
    required this.width,
    required this.height,
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.iconColor,
  });

  final IconData icon;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(icon, color: iconColor),
      elevation: 1.0,
      fillColor: color,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      constraints: BoxConstraints.tightFor(
        height: height,
        width: width,
      ),
    );
  }
}
