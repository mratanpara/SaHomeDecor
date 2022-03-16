import '../../../../components/custom_app_bar.dart';
import '../../../../constants/constants.dart';
import 'screens/cancelled_orders_screen.dart';
import 'screens/delivered_orders_screen.dart';
import 'screens/processing_orders_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'order_screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _tabBar(),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              physics: kPhysics,
              children: const [
                DeliveredOrders(),
                ProcessingOrders(),
                CancelledOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'My Order',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  TabBar _tabBar() => TabBar(
        labelColor: Colors.black,
        labelStyle: kOrderTabTextStyle,
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 6),
            insets: EdgeInsets.symmetric(horizontal: 50.0)),
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            text: 'Delivered',
          ),
          Tab(
            text: 'Processing',
          ),
          Tab(
            text: 'Cancelled',
          ),
        ],
      );
}
