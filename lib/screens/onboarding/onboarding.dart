import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

const duration = Duration(milliseconds: 500);

class OnBoarding extends StatefulWidget {
  static const String id = 'onBoarding_screen';
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: kPhysics,
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _view1(),
            _view2(),
          ],
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? _getStartedButton(context)
          : _next(context),
    );
  }

  CustomButton _getStartedButton(BuildContext context) => CustomButton(
        label: 'Get Started',
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false),
      );
  CustomButton _next(BuildContext context) => CustomButton(
        label: 'Next',
        onPressed: () =>
            _pageController.nextPage(duration: duration, curve: Curves.ease),
      );

  Padding _view2() => Padding(
        padding: kAllPadding,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _view2Image(),
              _viewIndicator(),
              _view2Title1(),
              _view2Title2(),
              _view2TextContent(),
            ],
          ),
        ),
      );

  Padding _view2TextContent() => const Padding(
        padding: kSymmetricPaddingVer,
        child: Text(
          'The best simple place where you discover most wonderful furniture\'s and make your home beautiful',
          style: kOnBoardingContentTextStyle,
        ),
      );

  Padding _view2Title2() => const Padding(
        padding: kSymmetricPaddingVer,
        child: Text(
          'HOME BEAUTIFUL',
          style: kOnBoardingTitleTextStyle,
        ),
      );

  Text _view2Title1() => const Text(
        'MAKE YOUR',
        style: kOnBoardingTitleTextStyle,
      );

  Align _view2Image() => Align(
        child: Image.asset(
          'assets/images/pageview/view-2.png',
          height: 300,
          width: 300,
        ),
        alignment: Alignment.center,
      );

  Padding _view1() => Padding(
        padding: kAllPadding,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _view1Image(),
              _viewIndicator(),
              _view1Title(),
              _view1TextContent(),
            ],
          ),
        ),
      );

  Padding _view1TextContent() => const Padding(
        padding: kSymmetricPaddingVer,
        child: Text(
          'Your home is a reflection of you. Nail your aesthetic with products our stylists love and recommend',
          style: kOnBoardingContentTextStyle,
        ),
      );

  Padding _view1Title() => const Padding(
        padding: kSymmetricPaddingVer,
        child: Text(
          'We’ve Got Your Style',
          style: kOnBoardingTitleTextStyle,
        ),
      );

  Padding _viewIndicator() => Padding(
        padding: kSymmetricPaddingVer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      );

  Align _view1Image() => Align(
        child: Image.asset(
          'assets/images/pageview/view-1.png',
          height: 300,
          width: 300,
        ),
        alignment: Alignment.center,
      );
}
