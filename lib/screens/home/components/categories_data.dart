import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesData extends StatelessWidget {
  const CategoriesData({
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
          itemCount: data?.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(data![index])));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        data![index]['url'],
                        fit: BoxFit.fill,
                        // height: size.height * 0.3,
                        // width: size.width * 0.47,
                        // height: 200,
                        // width: 200,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      data[index]['name'],
                      style: kGridViewTitleStyle,
                    ),
                    subtitle: Text(
                      '\$ ${data[index]['price']}',
                      style: kGridViewSubTitleStyle,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.bag,
                        size: 22,
                      ),
                    ),
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
