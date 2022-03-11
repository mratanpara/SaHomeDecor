import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/screens/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3000), () {
      final _currentUser = FirebaseAuth.instance.currentUser;

      if (_currentUser?.email != null) {
        Navigator.pushReplacementNamed(context, DashBoard.id);
      } else {
        Navigator.pushReplacementNamed(context, OnBoarding.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: kAllPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image(),
              _animatedText(),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedTextKit _animatedText() => AnimatedTextKit(
        repeatForever: false,
        animatedTexts: [
          ColorizeAnimatedText(
            'SA Home Decor',
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
            colors: [
              Colors.black,
              Colors.white,
              Colors.black,
            ],
          ),
        ],
      );

  Stack _image() => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/success_screen/background.png'),
          Image.asset('assets/images/success_screen/Group.png'),
        ],
      );
}
