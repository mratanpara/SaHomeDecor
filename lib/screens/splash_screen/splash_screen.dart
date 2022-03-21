import '../../constants/asset_constants.dart';
import '../../constants/constants.dart';
import '../auth/login/login_screen.dart';
import '../dashboard/dashboard.dart';
import '../onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation _imageAnimation;
  late Animation _colorAnimation;
  late AnimationController _imageAnimationController;
  late AnimationController _colorAnimationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _imageAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _colorAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    final CurvedAnimation curve = CurvedAnimation(
        parent: _imageAnimationController, curve: Curves.bounceOut);

    _imageAnimation = Tween(begin: 100.0, end: 300.0).animate(curve);

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.grey)
        .animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _imageAnimationController.forward();
    _colorAnimationController.forward();

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
    _imageAnimationController.dispose();
    super.dispose();
  }

  Widget builder(BuildContext context, Widget? child) {
    return Hero(
      tag: 'logo',
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Image.asset(
            kBackgroundImage,
            height: _imageAnimation.value,
            width: _imageAnimation.value,
          ),
          Image.asset(kGroupImage),
        ],
      ),
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
              AnimatedBuilder(animation: _imageAnimation, builder: builder),
              Text(
                'SA Home Decor',
                style: TextStyle(
                  color: _colorAnimation.value,
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
