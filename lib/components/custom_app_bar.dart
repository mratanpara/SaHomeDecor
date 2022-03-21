// ignore_for_file: use_key_in_widget_constructors

import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onLeadingIconPressed;
  final VoidCallback? onActionIconPressed;

  const CustomAppBar({
    required this.title,
    required this.actionIcon,
    required this.leadingIcon,
    required this.onActionIconPressed,
    required this.onLeadingIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      leading: _leadingIcon(),
      centerTitle: true,
      title: _title(),
      actions: _actions(),
    );
  }

  IconButton _leadingIcon() => IconButton(
        onPressed: onLeadingIconPressed,
        icon: Icon(
          leadingIcon,
          size: kIconSize,
        ),
      );

  Column _title() => Column(
        children: [
          if (title == 'Beautiful')
            const Text(
              'Make Home',
              style: kFirstTitleTextStyle,
            ),
          Text(
            title.toUpperCase(),
            style: kSecondTitleTextStyle,
          ),
        ],
      );

  List<Widget> _actions() => [
        IconButton(
          onPressed: onActionIconPressed,
          icon: Icon(
            actionIcon,
            size: kIconSize,
          ),
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
