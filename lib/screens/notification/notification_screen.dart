import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = 'notification_screen';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Notification',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () {},
      ),
      body: CommonRefreshIndicator(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: kSymmetricPaddingHor,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/black-simple-lamp.png',
                    fit: BoxFit.cover,
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                  ),
                ),
                const Flexible(
                  child: ListTile(
                    dense: true,
                    title: Padding(
                      padding: kBottomPadding,
                      child: Text(
                        'Your order #123456789 has been shipped successfully',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: kNormalFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      'Please help us to confirm and rate your order to get 10% discount code for next order.',
                      style: TextStyle(
                        fontSize: kNormalFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
