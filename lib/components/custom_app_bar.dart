import 'package:decor/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final String title;
  final IconData actionIcon;

  CustomAppBar(
      {required this.title,
      required this.actionIcon,
      required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _leadingIcon(),
      centerTitle: true,
      title: _title(),
      actions: _actions(),
    );
  }

  List<Widget> _actions() => [
        IconButton(
          onPressed: null,
          icon: Icon(
            actionIcon,
            size: kIconSize,
          ),
        ),
      ];

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

  IconButton _leadingIcon() => IconButton(
        onPressed: null,
        icon: Icon(
          leadingIcon,
          size: kIconSize,
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
