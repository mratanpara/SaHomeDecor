import 'package:decor/constants/constants.dart';
import 'package:decor/providers/bottom_nav_bar_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarIndex>(
      builder: (context, selectedIndex, child) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.house_fill),
              icon: Icon(CupertinoIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.bookmark_fill),
              icon: Icon(CupertinoIcons.bookmark),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.bell_fill),
              icon: Icon(CupertinoIcons.bell),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.person_fill),
              icon: Icon(CupertinoIcons.person),
              label: 'Home',
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 2,
          iconSize: kIconSize,
          showSelectedLabels: false,
          currentIndex: selectedIndex.selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            selectedIndex.updateIndex(index);
          },
        );
      },
    );
  }
}
