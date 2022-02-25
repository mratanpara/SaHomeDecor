import 'package:decor/constants.dart';
import 'package:flutter/material.dart';

class FacebookSigninButton extends StatelessWidget {
  FacebookSigninButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton.icon(
        onPressed: () {},
        label: Text(label),
        icon: const Icon(Icons.facebook, size: 32),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: kNormalFontSize,
          ),
        ),
      ),
    );
  }
}
