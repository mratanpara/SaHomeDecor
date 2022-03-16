// ignore_for_file: use_key_in_widget_constructors

import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_card_text_field.dart';
import '../../../../constants/constants.dart';
import '../../../../components/refresh_indicator.dart';
import '../change_password/change_password.dart';
import 'components/custom_list_tile.dart';
import 'screens/faqs_screen.dart';
import 'screens/privacy_policy.dart';
import 'screens/terms_and_conditions.dart';
import '../../../../utils/methods/validation_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  const SettingsScreen({required this.displayName, required this.email});

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
          _headingRow(),
          _nameTextField(),
          _emailTextField(),
          _heading('Password'),
          _changePasswordTile(context),
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

  CustomCardTextField _nameTextField() => CustomCardTextField(
      controller: _nameController,
      focusNode: _nameFocus,
      label: 'Name',
      validator: validateFullName,
      onPressed: (val) {},
      type: TextInputType.text,
      hintText: 'Name');

  CustomCardTextField _emailTextField() => CustomCardTextField(
      controller: _emailController,
      focusNode: _emailFocus,
      label: 'Email',
      validator: validateEmail,
      onPressed: (val) {},
      type: TextInputType.emailAddress,
      hintText: 'Email');

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
