import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/get_counts_data.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/providers/common_provider.dart';
import 'package:decor/screens/success/success_screen.dart';
import 'package:decor/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getTotalAmount(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.back,
        title: 'Cart',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: CommonRefreshIndicator(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .collection('cart')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressIndicator();
            }

            final data = snapshot.data?.docs;
            return ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: kSymmetricPaddingHor,
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        data[index]['url'],
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            contentPadding: kAllPadding,
                            dense: true,
                            title: Text(
                              data[index]['name'],
                              style: kViewTitleStyle,
                            ),
                            subtitle: Text(
                              '\$ ${data[index]['price']}',
                              style: kViewSubTitleStyle,
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await _databaseService
                                    .deleteFromCart(data[index].id);
                                await getTotalAmount(context);
                                _scaffoldKey.currentState!.showSnackBar(
                                    showSnackBar(
                                        content:
                                            "${data[index]['name']} deleted !"));
                              },
                              icon: const Icon(
                                CupertinoIcons.clear_circled,
                                size: 28,
                              ),
                            ),
                          ),
                          Padding(
                            padding: kAllPadding,
                            child: Row(
                              children: [
                                CustomRectButton(
                                  width: 48,
                                  height: 48,
                                  icon: CupertinoIcons.plus,
                                  onPressed: () {},
                                  color: Colors.white,
                                  iconColor: Colors.black,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                  child: const Text(
                                    '01',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: kNormalFontSize,
                                    ),
                                  ),
                                ),
                                CustomRectButton(
                                  width: 48,
                                  height: 48,
                                  icon: CupertinoIcons.minus,
                                  onPressed: () {},
                                  color: Colors.white,
                                  iconColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: kBoxShadow,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.01),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Enter your promo code',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomRectButton(
                        width: 56,
                        height: 56,
                        icon: CupertinoIcons.forward,
                        onPressed: () {},
                        color: Colors.black,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(color: Colors.grey, fontSize: 22),
                  ),
                  Text(
                    '\$ ${Provider.of<CommonProvider>(context).totalAmount}',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            CustomButton(
              label: 'Check out',
              onPressed: () {
                Navigator.pushNamed(context, SuccessScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
