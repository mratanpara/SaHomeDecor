import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  static const String id = 'favorite_screen';
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Favourites',
        actionIcon: CupertinoIcons.cart,
        onActionIconPressed: () {
          Navigator.pushNamed(context, CartScreen.id);
        },
        onLeadingIconPressed: () {},
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: kSymmetricPaddingHor,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/category/armchair.jpg',
                  fit: BoxFit.cover,
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ListTile(
                      contentPadding: kAllPadding,
                      dense: true,
                      title: Text(
                        'Chair',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: kNormalFontSize,
                          letterSpacing: 2,
                        ),
                      ),
                      subtitle: Text(
                        '\$ 12.00',
                        style: TextStyle(
                          fontSize: kNormalFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: null,
                        icon: Icon(
                          CupertinoIcons.clear_circled,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.06),
                      child: const Icon(
                        CupertinoIcons.bag_fill,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      bottomNavigationBar: Padding(
        padding: kSymmetricPaddingHor,
        child: CustomButton(
          label: 'Add all to my cart',
          onPressed: () {},
        ),
      ),
    );
  }
}
