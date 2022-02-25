import 'package:decor/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('home')),
    const Center(child: Text('bookmark')),
    const Center(child: Text('notification')),
    const Center(child: Text('account')),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          onPressed: null,
          icon: Icon(
            CupertinoIcons.search,
            size: kIconSize,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Make home',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Text(
              'Beautiful'.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              CupertinoIcons.cart,
              size: kIconSize,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Image.asset(
                'assets/icons/chair.png',
                width: 44,
                height: 44,
              ),
              text: 'Chair',
            ),
            Tab(
              icon: Image.asset(
                'assets/icons/table.png',
                width: 44,
                height: 44,
              ),
              text: 'Table',
            ),
            Tab(
              icon: Image.asset(
                'assets/icons/bed.png',
                width: 44,
                height: 44,
              ),
              text: 'Bed',
            ),
            Tab(
              icon: Image.asset(
                'assets/icons/sofa.png',
                width: 44,
                height: 44,
              ),
              text: 'Sofa',
            ),
            Tab(
              icon: Image.asset(
                'assets/icons/armchair.png',
                width: 44,
                height: 44,
              ),
              text: 'Armchair',
            ),
          ],
        ),
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        elevation: 0,
        iconSize: kIconSize,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
