import '../constants/constants.dart';
import '../providers/navigation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, selectedIndex, child) {
        return BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _homeNavigationBarItem(),
            _favouritesNavigationBarItem(),
            _notificationNavigationBarItem(),
            _accountNavigationBarItem(),
          ],
          backgroundColor: Colors.white,
          elevation: 2,
          iconSize: kIconSize,
          showSelectedLabels: false,
          currentIndex: selectedIndex.getSelectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            selectedIndex.setUpdatedIndex(index);
          },
        );
      },
    );
  }

  BottomNavigationBarItem _homeNavigationBarItem() =>
      const BottomNavigationBarItem(
        activeIcon: Icon(CupertinoIcons.house_fill),
        icon: Icon(CupertinoIcons.house),
        label: 'Home',
      );

  BottomNavigationBarItem _favouritesNavigationBarItem() =>
      const BottomNavigationBarItem(
        activeIcon: Icon(CupertinoIcons.heart_fill),
        icon: Icon(CupertinoIcons.heart),
        label: 'Favourites',
      );

  BottomNavigationBarItem _notificationNavigationBarItem() =>
      const BottomNavigationBarItem(
        activeIcon: Icon(CupertinoIcons.bell_fill),
        icon: Icon(CupertinoIcons.bell),
        label: 'Notification',
      );

  BottomNavigationBarItem _accountNavigationBarItem() =>
      const BottomNavigationBarItem(
        activeIcon: Icon(CupertinoIcons.person_fill),
        icon: Icon(CupertinoIcons.person),
        label: 'Account',
      );
}
