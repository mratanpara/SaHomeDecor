import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_progress_indicator.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _databaseService = DatabaseService();
  List _categoryList = [];

  Future getCategoriesStreamSnapShot() async {
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
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(_categoryList[index])));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        _categoryList[index]['url'],
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                      ),
                    ),
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: CustomRectButton(
                        width: 42,
                        height: 42,
                        icon: CupertinoIcons.cart_fill,
                        onPressed: () async {
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
                          );
                          Scaffold.of(context).showSnackBar(showSnackBar(
                              content:
                                  "${_categoryList[index]['name']} added to cart !"));
                        },
                        color: Colors.black38,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      _categoryList[index]['name'],
                      style: kViewTitleStyle,
                    ),
                    subtitle: Text(
                      '\$ ${_categoryList[index]['price']}',
                      style: kViewSubTitleStyle,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
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
                      },
                      icon: const Icon(
                        CupertinoIcons.heart,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
