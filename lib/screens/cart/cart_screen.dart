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
      appBar: _appBar(context),
      body: _body(size),
      bottomNavigationBar: _bottomNavigationBar(size, context),
    );
  }

  Padding _bottomNavigationBar(Size size, BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _promoCodeTextField(size),
            _totalAmountText(size, context),
            _checkOutButton(context),
          ],
        ),
      );

  CustomButton _checkOutButton(BuildContext context) => CustomButton(
        label: 'Check out',
        onPressed: () {
          Navigator.pushNamed(context, SuccessScreen.id);
        },
      );

  Padding _totalAmountText(Size size, BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(color: Colors.grey, fontSize: 22),
            ),
            Text(
              '\$ ${Provider.of<CommonProvider>(context).getTotalAmount}',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      );

  Container _promoCodeTextField(Size size) => Container(
        decoration: kBoxShadow,
        child: Card(
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textField(size),
              _promoCodeButton(),
            ],
          ),
        ),
      );

  Expanded _promoCodeButton() => Expanded(
        child: CustomRectButton(
          width: 56,
          height: 56,
          icon: CupertinoIcons.forward,
          onPressed: () {},
          color: Colors.black,
          iconColor: Colors.white,
        ),
      );

  Expanded _textField(Size size) => Expanded(
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
      );

  CommonRefreshIndicator _body(Size size) => CommonRefreshIndicator(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .collection('cart')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressIndicator();
            }

            final data = snapshot.data?.docs;
            return ListView.separated(
              physics: kPhysics,
              padding: kSymmetricPaddingHor,
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    _image(data, index),
                    _showData(data, index, context, size),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          },
        ),
      );

  Flexible _showData(List<QueryDocumentSnapshot<Object?>> data, int index,
          BuildContext context, Size size) =>
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _categoryListTile(data, index, context),
            _incrementDecrementQuantity(data, index, context, size),
          ],
        ),
      );

  Padding _incrementDecrementQuantity(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context, Size size) =>
      Padding(
        padding: kAllPadding,
        child: Row(
          children: [
            _incrementButton(data, index, context),
            _quantityText(size, data, index),
            _decrementButton(data, index, context),
          ],
        ),
      );

  Padding _quantityText(
          Size size, List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Text(
          data[index]['itemCount'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: kNormalFontSize,
          ),
        ),
      );

  CustomRectButton _decrementButton(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      CustomRectButton(
        width: 48,
        height: 48,
        icon: CupertinoIcons.minus,
        onPressed: () async {
          await _databaseService.decreaseItemCount(
              data[index].id, data[index]['itemCount']);
          getTotalAmount(context);
        },
        color: Colors.white,
        iconColor: Colors.black,
      );

  CustomRectButton _incrementButton(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      CustomRectButton(
        width: 48,
        height: 48,
        icon: CupertinoIcons.plus,
        onPressed: () async {
          await _databaseService.increaseItemCount(
              data[index].id, data[index]['itemCount']);
          getTotalAmount(context);
        },
        color: Colors.white,
        iconColor: Colors.black,
      );

  ListTile _categoryListTile(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
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
            await _databaseService.deleteFromCart(data[index].id);
            await getTotalAmount(context);
            _scaffoldKey.currentState!.showSnackBar(
                showSnackBar(content: "${data[index]['name']} deleted !"));
          },
          icon: const Icon(
            CupertinoIcons.clear_circled,
            size: 28,
          ),
        ),
      );

  ClipRRect _image(List<QueryDocumentSnapshot<Object?>> data, int index) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          data[index]['url'],
          fit: BoxFit.cover,
          height: 150,
          width: 150,
        ),
      );

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        leadingIcon: CupertinoIcons.back,
        title: 'Cart',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );
}
