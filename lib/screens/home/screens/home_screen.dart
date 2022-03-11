import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:decor/screens/home/components/all_categories_data.dart';
import 'package:decor/screens/home/components/categories_data.dart';
import 'package:decor/screens/search_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.02),
        child: _homeScreenData(size),
      ),
    );
  }

  Column _homeScreenData(Size size) => Column(
        children: [
          _categoryTabs(),
          _categoryTabsAndData(size),
        ],
      );

  Flexible _categoryTabsAndData(Size size) => Flexible(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
            child: TabBarView(
              controller: _tabController,
              children: [
                // _getAllCategories(size),
                GetAllCategoriesData(size: size, scaffoldKey: _scaffoldKey),
                CategoriesData(
                    size: size,
                    collection: 'chairs',
                    scaffoldKey: _scaffoldKey),
                CategoriesData(
                    size: size, collection: 'sofas', scaffoldKey: _scaffoldKey),
                CategoriesData(
                    size: size, collection: 'beds', scaffoldKey: _scaffoldKey),
                CategoriesData(
                    size: size,
                    collection: 'armchairs',
                    scaffoldKey: _scaffoldKey),
              ],
            ),
          ),
        ),
      );

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Beautiful',
        actionIcon: CupertinoIcons.cart,
        leadingIcon: CupertinoIcons.search,
        onActionIconPressed: () {
          Navigator.pushNamed(context, CartScreen.id);
        },
        onLeadingIconPressed: () =>
            Navigator.pushNamed(context, SearchScreen.id),
      );

  TabBar _categoryTabs() => TabBar(
        indicator: kTabIndicatorDecoration,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            icon: Icon(Icons.home, size: kIconSize),
            text: 'See All',
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.chair, size: kIconSize),
            text: 'Chair',
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.couch, size: kIconSize),
            text: 'Sofa',
          ),
          Tab(
            icon: Icon(Icons.bed, size: kIconSize),
            text: 'Bed',
          ),
          Tab(
            icon: Icon(Icons.chair, size: kIconSize),
            text: 'Armchair',
          ),
        ],
      );
}
