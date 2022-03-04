import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_card_text_field.dart';
import 'package:decor/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPaymentMethod extends StatefulWidget {
  static const String id = 'add_payment_method';

  @override
  _AddPaymentMethodState createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  late TextEditingController _cardHolderController;
  late TextEditingController _cardNumberController;
  late TextEditingController _cvvController;
  late TextEditingController _expirationDataController;

  late FocusNode _cardHolderFocus;
  late FocusNode _cardNumberFocus;
  late FocusNode _cvvFocus;
  late FocusNode _expirationDateFocus;

  @override
  void initState() {
    super.initState();
    _cardHolderController = TextEditingController();
    _cardNumberController = TextEditingController();
    _cvvController = TextEditingController();
    _expirationDataController = TextEditingController();

    _cardHolderFocus = FocusNode();
    _cardNumberFocus = FocusNode();
    _cvvFocus = FocusNode();
    _expirationDateFocus = FocusNode();
  }

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expirationDataController.dispose();

    _cardHolderFocus.dispose();
    _cardNumberFocus.dispose();
    _cvvFocus.dispose();
    _expirationDateFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        physics: kPhysics,
        padding: kAllPadding,
        child: Column(
          children: [
            _image(),
            const SizedBox(height: 10),
            _cardHolderTextField(context),
            _cardNumberTextField(context),
            _cvvAndExpirationDate(context),
          ],
        ),
      ),
      bottomNavigationBar: _addNewCardButton(),
    );
  }

  Padding _addNewCardButton() => Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          label: 'ADD NEW CARD',
          onPressed: () {},
        ),
      );

  Row _cvvAndExpirationDate(BuildContext context) => Row(
        children: [
          _cvvTextField(context),
          _expirationDateTextField(),
        ],
      );

  Expanded _expirationDateTextField() => Expanded(
        child: CustomCardTextField(
          type: TextInputType.text,
          label: 'Expiration Date',
          hintText: '03/22',
          controller: _expirationDataController,
          focusNode: _expirationDateFocus,
          onPressed: (t) {
            _expirationDateFocus.unfocus();
          },
        ),
      );

  Expanded _cvvTextField(BuildContext context) => Expanded(
        child: CustomCardTextField(
          type: TextInputType.number,
          label: 'CVV',
          hintText: 'Ex: 123',
          controller: _cvvController,
          focusNode: _cvvFocus,
          onPressed: (t) {
            fieldFocusChange(context, _cvvFocus, _expirationDateFocus);
          },
        ),
      );

  CustomCardTextField _cardNumberTextField(BuildContext context) =>
      CustomCardTextField(
        type: TextInputType.text,
        label: 'Card Number',
        hintText: '**** **** **** 1234',
        controller: _cardNumberController,
        focusNode: _cardNumberFocus,
        onPressed: (t) {
          fieldFocusChange(context, _cardNumberFocus, _cvvFocus);
        },
      );

  CustomCardTextField _cardHolderTextField(BuildContext context) =>
      CustomCardTextField(
        type: TextInputType.text,
        label: 'CardHolder Name',
        hintText: 'Ex: John Deo',
        controller: _cardHolderController,
        focusNode: _cardHolderFocus,
        onPressed: (t) {
          fieldFocusChange(context, _cardHolderFocus, _cardNumberFocus);
        },
      );

  Image _image() => Image.asset('assets/images/payment_card-1.png');

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Add Payment Method',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );
}
