import 'package:decor/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {required this.title, required this.subTitle, required this.onTap});

  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxShadow,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: onTap,
            title: Padding(
              padding: kBottomPadding,
              child: Text(
                title,
                style: kProfileTileTitleTextStyle,
              ),
            ),
            subtitle: Text(
              subTitle,
              style: kProfileTileSubTitleTextStyle,
            ),
            trailing: const Icon(CupertinoIcons.forward),
          ),
        ),
      ),
    );
  }
}