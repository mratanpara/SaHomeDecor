import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _tabBar(),
          _orderDetails(size),
        ],
      ),
    );
  }

  Flexible _orderDetails(Size size) => Flexible(
        child: SizedBox(
          height: size.height,
          child: CommonRefreshIndicator(
            child: ListView.builder(
              physics: kPhysics,
              padding: kSymmetricPaddingHor,
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _orderDetailsListTile();
              },
            ),
          ),
        ),
      );

  Container _orderDetailsListTile() => Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _column(),
          ),
        ),
      );

  Column _column() => Column(
        children: [
          _orderNumberAndDate(),
          const Divider(),
          _orderQuantityAndTotalAmount(),
          _detailButtonAndStatus(),
        ],
      );

  Padding _detailButtonAndStatus() => Padding(
        padding: kSymmetricPaddingVer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _detailsButton(),
            _deliveryStatus(),
          ],
        ),
      );

  Expanded _deliveryStatus() => const Expanded(
        child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: kSymmetricPaddingHor,
              child: Text(
                'Delivered',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            )),
        flex: 2,
      );

  Expanded _detailsButton() => Expanded(
        child: CustomButton(label: 'Details', onPressed: () {}),
        flex: 1,
      );

  Padding _orderQuantityAndTotalAmount() => Padding(
        padding: kAllPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRichText('Quantity:', '03'),
            _buildRichText('Total Amount:', '\$150'),
          ],
        ),
      );

  Padding _orderNumberAndDate() => Padding(
        padding: kAllPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Order No. 1234',
              style: kOrderBoldTextStyle,
            ),
            Text(
              '23/03/2001',
              style: kOrderTextStyle,
            ),
          ],
        ),
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
            text: 'Canceled',
          ),
        ],
      );

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'My Order',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  RichText _buildRichText(String firstText, String secondText) => RichText(
        text: TextSpan(
          text: '$firstText ',
          style: kOrderTextStyle,
          children: <TextSpan>[
            TextSpan(
              text: secondText,
              style: kOrderBoldTextStyle,
            ),
          ],
        ),
      );
}
