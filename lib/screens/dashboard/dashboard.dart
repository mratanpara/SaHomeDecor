import 'package:decor/components/custom_bottom_navigation_bar.dart';
import 'package:decor/providers/common_provider.dart';
import 'package:decor/screens/favourite/favourite_screen.dart';
import 'package:decor/screens/home/screens/home_screen.dart';
import 'package:decor/screens/notification/notification_screen.dart';
import 'package:decor/screens/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  static const String id = 'dashboard';
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const FavouriteScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions
          .elementAt(Provider.of<CommonProvider>(context).getSelectedIndex),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
