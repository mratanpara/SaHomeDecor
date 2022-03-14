import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const String id = 'detail_screen';

  const DetailScreen(this.data);

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
        child: _column(size, context),
      ),
      bottomNavigationBar: _bottomButtons(size),
    );
  }

  Padding _bottomButtons(Size size) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _favButton(),
            SizedBox(width: size.width * 0.025),
            _addToCartButton(),
          ],
        ),
      );

  Expanded _addToCartButton() => Expanded(
        flex: 6,
        child: CustomButton(
          label: 'Add to cart',
          onPressed: onAddToCartPressed,
        ),
      );

  Expanded _favButton() => Expanded(
        child: CustomRectButton(
          width: 58,
          height: 58,
          icon: CupertinoIcons.heart,
          onPressed: onFavPressed,
          color: Colors.white,
          iconColor: Colors.black,
        ),
      );

  void onFavPressed() async {
    try {
      await _databaseService.addToFavourites(
          Categories(
            name: widget.data['name'],
            url: widget.data['url'],
            desc: widget.data['desc'],
            star: widget.data['star'].toString(),
            category: widget.data['category'],
            price: widget.data['price'].toString(),
            itemCount: 1,
          ),
          _scaffoldKey);
    } catch (e) {
      _scaffoldKey.currentState!.showSnackBar(
          showSnackBar(content: "Failed to add into favourites!"));
    }
  }

  void onAddToCartPressed() async {
    try {
      await _databaseService.addToCart(
        Categories(
          name: widget.data['name'],
          url: widget.data['url'],
          desc: widget.data['desc'],
          star: widget.data['star'].toString(),
          category: widget.data['category'],
          price: widget.data['price'].toString(),
          itemCount: 1,
        ),
        _scaffoldKey,
      );
    } catch (e) {
      _scaffoldKey.currentState!
          .showSnackBar(showSnackBar(content: "Failed to add into cart!"));
    }
  }

  Column _column(Size size, BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _imageWithBackButton(size, context),
          _nameText(size),
          _price(size),
          _reviewsAndRating(size),
          _desc(size),
        ],
      );

  Padding _desc(Size size) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.01,
        ),
        child: Text(
          widget.data['desc'],
          style: const TextStyle(
            fontSize: kNormalFontSize,
            color: Colors.grey,
          ),
        ),
      );

  Padding _reviewsAndRating(Size size) => Padding(
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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Text(
                widget.data['star'].toString(),
                style: const TextStyle(
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
      );

  Padding _price(Size size) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.005,
        ),
        child: Text(
          '\$ ${widget.data['price'].toString()}',
          style: const TextStyle(fontSize: 24, color: Colors.grey),
        ),
      );

  Padding _nameText(Size size) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.01,
        ),
        child: Text(
          widget.data['name'],
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      );

  Padding _imageWithBackButton(Size size, BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.01),
        child: Stack(
          children: [
            _image(size),
            _backButton(size, context),
          ],
        ),
      );

  Positioned _backButton(Size size, BuildContext context) => Positioned(
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
      );

  Align _image(Size size) => Align(
        alignment: Alignment.topRight,
        child: ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(80)),
          child: Image.asset(
            widget.data['url'],
            fit: BoxFit.fill,
            height: size.height * 0.65,
            width: size.width * 0.85,
          ),
        ),
      );
}
