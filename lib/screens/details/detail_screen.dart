import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const String id = 'detail_screen';

  DetailScreen(this.data);

  final dynamic data;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.01),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(80)),
                      child: Image.asset(
                        widget.data['url'],
                        fit: BoxFit.fill,
                        height: size.height * 0.65,
                        width: size.width * 0.85,
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.1,
                    top: size.height * 0.09,
                    child: SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: CustomRectButton(
                        width: 56,
                        height: 56,
                        icon: CupertinoIcons.back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                        iconColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.01,
              ),
              child: Text(
                widget.data['name'],
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${widget.data['price'].toString()}',
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRectButton(
                        width: 48,
                        height: 48,
                        icon: CupertinoIcons.plus,
                        onPressed: () {},
                        color: Colors.white,
                        iconColor: Colors.black,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: const Text(
                          '02',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kNormalFontSize,
                          ),
                        ),
                      ),
                      CustomRectButton(
                        width: 48,
                        height: 48,
                        icon: CupertinoIcons.minus,
                        onPressed: () {},
                        color: Colors.white,
                        iconColor: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.005,
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.yellow,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    child: Text(
                      widget.data['star'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: kNormalFontSize,
                      ),
                    ),
                  ),
                  const Text(
                    '(50 Reviews)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.01,
              ),
              child: Text(
                widget.data['desc'],
                style: TextStyle(
                  fontSize: kNormalFontSize,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomRectButton(
                width: 58,
                height: 58,
                icon: CupertinoIcons.bookmark,
                onPressed: () async {
                  await _databaseService.addToFavourites(Categories(
                      name: widget.data['name'],
                      url: widget.data['url'],
                      desc: widget.data['desc'],
                      star: widget.data['star'].toString(),
                      category: widget.data['category'],
                      price: widget.data['price'].toString()));
                  _scaffoldKey.currentState!.showSnackBar(showSnackBar(
                      content: "${widget.data['name']} added to favourites !"));
                },
                color: Colors.white,
                iconColor: Colors.black,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              flex: 6,
              child: CustomButton(
                label: 'Add to cart',
                onPressed: () async {
                  await _databaseService.addToCart(Categories(
                    name: widget.data['name'],
                    url: widget.data['url'],
                    desc: widget.data['desc'],
                    star: widget.data['star'].toString(),
                    category: widget.data['category'],
                    price: widget.data['price'].toString(),
                  ));
                  _scaffoldKey.currentState!.showSnackBar(showSnackBar(
                      content: "${widget.data['name']} added to cart !"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
