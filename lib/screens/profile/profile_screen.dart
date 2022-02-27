import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants.dart';
import 'package:decor/screens/profile/components/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: CupertinoIcons.search,
        title: 'Profile',
        actionIcon: Icons.logout,
        onActionIconPressed: null,
        onLeadingIconPressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: kAllPadding,
        child: SizedBox(
          height: size.height * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: kSymmetricPaddingVer,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/thumbnail.jpeg'),
                      radius: size.width * 0.1,
                    ),
                    const Flexible(
                      child: ListTile(
                        title: Padding(
                          padding: kBottomPadding,
                          child: Text(
                            'Mohit Ratanpara',
                            style: kProfileTileTitleTextStyle,
                          ),
                        ),
                        subtitle: Text(
                          'mratanpara@gmail.com',
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
                    title: 'My Order', subTitle: 'Already have 10 orders'),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Shipping Addresses', subTitle: '03 Addresses'),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Payment Method', subTitle: 'You have 2 cards'),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'My Reviews', subTitle: 'Reviews for 5 items'),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: CustomCard(
                    title: 'Settings',
                    subTitle: 'Notification, Password, FAQs, Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
