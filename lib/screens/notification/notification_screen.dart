import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/screens/search_screen/search_screen.dart';
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
      appBar: _appBar(context),
      body: CommonRefreshIndicator(
        child: ListView.separated(
          physics: kPhysics,
          padding: kSymmetricPaddingHor,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return _customListTile(size);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  Row _customListTile(Size size) => Row(
        children: [
          _image(size),
          _orderDetails(),
        ],
      );

  Flexible _orderDetails() => Flexible(
        child: ListTile(
          dense: true,
          title: _orderTitle(),
          subtitle: _orderMsg(),
        ),
      );

  Text _orderMsg() => const Text(
        'Please help us to confirm and rate your order to get 10% discount code for next order.',
        style: TextStyle(
          fontSize: kNormalFontSize,
          color: Colors.black,
        ),
      );

  Padding _orderTitle() => const Padding(
        padding: kBottomPadding,
        child: Text(
          'Your order #123456789 has been shipped successfully',
          style: TextStyle(
            color: Colors.black,
            fontSize: kNormalFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  ClipRRect _image(Size size) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/black-simple-lamp.png',
          fit: BoxFit.cover,
          height: size.height * 0.15,
          width: size.width * 0.3,
        ),
      );

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Notification',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () =>
            Navigator.pushNamed(context, SearchScreen.id),
      );
}
