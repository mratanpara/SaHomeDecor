import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/params_constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:decor/services/database_services.dart';
import 'package:decor/utils/methods/reusable_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesData extends StatefulWidget {
  const CategoriesData({
    Key? key,
    required this.size,
    required this.collection,
    required this.scaffoldKey,
  }) : super(key: key);

  final Size size;
  final String collection;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CategoriesData> createState() => _CategoriesDataState();
}

class _CategoriesDataState extends State<CategoriesData> {
  final _databaseService = DatabaseService();
  List _categoryList = [];
  bool isLoading = false;

  Future getCategoriesStreamSnapShot() async {
    setState(() {
      isLoading = true;
    });
    try {
      _categoryList.clear();
      var data = await FirebaseFirestore.instance
          .collection('categories')
          .doc('products')
          .collection(widget.collection)
          .get();
      setState(() {
        _categoryList += data.docs;
      });
      setState(() {
        isLoading = false;
      });
      return 'completed';
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _categoryList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCategoriesStreamSnapShot();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: getCategoriesStreamSnapShot,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : GridView.builder(
              shrinkWrap: true,
              physics: kPhysics,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: widget.size.height * 0.35,
              ),
              itemCount: _categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return _categoryItemView(context, index);
              },
            ),
    );
  }

  GestureDetector _categoryItemView(BuildContext context, int index) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(_categoryList[index])));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _categoryImageAndCartButton(index, context),
            _categoryDetailsAndFavouriteButton(index, context),
          ],
        ),
      );

  Flexible _categoryImageAndCartButton(int index, BuildContext context) =>
      Flexible(
        child: Stack(
          children: [
            _image(index),
            _cartButton(index, context),
          ],
        ),
      );

  ClipRRect _image(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          _categoryList[index][paramUrl],
          fit: BoxFit.fill,
          width: double.maxFinite,
        ),
      );

  Positioned _cartButton(int index, BuildContext context) => Positioned(
        right: 4,
        bottom: 4,
        child: CustomRectButton(
          width: 42,
          height: 42,
          icon: CupertinoIcons.cart_fill,
          onPressed: () async {
            try {
              await _databaseService.addToCart(
                  Categories(
                    name: _categoryList[index][paramName],
                    url: _categoryList[index][paramUrl],
                    desc: _categoryList[index][paramDesc],
                    star: _categoryList[index][paramStar].toString(),
                    category: _categoryList[index][paramCategory],
                    price: _categoryList[index][paramPrice].toString(),
                    itemCount: 1,
                  ),
                  widget.scaffoldKey);
            } catch (e) {
              Scaffold.of(context)
                  .showSnackBar(showSnackBar(content: 'Failed to add!'));
            }
          },
          color: Colors.black38,
          iconColor: Colors.white,
        ),
      );

  Column _categoryDetailsAndFavouriteButton(int index, BuildContext context) =>
      Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: _nameText(index),
            subtitle: _priceText(index),
            trailing: _favButton(index, context),
          ),
        ],
      );

  Text _nameText(int index) => Text(
        _categoryList[index][paramName],
        style: kViewTitleStyle,
      );

  Text _priceText(int index) => Text(
        '\$ ${_categoryList[index][paramPrice]}',
        style: kViewSubTitleStyle,
      );

  IconButton _favButton(int index, BuildContext context) => IconButton(
        onPressed: () async {
          try {
            await _databaseService.addToFavourites(
                Categories(
                  name: _categoryList[index][paramName],
                  url: _categoryList[index][paramUrl],
                  desc: _categoryList[index][paramDesc],
                  star: _categoryList[index][paramStar].toString(),
                  category: _categoryList[index][paramCategory],
                  price: _categoryList[index][paramPrice].toString(),
                  itemCount: 1,
                ),
                widget.scaffoldKey);
          } catch (e) {
            Scaffold.of(context)
                .showSnackBar(showSnackBar(content: 'Failed to add!'));
          }
        },
        icon: const Icon(
          CupertinoIcons.heart,
          size: 22,
        ),
      );
}
