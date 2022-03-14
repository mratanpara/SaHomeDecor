import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/screens/profile/screens/payment_method/components/add_payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  static const String id = 'payment_method_screen';
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
      floatingActionButton: _addPaymentMethodButton(context),
    );
  }

  FloatingActionButton _addPaymentMethodButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPaymentMethod.id);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.black,
        ),
      );

  Padding _body() => Padding(
        padding: kAllPadding,
        child: Column(
          children: [
            _firstImage(),
            _setPrimaryShippingAddress(),
            _secondImage(),
            _setPrimaryShippingAddress(),
          ],
        ),
      );

  Image _secondImage() => Image.asset('assets/images/payment_card-2.png');

  Row _setPrimaryShippingAddress() => Row(
        children: [
          Checkbox(
            value: true,
            activeColor: Colors.black,
            onChanged: (value) {},
          ),
          const Text(
            'Use as the payment method',
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
        ],
      );

  Image _firstImage() => Image.asset('assets/images/payment_card-1.png');

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Payment Method',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );
}
