import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/components/custom_text_field.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
import 'package:decor/utils/methods/validation_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'change_password';

  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _databaseService = DatabaseService();
  final _authService = AuthServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  _saveButton(context),
                ],
              ),
            ),
          ),
        ),
      );

  CustomButton _saveButton(BuildContext context) => CustomButton(
        label: 'SAVE PASSWORD',
        onPressed: () async {
          try {
            if (_formKey.currentState!.validate()) {
              await _databaseService
                  .changePassword(_newPasswordController.text.trim());
              _scaffoldKey.currentState
                  ?.showSnackBar(showSnackBar(content: 'Password changed !'));
              await _authService.signOutUser(context);
            }
          } catch (e) {
            _scaffoldKey.currentState?.showSnackBar(
                showSnackBar(content: 'Failed to change password !'));
          }
        },
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

  Padding _image() => Padding(
        padding: kSymmetricPaddingVer,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/success_screen/background.png'),
            Image.asset('assets/images/success_screen/Group.png'),
          ],
        ),
      );

  Text _headingText() => const Text(
        'Change Password!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
      );

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Change Password',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );
}
