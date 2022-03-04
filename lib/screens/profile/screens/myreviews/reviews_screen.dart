import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  static const String id = 'reviews_screen';
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.back,
        title: 'My Reviews',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: CommonRefreshIndicator(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: kSymmetricPaddingHor,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: kBoxShadow,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: kAllPadding,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/minimal-stand.png',
                                fit: BoxFit.cover,
                                height: size.height * 0.12,
                                width: size.width * 0.3,
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 2,
                            child: ListTile(
                              dense: true,
                              title: Padding(
                                padding: kBottomPadding,
                                child: Text(
                                  'Minimal Stand',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                '\$ 50.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: kSymmetricPaddingVer,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  const Icon(
                                    CupertinoIcons.star_fill,
                                    color: Colors.yellow,
                                  ),
                              ],
                            ),
                            const Text('20/03/2022'),
                          ],
                        ),
                      ),
                      const Text(
                          'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
