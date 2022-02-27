import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.back,
        title: 'Cart',
        actionIcon: null,
        onActionIconPressed: null,
        onLeadingIconPressed: null,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: kSymmetricPaddingHor,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/category/sofa.jpg',
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
                    ListTile(
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
                      padding: kAllPadding,
                      child: Row(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
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
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: kBoxShadow,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 0.01),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Enter your promo code',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomRectButton(
                        width: 56,
                        height: 56,
                        icon: CupertinoIcons.forward,
                        onPressed: () {},
                        color: Colors.black,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total:',
                    style: TextStyle(color: Colors.grey, fontSize: 22),
                  ),
                  Text(
                    '\$ 95',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            CustomButton(
              label: 'Check out',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
