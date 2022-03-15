import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/params_constants.dart';
import 'package:decor/utils/methods/get_address_count.dart';
import 'package:decor/components/refresh_indicator.dart';
import 'package:decor/providers/address_provider.dart';
import 'package:decor/screens/profile/components/custom_card.dart';
import 'package:decor/screens/profile/screens/myorder/myorder_screen.dart';
import 'package:decor/screens/profile/screens/myreviews/reviews_screen.dart';
import 'package:decor/screens/profile/screens/payment_method/payment_method_screen.dart';
import 'package:decor/screens/profile/screens/settings/settings_screen.dart';
import 'package:decor/screens/search_screen/search_screen.dart';
import 'package:decor/screens/shipping_address/screens/shipping_addresses_screen.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/utils/methods/reusable_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = AuthServices();
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  String displayName = "";
  String email = "";
  String photoURL = "";

  void getData() async {
    try {
      if (_currentUser != null) {
        var docSnapshot = await _usersCollection.doc(_currentUser!.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            displayName = docSnapshot.get(paramDisplayName);
            email = docSnapshot.get(paramEmail);
            photoURL = docSnapshot.get(paramPhotoURL);
          });
        }
      }
    } catch (e) {
      _scaffoldKey.currentState?.showSnackBar(
          showSnackBar(content: 'Not getting current user details!'));
    }
  }

  Future<void> getAddressesCount(BuildContext context) async {
    await getAddressCount(context, _scaffoldKey);
  }

  @override
  void initState() {
    super.initState();
    getData();
    getAddressesCount(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: CommonRefreshIndicator(
        child: SingleChildScrollView(
          physics: kPhysics,
          padding: kAllPadding,
          child: _column(size, context),
        ),
      ),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Profile',
        actionIcon: Icons.logout,
        onActionIconPressed: () async {
          await _auth.signOutUser(context);
        },
        onLeadingIconPressed: () =>
            Navigator.pushNamed(context, SearchScreen.id),
      );

  Column _column(Size size, BuildContext context) => Column(
        children: [
          _userDetails(size),
          _myOrderTile(context),
          _shippingAddressTile(context),
          _paymentMethodTile(context),
          _myReviewsTile(context),
          _settingsTile(context),
        ],
      );

  Padding _userDetails(Size size) => Padding(
        padding: kSymmetricPaddingVer,
        child: Row(
          children: [
            _image(size),
            _listTile(),
          ],
        ),
      );

  CircleAvatar _image(Size size) => CircleAvatar(
        backgroundImage: NetworkImage(photoURL),
        radius: size.width * 0.1,
      );

  Flexible _listTile() => Flexible(
        child: ListTile(
          title: Padding(
            padding: kBottomPadding,
            child: Text(
              displayName,
              style: kProfileTileTitleTextStyle,
            ),
          ),
          subtitle: Text(
            email,
            style: kProfileTileSubTitleTextStyle,
          ),
        ),
      );

  Padding _myOrderTile(BuildContext context) => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomCard(
            title: 'My Order',
            subTitle: 'Already have 10 orders',
            onTap: () => Navigator.pushNamed(context, OrderScreen.id)),
      );

  Padding _shippingAddressTile(BuildContext context) => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomCard(
            title: 'Shipping Addresses',
            subTitle:
                '${Provider.of<AddressProvider>(context).getAddressCount} Addresses',
            onTap: () {
              Navigator.pushNamed(context, ShippingAddresses.id);
            }),
      );

  Padding _paymentMethodTile(BuildContext context) => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomCard(
            title: 'Payment Method',
            subTitle: 'You have 2 cards',
            onTap: () => Navigator.pushNamed(context, PaymentMethodScreen.id)),
      );

  Padding _myReviewsTile(BuildContext context) => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomCard(
            title: 'My Reviews',
            subTitle: 'Reviews for 5 items',
            onTap: () => Navigator.pushNamed(context, ReviewsScreen.id)),
      );

  Padding _settingsTile(BuildContext context) => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomCard(
          title: 'Settings',
          subTitle: 'Notification, Password, FAQs, Contact',
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SettingsScreen(displayName: displayName, email: email))),
        ),
      );
}
