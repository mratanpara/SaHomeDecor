import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  static const String id = 'success_screen';

  SuccessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: kSymmetricPaddingVer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Success!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset('assets/images/success_screen/checkedbox.png'),
                  ],
                ),
              ),
              Padding(
                padding: kSymmetricPaddingVer,
                child: Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/success_screen/background.png'),
                    Image.asset('assets/images/success_screen/Group.png'),
                  ],
                ),
              ),
              Padding(
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
              ),
              Padding(
                padding: kAllPadding,
                child: CustomButton(
                  label: 'BACK TO HOME',
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, DashBoard.id, (route) => false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
