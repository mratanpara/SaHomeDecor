import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_bottom_navigation_bar.dart';
import 'package:decor/constants.dart';
import 'package:decor/models/bottom_nav_bar_index.dart';
import 'package:decor/screens/favorite/favorite_screen.dart';
import 'package:decor/screens/home/home_screen.dart';
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
    const FavoriteScreen(),
    const Center(child: Text('notification')),
    const Center(child: Text('account')),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _widgetOptions
          .elementAt(Provider.of<BottomNavBarIndex>(context).selectedIndex),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
