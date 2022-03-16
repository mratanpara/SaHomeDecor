import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_bottom_navigation_bar.dart';
import '../../providers/navigation_provider.dart';
import '../favourite/favourite_screen.dart';
import '../home/screens/home_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/screens/profile_screen.dart';

class DashBoard extends StatelessWidget {
  static const String id = 'dashboard';
  const DashBoard({Key? key}) : super(key: key);

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    FavouriteScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions
          .elementAt(Provider.of<NavigationProvider>(context).getSelectedIndex),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
