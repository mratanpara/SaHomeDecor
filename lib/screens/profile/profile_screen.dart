import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants.dart';
import 'package:decor/models/users_model.dart';
import 'package:decor/screens/auth/login/screen/login_screen.dart';
import 'package:decor/screens/profile/components/custom_card.dart';
import 'package:decor/screens/shipping_address/shipping_addresses_screen.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    getData();
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
          await _auth.signoutUser();
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        },
        onLeadingIconPressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: kAllPadding,
        child: Expanded(
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
                    onTap: () {}),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Shipping Addresses',
                    subTitle: '0 Addresses',
                    onTap: () {
                      Navigator.pushNamed(context, ShippingAddresses.id);
                    }),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Payment Method',
                    subTitle: 'You have 2 cards',
                    onTap: () {}),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'My Reviews',
                    subTitle: 'Reviews for 5 items',
                    onTap: () {}),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Settings',
                    subTitle: 'Notification, Password, FAQs, Contact',
                    onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
