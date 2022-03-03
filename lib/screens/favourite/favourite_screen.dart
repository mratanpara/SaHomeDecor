import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:decor/services/database_services.dart';
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
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Favourites',
        actionIcon: CupertinoIcons.cart,
        onActionIconPressed: () {
          Navigator.pushNamed(context, CartScreen.id);
        },
        onLeadingIconPressed: () {},
      ),
      body: CommonRefreshIndicator(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .collection('favourites')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomProgressIndicator();
            }

            final data = snapshot.data!.docs;
            allData = snapshot.data!.docs;

            return Stack(
              children: [
                ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: kSymmetricPaddingHor,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(data[index])));
                      },
                      child: Row(
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
                                          .deleteFromFavourite(data[index].id);
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
                                  padding: const EdgeInsets.all(20),
                                  child: IconButton(
                                    onPressed: () async {
                                      await _databaseService.addToCart(
                                          Categories(
                                            name: data[index]['name'],
                                            url: data[index]['url'],
                                            desc: data[index]['desc'],
                                            star:
                                                data[index]['star'].toString(),
                                            category: data[index]['category'],
                                            price:
                                                data[index]['price'].toString(),
                                            itemCount: 1,
                                          ),
                                          data[index]);
                                      Scaffold.of(context).showSnackBar(
                                          showSnackBar(
                                              content:
                                                  "${data[index]['name']} added to cart !"));
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.cart_fill,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
                Positioned(
                  width: size.width,
                  // height: 50,
                  bottom: 1,
                  child: Padding(
                    padding: kSymmetricPaddingHor,
                    child: CustomButton(
                      label: 'Add all to my cart',
                      onPressed: () {
                        for (int index = 0; index < allData.length; index++) {
                          _databaseService.addToCart(
                              Categories(
                                name: allData[index]['name'],
                                url: allData[index]['url'],
                                desc: allData[index]['desc'],
                                star: allData[index]['star'].toString(),
                                category: allData[index]['category'],
                                price: allData[index]['price'].toString(),
                                itemCount: 1,
                              ),
                              allData[index]);
                        }
                        _scaffoldKey.currentState!.showSnackBar(showSnackBar(
                            content: 'Add item\'s added into a cart !'));
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
