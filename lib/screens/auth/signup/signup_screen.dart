import 'package:decor/components/custom_button.dart';
import 'package:decor/constants.dart';
import 'package:decor/screens/auth/components/custom_text_field.dart';
import 'package:decor/screens/auth/components/facebook_signin_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                _headingText(),
                _cardWithShadow(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _cardWithShadow(Size size) => Padding(
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
                  CustomTextField(label: 'Name'),
                  CustomTextField(label: 'Email'),
                  CustomTextField(label: 'Password'),
                  CustomTextField(label: 'Confirm Password'),
                  _signupButton(),
                  _richTextButton(),
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
        child: FacebookSigninButton(label: 'Sign up with Facebook'),
      );

  Padding _signupButton() => Padding(
        padding: kSymmetricPaddingVer,
        child: CustomButton(label: 'Sign Up', onPressed: () {}),
      );

  Padding _richTextButton() => Padding(
        padding: kAllPadding,
        child: GestureDetector(
          child: RichText(
            text: const TextSpan(
              text: 'Already have a account? ',
              style: TextStyle(fontSize: kNormalFontSize, color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign In',
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

  Padding _headingText() => Padding(
        padding: kAllPadding,
        child: Text(
          'welcome'.toUpperCase(),
          style: kSecondHeadingTextStyle,
        ),
      );

  Padding _image() => Padding(
        padding: kAllPadding,
        child: Image.asset('assets/images/img.png'),
      );
}
