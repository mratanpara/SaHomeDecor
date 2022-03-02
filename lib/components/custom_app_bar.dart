import 'package:decor/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onLeadingIconPressed;
  final VoidCallback? onActionIconPressed;

  CustomAppBar({
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

  List<Widget> _actions() => [
        IconButton(
          onPressed: onActionIconPressed,
          icon: Icon(
            actionIcon,
            size: kIconSize,
            color: Colors.grey,
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
        onPressed: onLeadingIconPressed,
        icon: Icon(
          leadingIcon,
          size: kIconSize,
          color: Colors.grey,
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
