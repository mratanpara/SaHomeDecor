import '../../../../components/custom_app_bar.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../components/refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  static const String id = 'reviews_screen';
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(context),
      body: CommonRefreshIndicator(
        child: ListView.builder(
          physics: kPhysics,
          padding: kSymmetricPaddingHor,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _customReviewListTile(size);
          },
        ),
      ),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        leadingIcon: CupertinoIcons.back,
        title: 'My Reviews',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Container _customReviewListTile(Size size) => Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: kAllPadding,
            child: Column(
              children: [
                _imageAndNameTextRow(size),
                _ratingAndDate(),
                _review(),
              ],
            ),
          ),
        ),
      );

  Row _imageAndNameTextRow(Size size) => Row(
        children: [
          _image(size),
          _listTile(),
        ],
      );

  Expanded _image(Size size) => Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            kSignUpAndSignInLogoImage,
            fit: BoxFit.cover,
            height: size.height * 0.12,
            width: size.width * 0.3,
          ),
        ),
      );

  Expanded _listTile() => Expanded(
        flex: 2,
        child: ListTile(
          dense: true,
          title: _titleText(),
          subtitle: _priceText(),
        ),
      );

  Padding _titleText() => const Padding(
        padding: kBottomPadding,
        child: Text(
          'Sofa',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Text _priceText() => const Text(
        '\$ 50.00',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      );

  Padding _ratingAndDate() => Padding(
        padding: kSymmetricPaddingVer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _starsRow(),
            const Text('20/03/2022'),
          ],
        ),
      );

  Row _starsRow() => Row(
        children: [
          for (int i = 0; i < 5; i++)
            const Icon(
              CupertinoIcons.star_fill,
              color: Colors.yellow,
            ),
        ],
      );

  Text _review() => const Text(
      'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price');
}
