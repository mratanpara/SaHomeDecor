import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_card_text_field.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/screens/profile/screens/change_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  SettingsScreen({required this.displayName, required this.email});

  final String displayName;
  final String email;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _nameController.text = widget.displayName;
    _emailController.text = widget.email;

    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: CommonRefreshIndicator(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: kAllPadding,
            child: Column(
              children: [
                _headingRow(),
                CustomCardTextField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    label: 'Name',
                    onPressed: (val) {},
                    type: TextInputType.text,
                    hintText: 'Name'),
                CustomCardTextField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    label: 'Email',
                    onPressed: (val) {},
                    type: TextInputType.emailAddress,
                    hintText: 'Emaail'),
                _heading('Password'),
                _customListTile(
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () =>
                        Navigator.pushNamed(context, ChangePassword.id),
                    text: 'Change Password'),
                _heading('Notification'),
                _customListTile(
                    trailing: CupertinoSwitch(value: true, onChanged: (val) {}),
                    onTap: () {},
                    text: 'Sales'),
                _customListTile(
                    trailing:
                        CupertinoSwitch(value: false, onChanged: (val) {}),
                    onTap: () {},
                    text: 'New arrivals'),
                _customListTile(
                    trailing:
                        CupertinoSwitch(value: false, onChanged: (val) {}),
                    onTap: () {},
                    text: 'Delivery status changes'),
                _heading('Help Center'),
                _customListTile(
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {},
                    text: 'FAQs'),
                _customListTile(
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {},
                    text: 'Privacy Policy'),
                _customListTile(
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {},
                    text: 'Terms & Condition'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _customListTile(
          {required String text,
          required Widget trailing,
          required VoidCallback onTap}) =>
      Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: ListTile(
            onTap: onTap,
            title: Text(
              text,
              style: const TextStyle(fontSize: kNormalFontSize),
            ),
            trailing: trailing,
          ),
        ),
      );

  Align _heading(String text) {
    return Align(
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

  Row _headingRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Personal Information',
            style: kSettingsHeadingTextStyle,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      );
}
