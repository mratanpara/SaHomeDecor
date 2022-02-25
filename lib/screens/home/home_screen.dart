import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants.dart';
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
      appBar: CustomAppBar(
        title: 'Beautiful',
        actionIcon: CupertinoIcons.cart,
        leadingIcon: CupertinoIcons.search,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.02),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              _categoryTabs(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisExtent: size.height * 0.40,
                  ),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/category/simple-desk.png',
                            fit: BoxFit.cover,
                            height: size.height * 0.3,
                            width: size.width * 0.47,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          minVerticalPadding: size.width * 0.01,
                          dense: true,
                          title: const Text(
                            'Bed',
                            style: kGridViewTitleStyle,
                          ),
                          subtitle: const Text(
                            '\$ 12.00',
                            style: kGridViewSubTitleStyle,
                          ),
                          trailing: const IconButton(
                            onPressed: null,
                            icon: Icon(
                              CupertinoIcons.bag,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
