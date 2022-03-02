import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_bottom_navigation_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/providers/bottom_nav_bar_index.dart';
import 'package:decor/screens/auth/login/screen/login_screen.dart';
import 'package:decor/screens/favourite/favourite_screen.dart';
import 'package:decor/screens/home/home_screen.dart';
import 'package:decor/screens/notification/notification_screen.dart';
import 'package:decor/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          .elementAt(Provider.of<BottomNavBarIndex>(context).selectedIndex),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
