import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: kAllPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/success_screen/background.png'),
                  Image.asset('assets/images/success_screen/Group.png'),
                ],
              ),
              AnimatedTextKit(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
