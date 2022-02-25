import 'package:decor/components/custom_button.dart';
import 'package:decor/constants.dart';
import 'package:decor/screens/auth/components/custom_text_button.dart';
import 'package:decor/screens/auth/components/custom_text_field.dart';
import 'package:decor/screens/auth/components/facebook_signin_button.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _image(),
                _firstHeading(),
                _secondHeading(),
                _cardWithShadow(size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _cardWithShadow(Size size, BuildContext context) => Padding(
        padding: kCardPadding,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 20.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: const Offset(
                  5.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Card(
            shadowColor: Colors.transparent,
            color: kBgColor,
            child: Padding(
              padding: kCardPadding,
              child: Column(
                children: [
                  CustomTextField(label: 'Email'),
                  CustomTextField(label: 'Password'),
                  _forgotPassword(),
                  _loginButton(),
                  _richTextButton(context),
                  const Divider(thickness: 1),
                  _facebookButton(),
                ],
              ),
            ),
          ),
        ),
      );

  Padding _facebookButton() => Padding(
        padding: kSymmetricPaddingVer,
        child: FacebookSigninButton(label: 'Sign in with Facebook'),
      );

  Padding _loginButton() => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomButton(label: 'Log In', onPressed: () {}),
      );

  Align _forgotPassword() => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: kSymmetricPaddingVer,
          child: CustomTextButton(text: 'Forgot Password?', onPressed: () {}),
        ),
      );

  Padding _richTextButton(BuildContext context) => Padding(
        padding: kAllPadding,
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

  Padding _secondHeading() => Padding(
        padding: kAllPadding,
        child: Text(
          'welcome back'.toUpperCase(),
          style: kSecondHeadingTextStyle,
        ),
      );

  Padding _firstHeading() => const Padding(
        padding: kSymmetricPaddingHor,
        child: Text(
          'Hello !',
          style: kFirstHeadingTextStyle,
        ),
      );

  Padding _image() => Padding(
        padding: kAllPadding,
        child: Image.asset('assets/images/img.png'),
      );
}
