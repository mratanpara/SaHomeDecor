import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _image(),
            _content(context),
          ],
        ),
      ),
    );
  }

  Flexible _content(BuildContext context) => Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _firstHeadingText(),
            _secondHeadingText(),
            _contentText(),
            const SizedBox(height: 80),
            _getStartedButton(context),
          ],
        ),
      );

  Padding _getStartedButton(BuildContext context) => Padding(
        padding: kAllPadding,
        child: CustomButton(
          label: 'Get Started',
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.id, (route) => false),
        ),
      );

  Padding _contentText() => Padding(
        padding: kAllPadding,
        child: Text(
          'The best simple place where you discover most wonderful furniture\'s and make your home beautiful',
          style: kWelcomeContentStyle,
        ),
      );

  Padding _secondHeadingText() => const Padding(
        padding: kAllPadding,
        child: Text(
          'HOME BEAUTIFUL',
          style: kWelcomeSecondHeading,
        ),
      );

  Padding _firstHeadingText() => const Padding(
        padding: kSymmetricPaddingHor,
        child: Text(
          'MAKE YOUR',
          style: kWelcomeFirstHeading,
        ),
      );

  Image _image() =>
      Image.asset('assets/images/welcome.png', fit: BoxFit.fitWidth);
}
