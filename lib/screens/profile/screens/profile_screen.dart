import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/get_counts_data.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/providers/common_provider.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:decor/screens/profile/components/custom_card.dart';
import 'package:decor/screens/profile/screens/change_password/change_password.dart';
import 'package:decor/screens/profile/screens/myorder/myorder_screen.dart';
import 'package:decor/screens/profile/screens/pyment_method/payment_method_screen.dart';
import 'package:decor/screens/profile/screens/myreviews/reviews_screen.dart';
import 'package:decor/screens/profile/screens/settings/settings_screen.dart';
import 'package:decor/screens/search_screen/search_screen.dart';
import 'package:decor/screens/shipping_address/screens/shipping_addresses_screen.dart';
import 'package:decor/screens/splash_screen/splash_screen.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
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
  final _auth = AuthServices();
  final _databaseService = DatabaseService();
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  String displayName = "";
  String email = "";
  String photoURL = "";

  void getData() async {
    if (_currentUser != null) {
      var docSnapshot = await _usersCollection.doc(_currentUser!.uid).get();
      if (docSnapshot.exists) {
        setState(() {
          displayName = docSnapshot.get("displayName");
          email = docSnapshot.get("email");
          photoURL = docSnapshot.get("photoURL");
        });
      }
    }
  }

  Future<void> getAddressesCount(BuildContext context) async {
    await getAddressCount(context);
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
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Profile',
        actionIcon: Icons.logout,
        onActionIconPressed: () async {
          await _auth.signOutUser();
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        },
        onLeadingIconPressed: () =>
            Navigator.pushNamed(context, SearchScreen.id),
      ),
      body: CommonRefreshIndicator(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: kAllPadding,
          child: Column(
            children: [
              Padding(
                padding: kSymmetricPaddingVer,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(photoURL),
                      radius: size.width * 0.1,
                    ),
                    Flexible(
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'My Order',
                    subTitle: 'Already have 10 orders',
                    onTap: () => Navigator.pushNamed(context, OrderScreen.id)),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Shipping Addresses',
                    subTitle:
                        '${Provider.of<CommonProvider>(context).getAddressCount} Addresses',
                    onTap: () {
                      Navigator.pushNamed(context, ShippingAddresses.id);
                    }),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Payment Method',
                    subTitle: 'You have 2 cards',
                    onTap: () =>
                        Navigator.pushNamed(context, PaymentMethodScreen.id)),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'My Reviews',
                    subTitle: 'Reviews for 5 items',
                    onTap: () =>
                        Navigator.pushNamed(context, ReviewsScreen.id)),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                  title: 'Settings',
                  subTitle: 'Notification, Password, FAQs, Contact',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen(
                              displayName: displayName, email: email))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
