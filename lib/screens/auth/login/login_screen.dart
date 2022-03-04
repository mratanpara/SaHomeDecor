import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/components/custom_text_button.dart';
import 'package:decor/components/custom_text_field.dart';
import 'package:decor/screens/auth/components/facebook_signin_button.dart';
import 'package:decor/screens/auth/forgot_password/forgot_password.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _image(size),
                _firstHeading(size),
                _secondHeading(size),
                _cardWithShadow(size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _cardWithShadow(Size size, BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.01, horizontal: size.height * 0.01),
        child: Container(
          decoration: kBoxShadow,
          child: Card(
            shadowColor: Colors.transparent,
            color: kBgColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 0.01, horizontal: size.height * 0.01),
              child: Column(
                children: [
                  _emailTextField(context),
                  _passwordTextField(),
                  _forgotPassword(size),
                  _loginButton(size),
                  _richTextButton(context, size),
                  const Divider(thickness: 1),
                  _facebookButton(size),
                ],
              ),
            ),
          ),
        ),
      );

  CustomTextField _passwordTextField() => CustomTextField(
        label: 'Password',
        hintText: 'Enter Password',
        controller: _passwordController,
        focusNode: _passwordFocus,
        type: TextInputType.visiblePassword,
        onSubmitted: (term) {
          _passwordFocus.unfocus();
        },
      );

  CustomTextField _emailTextField(BuildContext context) => CustomTextField(
        label: 'Email',
        hintText: 'Enter Email',
        controller: _emailController,
        focusNode: _emailFocus,
        type: TextInputType.emailAddress,
        onSubmitted: (term) {
          fieldFocusChange(context, _emailFocus, _passwordFocus);
        },
      );

  Padding _facebookButton(Size size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
        child: FacebookSigninButton(label: 'Sign in with Facebook'),
      );

  void _toggleSpinner() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  Padding _loginButton(Size size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
        child: isPressed
            ? const CustomProgressIndicator()
            : CustomButton(
                label: 'Log In',
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    _toggleSpinner();
                    try {
                      await _auth.signinWithEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim());
                      Navigator.pushReplacementNamed(context, DashBoard.id);
                    } catch (e) {
                      _toggleSpinner();
                      _scaffoldKey.currentState?.showSnackBar(
                          showSnackBar(content: 'Invalid credential!'));
                    }
                  } else {
                    _scaffoldKey.currentState?.showSnackBar(
                        showSnackBar(content: 'Invalid credential!'));
                  }
                },
              ),
      );

  Align _forgotPassword(Size size) => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
          child: CustomTextButton(
              text: 'Forgot Password?',
              onPressed: () => Navigator.pushNamed(context, ForgotPassword.id)),
        ),
      );

  Padding _richTextButton(BuildContext context, Size size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignupScreen.id),
          child: RichText(
            text: const TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(fontSize: kNormalFontSize, color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Padding _secondHeading(Size size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: Text(
          'welcome back'.toUpperCase(),
          style: kSecondHeadingTextStyle,
        ),
      );

  Padding _firstHeading(Size size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: const Text(
          'Hello !',
          style: kFirstHeadingTextStyle,
        ),
      );

  Padding _image(Size size) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.01, horizontal: size.height * 0.02),
        child: Image.asset('assets/images/img.png'),
      );
}
