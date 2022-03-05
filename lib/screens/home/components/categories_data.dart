import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesData extends StatefulWidget {
  CategoriesData({
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

  Future getCategoriesStreamSnapShot() async {
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
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

  IconButton _favButton(int index, BuildContext context) => IconButton(
        onPressed: () async {
          try {
            await _databaseService.addToFavourites(
                Categories(
                  name: _categoryList[index]['name'],
                  url: _categoryList[index]['url'],
                  desc: _categoryList[index]['desc'],
                  star: _categoryList[index]['star'].toString(),
                  category: _categoryList[index]['category'],
                  price: _categoryList[index]['price'].toString(),
                  itemCount: 1,
                ),
                widget.scaffoldKey);
            Scaffold.of(context).showSnackBar(showSnackBar(
                content:
                    "${_categoryList[index]['name']} added to favourites !"));
          } catch (e) {
            Scaffold.of(context)
                .showSnackBar(showSnackBar(content: e.toString()));
          }
        },
        icon: const Icon(
          CupertinoIcons.heart,
          size: 22,
        ),
      );

  Text _priceText(int index) => Text(
        '\$ ${_categoryList[index]['price']}',
        style: kViewSubTitleStyle,
      );

  Text _nameText(int index) => Text(
        _categoryList[index]['name'],
        style: kViewTitleStyle,
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
                    name: _categoryList[index]['name'],
                    url: _categoryList[index]['url'],
                    desc: _categoryList[index]['desc'],
                    star: _categoryList[index]['star'].toString(),
                    category: _categoryList[index]['category'],
                    price: _categoryList[index]['price'].toString(),
                    itemCount: 1,
                  ),
                  widget.scaffoldKey);
              Scaffold.of(context).showSnackBar(showSnackBar(
                  content: "${_categoryList[index]['name']} added to cart !"));
            } catch (e) {
              Scaffold.of(context)
                  .showSnackBar(showSnackBar(content: e.toString()));
            }
          },
          color: Colors.black38,
          iconColor: Colors.white,
        ),
      );

  ClipRRect _image(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          _categoryList[index]['url'],
          fit: BoxFit.fill,
          width: double.maxFinite,
        ),
      );
}
