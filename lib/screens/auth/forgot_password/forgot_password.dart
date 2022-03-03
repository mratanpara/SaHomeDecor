import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/components/custom_text_field.dart';
import 'package:decor/screens/auth/login/screen/login_screen.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Forgot Password',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: kAllPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Forgot Password!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/success_screen/background.png'),
                Image.asset('assets/images/success_screen/Group.png'),
              ],
            ),
            Container(
              decoration: kBoxShadow,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: kAllPadding,
                  child: Column(
                    children: [
                      CustomTextField(
                        onSubmitted: (val) {
                          _emailFocus.unfocus();
                        },
                        type: TextInputType.text,
                        label: 'Email',
                        hintText: 'Enter email here',
                        controller: _emailController,
                        focusNode: _emailFocus,
                      ),
                      CustomButton(
                        label: 'SEND EMAIL',
                        onPressed: () async {
                          if (_emailController.text.isNotEmpty) {
                            await _databaseService
                                .forgotPassword(_emailController.text.trim());
                            await _authService.signOutUser();
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
