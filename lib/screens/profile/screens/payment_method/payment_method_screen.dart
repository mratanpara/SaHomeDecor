import '../../../../components/custom_app_bar.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../constants/constants.dart';
import 'components/add_payment_method.dart';
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

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Payment Method',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
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

  Image _firstImage() => Image.asset(kPaymentCardImage1);

  Image _secondImage() => Image.asset(kPaymentCardImage2);

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
}
