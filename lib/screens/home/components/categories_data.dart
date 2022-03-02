import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesData extends StatelessWidget {
  final _databaseService = DatabaseService();
  CategoriesData({
    Key? key,
    required this.size,
    required this.collection,
  }) : super(key: key);

  final Size size;
  final String collection;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('categories')
          .doc('products')
          .collection(collection)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomProgressIndicator();
        }

        final data = snapshot.data?.docs;
        return GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: size.height * 0.35,
          ),
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(data[index])));
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
                            data[index]['url'],
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
                              await _databaseService.addToCart(Categories(
                                name: data[index]['name'],
                                url: data[index]['url'],
                                desc: data[index]['desc'],
                                star: data[index]['star'].toString(),
                                category: data[index]['category'],
                                price: data[index]['price'].toString(),
                              ));
                              Scaffold.of(context).showSnackBar(showSnackBar(
                                  content:
                                      "${data[index]['name']} added to cart !"));
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
                          data[index]['name'],
                          style: kViewTitleStyle,
                        ),
                        subtitle: Text(
                          '\$ ${data[index]['price']}',
                          style: kViewSubTitleStyle,
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await _databaseService.addToFavourites(Categories(
                              name: data[index]['name'],
                              url: data[index]['url'],
                              desc: data[index]['desc'],
                              star: data[index]['star'].toString(),
                              category: data[index]['category'],
                              price: data[index]['price'].toString(),
                            ));
                            Scaffold.of(context).showSnackBar(showSnackBar(
                                content:
                                    "${data[index]['name']} added to favourites !"));
                          },
                          icon: const Icon(
                            CupertinoIcons.bag_fill,
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
      },
    );
  }
}
