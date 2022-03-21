// ignore_for_file: use_key_in_widget_constructors

import 'package:decor/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/custom_app_bar.dart';
import '../../../../constants/constants.dart';
import '../../../../components/refresh_indicator.dart';
import '../change_password/change_password.dart';
import 'components/custom_list_tile.dart';
import 'screens/faqs_screen.dart';
import 'screens/privacy_policy.dart';
import 'screens/terms_and_conditions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: CommonRefreshIndicator(
        child: SingleChildScrollView(
          physics: kPhysics,
          child: Padding(
            padding: kAllPadding,
            child: _column(context),
          ),
        ),
      ),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Settings',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Column _column(BuildContext context) => Column(
        children: [
          _heading('Password'),
          _changePasswordTile(context),
          _heading('Theme'),
          _darkMode(),
          _heading('Notification'),
          _salesTile(),
          _newArrivalsTile(),
          _deliveryStatusChangesTile(),
          _heading('Help Center'),
          _faqsTile(context),
          _privacyPolicyTile(context),
          _termsAndConditionTile(context),
        ],
      );

  Consumer _darkMode() => Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return CustomListTile(
            trailing: CupertinoSwitch(
                value: _isDarkMode,
                onChanged: (val) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    prefs.setBool("isDarkTheme", val);
                    _isDarkMode = val;
                  });
                  themeProvider.swapTheme();
                }),
            onTap: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              themeProvider.swapTheme();
            },
            text: 'Dark Mode',
          );
        },
      );

  CustomListTile _changePasswordTile(BuildContext context) => CustomListTile(
      trailing: const Icon(CupertinoIcons.forward),
      onTap: () => Navigator.pushNamed(context, ChangePassword.id),
      text: 'Change Password');

  CustomListTile _salesTile() => CustomListTile(
      trailing: CupertinoSwitch(value: true, onChanged: (val) {}),
      onTap: () {},
      text: 'Sales');

  CustomListTile _newArrivalsTile() => CustomListTile(
      trailing: CupertinoSwitch(value: false, onChanged: (val) {}),
      onTap: () {},
      text: 'New arrivals');

  CustomListTile _deliveryStatusChangesTile() => CustomListTile(
      trailing: CupertinoSwitch(value: false, onChanged: (val) {}),
      onTap: () {},
      text: 'Delivery status changes');

  CustomListTile _faqsTile(BuildContext context) => CustomListTile(
        trailing: const Icon(CupertinoIcons.forward),
        onTap: () => Navigator.pushNamed(context, FAQsScreen.id),
        text: 'FAQs',
      );

  CustomListTile _privacyPolicyTile(BuildContext context) => CustomListTile(
      trailing: const Icon(CupertinoIcons.forward),
      onTap: () => Navigator.pushNamed(context, PrivacyPolicyScreen.id),
      text: 'Privacy Policy');

  CustomListTile _termsAndConditionTile(BuildContext context) => CustomListTile(
      trailing: const Icon(CupertinoIcons.forward),
      onTap: () => Navigator.pushNamed(context, TermsAndConditionsScreen.id),
      text: 'Terms & Condition');

  Align _heading(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: kSymmetricPaddingVer,
          child: Text(
            text,
            style: kSettingsHeadingTextStyle,
          ),
        ),
      );
}
