import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/components/custom_text_field.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';

  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _databaseService = DatabaseService();
  final _authService = AuthServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  Container _textFieldAndButton(BuildContext context) => Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: kAllPadding,
            child: Column(
              children: [
                _textField(),
                _button(context),
              ],
            ),
          ),
        ),
      );

  CustomButton _button(BuildContext context) => CustomButton(
        label: 'SEND EMAIL',
        onPressed: () async {
          try {
            if (_emailController.text.isNotEmpty) {
              await _databaseService
                  .forgotPassword(_emailController.text.trim());
              _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                  content: 'E-mail sent to ${_emailController.text.trim()}',
                  color: Colors.green));
              await _authService.signOutUser(context);
            }
          } catch (e) {
            _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                content: 'Failed to send mail!', color: Colors.red));
          }
        },
      );

  CustomTextField _textField() => CustomTextField(
        onSubmitted: (val) {
          _emailFocus.unfocus();
        },
        type: TextInputType.text,
        label: 'Email',
        hintText: 'Enter email here',
        controller: _emailController,
        focusNode: _emailFocus,
      );

  Stack _image() => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/success_screen/background.png'),
          Image.asset('assets/images/success_screen/Group.png'),
        ],
      );

  Text _headingTextWithIcon() => const Text(
        'Forgot Password!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
      );

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Forgot Password',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );
}
