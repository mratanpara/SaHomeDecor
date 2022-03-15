import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/components/no_data_found.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/components/refresh_indicator.dart';
import 'package:decor/constants/params_constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:decor/screens/search_screen/search_screen.dart';
import 'package:decor/services/database_services.dart';
import 'package:decor/utils/methods/reusable_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  static const String id = 'favorite_screen';

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic allData;

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
        leadingIcon: CupertinoIcons.search,
        title: 'Favourites',
        actionIcon: CupertinoIcons.cart,
        onActionIconPressed: () {
          Navigator.pushNamed(context, CartScreen.id);
        },
        onLeadingIconPressed: () =>
            Navigator.pushNamed(context, SearchScreen.id),
      );

  CommonRefreshIndicator _body(Size size) => CommonRefreshIndicator(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .collection('favourites')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const CustomProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressIndicator();
            }

            final data = snapshot.data!.docs;
            allData = snapshot.data!.docs;

            return data.isNotEmpty
                ? Stack(
                    children: [
                      _favItemListView(data),
                      _addAllToFavButton(size),
                    ],
                  )
                : NoDataFound();
          },
        ),
      );

  ListView _favItemListView(List<QueryDocumentSnapshot<Object?>> data) =>
      ListView.separated(
        physics: kPhysics,
        padding: kSymmetricPaddingHor,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            background: _deleteSwipeBackground(),
            secondaryBackground: _cartSwipeBackground(),
            onDismissed: (direction) async {
              try {
                if (direction == DismissDirection.endToStart) {
                  await _databaseService.addToCart(
                    Categories(
                      name: data[index][paramName],
                      url: data[index][paramUrl],
                      desc: data[index][paramDesc],
                      star: data[index][paramStar].toString(),
                      category: data[index][paramCategory],
                      price: data[index][paramPrice].toString(),
                      itemCount: 1,
                    ),
                    _scaffoldKey,
                  );
                  await _databaseService.deleteFromFavourite(
                      data[index].id, _scaffoldKey);
                } else {
                  await _databaseService.deleteFromFavourite(
                      data[index].id, _scaffoldKey);
                  _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                      content: '${data[index][paramName]} deleted !'));
                }
              } catch (e) {
                if (direction == DismissDirection.endToStart) {
                  _scaffoldKey.currentState!.showSnackBar(
                      showSnackBar(content: "Failed to add into cart!"));
                } else {
                  _scaffoldKey.currentState!.showSnackBar(
                      showSnackBar(content: "Failed to delete !"));
                }
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
              child: _customFavListItem(data, index, context),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );

  Container _deleteSwipeBackground() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: kSwipeToDeleteDecoration,
        alignment: Alignment.centerLeft,
        child: const Icon(
          CupertinoIcons.trash_fill,
          color: Colors.white,
          size: kIconSize,
        ),
      );

  Container _cartSwipeBackground() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        decoration: kSwipeToAddDecoration,
        child: const Icon(
          CupertinoIcons.cart_fill,
          color: Colors.white,
          size: kIconSize,
        ),
      );

  Row _customFavListItem(List<QueryDocumentSnapshot<Object?>> data, int index,
          BuildContext context) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(data, index),
          _favItemDetails(data, index, context),
        ],
      );

  ClipRRect _image(List<QueryDocumentSnapshot<Object?>> data, int index) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          data[index][paramUrl],
          fit: BoxFit.cover,
          height: 110,
          width: 110,
        ),
      );

  Flexible _favItemDetails(List<QueryDocumentSnapshot<Object?>> data, int index,
          BuildContext context) =>
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _nameListTile(data, index),
            _addToCartIconButton(data, index, context),
          ],
        ),
      );

  ListTile _nameListTile(
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
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
              await _databaseService.deleteFromFavourite(
                  data[index].id, _scaffoldKey);
              _scaffoldKey.currentState!.showSnackBar(
                  showSnackBar(content: "${data[index][paramName]} deleted."));
            } catch (e) {
              _scaffoldKey.currentState!
                  .showSnackBar(showSnackBar(content: "Failed to delete!"));
            }
          },
          icon: const Icon(
            CupertinoIcons.clear_circled,
            size: 28,
          ),
        ),
      );

  Padding _addToCartIconButton(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      Padding(
        padding: kSymmetricPaddingHor,
        child: IconButton(
          onPressed: () async {
            try {
              await _databaseService.addToCart(
                Categories(
                  name: data[index][paramName],
                  url: data[index][paramUrl],
                  desc: data[index][paramDesc],
                  star: data[index][paramStar].toString(),
                  category: data[index][paramCategory],
                  price: data[index][paramPrice].toString(),
                  itemCount: 1,
                ),
                _scaffoldKey,
              );
              await _databaseService.deleteFromFavourite(
                  data[index].id, _scaffoldKey);
            } catch (e) {
              _scaffoldKey.currentState!.showSnackBar(
                  showSnackBar(content: "Failed to add into cart!"));
            }
          },
          icon: const Icon(
            CupertinoIcons.cart,
            size: 28,
            color: Colors.grey,
          ),
        ),
      );

  Positioned _addAllToFavButton(Size size) => Positioned(
        width: size.width,
        bottom: 1,
        child: Padding(
          padding: kSymmetricPaddingHor,
          child: CustomButton(
            label: 'Add all to my cart',
            onPressed: () {
              for (int index = 0; index < allData.length; index++) {
                _databaseService.addToCart(
                  Categories(
                    name: allData[index][paramName],
                    url: allData[index][paramUrl],
                    desc: allData[index][paramDesc],
                    star: allData[index][paramStar].toString(),
                    category: allData[index][paramCategory],
                    price: allData[index][paramPrice].toString(),
                    itemCount: 1,
                  ),
                  _scaffoldKey,
                );
                _databaseService.deleteFromFavourite(
                    allData[index].id, _scaffoldKey);
              }
            },
          ),
        ),
      );
}
