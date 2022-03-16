import '../../components/custom_button.dart';
import '../../constants/asset_constants.dart';
import '../../constants/constants.dart';
import '../dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  static const String id = 'success_screen';

  const SuccessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _successTextWithIcon(),
              _logoImage(),
              _contentText(),
              _backToHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _successTextWithIcon() => Padding(
        padding: kSymmetricPaddingVer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _text(),
            Image.asset('assets/images/success_screen/checkedbox.png'),
          ],
        ),
      );

  Text _text() => const Text(
        'Success!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
      );

  Padding _logoImage() => Padding(
        padding: kSymmetricPaddingVer,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            Image.asset(kBackgroundImage),
            Image.asset(kGroupImage),
          ],
        ),
      );

  Padding _contentText() => Padding(
        padding: kSymmetricPaddingVer,
        child: Column(
          children: const [
            Text(
              'Your order will be delivered soon.',
              style: kSuccessMsgTextStyle,
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for choosing our app!',
              style: kSuccessMsgTextStyle,
            ),
          ],
        ),
      );

  Padding _backToHomeButton(BuildContext context) => Padding(
        padding: kAllPadding,
        child: CustomButton(
          label: 'BACK TO HOME',
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, DashBoard.id, (route) => false),
        ),
      );
}
