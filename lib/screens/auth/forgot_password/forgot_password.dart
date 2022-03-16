// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_progress_indicator.dart';
import '../../../components/custom_text_field.dart';
import '../../../constants/asset_constants.dart';
import '../../../constants/constants.dart';
import '../../../services/auth_services.dart';
import '../../../services/database_services.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../../utils/methods/validation_methods.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _databaseService = DatabaseService();
  final _authService = AuthServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController _emailController;
  late FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();

    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();

    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Forgot Password',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Padding _body(BuildContext context) => Padding(
        padding: kAllPadding,
        child: SingleChildScrollView(
          physics: kPhysics,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _headingTextWithIcon(),
              const SizedBox(height: 40),
              _image(),
              const SizedBox(height: 40),
              _textFieldAndButton(context),
            ],
          ),
        ),
      );

  Text _headingTextWithIcon() => const Text(
        'Forgot Password!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
      );

  Stack _image() => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Image.asset(kBackgroundImage),
          Image.asset(kGroupImage),
        ],
      );

  Container _textFieldAndButton(BuildContext context) => Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: kAllPadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _textField(),
                  isLoading
                      ? const CustomProgressIndicator()
                      : _button(context),
                ],
              ),
            ),
          ),
        ),
      );

  CustomTextField _textField() => CustomTextField(
        onSubmitted: (val) {
          _emailFocus.unfocus();
        },
        validator: validateEmail,
        type: TextInputType.text,
        label: 'Email',
        hintText: 'Enter email here',
        controller: _emailController,
        focusNode: _emailFocus,
      );

  CustomButton _button(BuildContext context) => CustomButton(
        label: 'SEND EMAIL',
        onPressed: () async {
          try {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              await _databaseService
                  .forgotPassword(_emailController.text.trim());
              _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                  content: 'E-mail sent to ${_emailController.text.trim()}'));
              await _authService.signOutUser(context);
            }
          } catch (e) {
            _scaffoldKey.currentState
                ?.showSnackBar(showSnackBar(content: 'Failed to send mail!'));
          }
        },
      );
}
