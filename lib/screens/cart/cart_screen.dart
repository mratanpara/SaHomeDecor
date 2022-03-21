// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/customExtension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_progress_indicator.dart';
import '../../components/custom_rect_button.dart';
import '../../components/no_data_found.dart';
import '../../components/refresh_indicator.dart';
import '../../constants/constants.dart';
import '../../constants/params_constants.dart';
import '../../providers/amount_provider.dart';
import '../../services/database_services.dart';
import '../../utils/methods/get_total_amount.dart';
import '../../utils/methods/reusable_methods.dart';
import '../success/success_screen.dart';
import '../details/detail_screen.dart';

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
    getTotalAmount(context, _scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: _body(size),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        leadingIcon: CupertinoIcons.back,
        title: 'Cart',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
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
            return data!.isEmpty
                ? const NoDataFound()
                : Stack(
                    children: [
                      _cartLists(data, size).padTop(),
                      _totalAmountAndCheckOutButton(size, context),
                    ],
                  );
          },
        ),
      );

  ListView _cartLists(List<QueryDocumentSnapshot<Object?>> data, Size size) {
    return ListView.separated(
      physics: kPhysics,
      padding: kSymmetricPaddingHor,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            decoration: kSwipeToDeleteDecoration,
            padding: kSymmetricPaddingHor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _trashIcon(),
                _trashIcon(),
              ],
            ),
          ),
          onDismissed: (direction) async {
            try {
              await _databaseService.deleteFromCart(
                  data[index].id, _scaffoldKey);
              await getTotalAmount(context, _scaffoldKey);
              _scaffoldKey.currentState!.showSnackBar(
                  showSnackBar(content: "${data[index]['name']} deleted !"));
            } catch (e) {
              _scaffoldKey.currentState
                  ?.showSnackBar(showSnackBar(content: 'Failed to delete!'));
            }
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(data[index]),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(data, index),
                _showData(data, index, context, size),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Icon _trashIcon() => const Icon(
        CupertinoIcons.trash_fill,
        color: Colors.white,
        size: kIconSize,
      );

  Hero _image(List<QueryDocumentSnapshot<Object?>> data, int index) => Hero(
        tag: data[index][paramUrl],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            data[index][paramUrl],
            fit: BoxFit.cover,
            height: 110,
            width: 110,
          ),
        ),
      );

  Flexible _showData(List<QueryDocumentSnapshot<Object?>> data, int index,
          BuildContext context, Size size) =>
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _categoryListTile(data, index, context),
            _incrementDecrementQuantity(data, index, context, size),
          ],
        ),
      );

  ListTile _categoryListTile(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      ListTile(
        dense: true,
        title: Text(
          data[index][paramName],
          style: kViewTitleStyle,
        ),
        subtitle: Text(
          '\$ ${data[index][paramPrice]}',
          style: kViewSubTitleStyle,
        ),
        trailing: IconButton(
          onPressed: () async {
            try {
              await _databaseService.deleteFromCart(
                  data[index].id, _scaffoldKey);
              await getTotalAmount(context, _scaffoldKey);
              _scaffoldKey.currentState!.showSnackBar(
                  showSnackBar(content: "${data[index][paramName]} deleted !"));
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          icon: const Icon(
            CupertinoIcons.clear_circled,
            size: 28,
          ),
        ),
      );

  Padding _incrementDecrementQuantity(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context, Size size) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _incrementButton(data, index, context),
            _quantityText(size, data, index),
            _decrementButton(data, index, context),
          ],
        ),
      );

  CustomRectButton _incrementButton(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      CustomRectButton(
        width: 38,
        height: 38,
        icon: CupertinoIcons.plus,
        onPressed: () async {
          try {
            await _databaseService.increaseItemCount(
                data[index].id, data[index][paramItemCount]);
            getTotalAmount(context, _scaffoldKey);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        color: Colors.white,
        iconColor: Colors.black,
      );

  Padding _quantityText(
          Size size, List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Text(
          data[index][paramItemCount].toString(),
          style: const TextStyle(
            fontSize: kNormalFontSize,
          ),
        ),
      );

  CustomRectButton _decrementButton(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      CustomRectButton(
        width: 38,
        height: 38,
        icon: CupertinoIcons.minus,
        onPressed: () async {
          try {
            await _databaseService.decreaseItemCount(
                data[index].id, data[index][paramItemCount], _scaffoldKey);
            getTotalAmount(context, _scaffoldKey);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        color: Colors.white,
        iconColor: Colors.black,
      );

  Positioned _totalAmountAndCheckOutButton(Size size, BuildContext context) =>
      Positioned(
        width: size.width,
        bottom: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _totalAmountText(size, context),
              _checkOutButton(context),
            ],
          ),
        ),
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
              '\$ ${Provider.of<AmountProvider>(context).getTotalAmount}',
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      );

  CustomButton _checkOutButton(BuildContext context) => CustomButton(
        label: 'Check out',
        onPressed: () {
          Navigator.pushReplacementNamed(context, SuccessScreen.id);
        },
      );
}
