import 'package:decor/constants/asset_constants.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = Tween(begin: 100.0, end: 300.0).animate(curve);

    controller.forward();

    Future.delayed(const Duration(milliseconds: 3000), () async {
      final _prefs = await SharedPreferences.getInstance();
      bool _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
      bool _newToApp = _prefs.getBool('newToApp') ?? true;

      if (_isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
            context, DashBoard.id, (route) => false);
      } else {
        if (_newToApp) {
          Navigator.pushNamedAndRemoveUntil(
              context, OnBoarding.id, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.id, (route) => false);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget builder(BuildContext context, Widget? child) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        Image.asset(
          kBackgroundImage,
          height: animation.value,
          width: animation.value,
        ),
        Image.asset(kGroupImage),
      ],
    );
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
              AnimatedBuilder(animation: animation, builder: builder),
              const Text(
                'SA Home Decor',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
