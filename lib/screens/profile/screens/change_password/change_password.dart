// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_progress_indicator.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../services/database_services.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../utils/methods/validation_methods.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'change_password';

  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController _newPasswordController;
  late FocusNode _newPasswordFocus;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _newPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _newPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: Padding(
        padding: kAllPadding,
        child: SingleChildScrollView(
          physics: kPhysics,
          child: _column(context),
        ),
      ),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Change Password',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Column _column(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _headingText(),
          const SizedBox(height: 40),
          _image(),
          const SizedBox(height: 40),
          _cardWithTextField(context),
        ],
      );

  Text _headingText() => const Text(
        'Change Password!',
        style: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
      );

  Padding _image() => Padding(
        padding: kSymmetricPaddingVer,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            Image.asset(kBackgroundImage),
            Image.asset(kGroupImage),
          ],
        ),
      );

  Container _cardWithTextField(BuildContext context) => Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: kAllPadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _newPasswordTextFiled(),
                  isLoading
                      ? const CustomProgressIndicator()
                      : _saveButton(context),
                ],
              ),
            ),
          ),
        ),
      );

  CustomTextField _newPasswordTextFiled() => CustomTextField(
        onSubmitted: (val) {
          _newPasswordFocus.unfocus();
        },
        validator: validatePassword,
        type: TextInputType.text,
        label: 'Password',
        hintText: 'Enter new password',
        controller: _newPasswordController,
        focusNode: _newPasswordFocus,
      );

  CustomButton _saveButton(BuildContext context) => CustomButton(
        label: 'CHANGE PASSWORD',
        onPressed: () async {
          try {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              await _databaseService
                  .changePassword(_newPasswordController.text.trim());
              _scaffoldKey.currentState
                  ?.showSnackBar(showSnackBar(content: 'Password changed !'));
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
            }
          } catch (e) {
            _scaffoldKey.currentState?.showSnackBar(
                showSnackBar(content: 'Failed to change password !'));
          }
        },
      );
}
