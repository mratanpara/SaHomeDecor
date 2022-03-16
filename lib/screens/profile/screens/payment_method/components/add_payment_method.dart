import '../../../../../components/custom_app_bar.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_card_text_field.dart';
import '../../../../../constants/asset_constants.dart';
import '../../../../../constants/constants.dart';
import '../../../../../utils/methods/reusable_methods.dart';
import '../../../../../utils/methods/validation_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPaymentMethod extends StatefulWidget {
  static const String id = 'add_payment_method';

  const AddPaymentMethod({Key? key}) : super(key: key);

  @override
  _AddPaymentMethodState createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
      ),
      bottomNavigationBar: _addNewCardButton(),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Add Payment Method',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Image _image() => Image.asset(kPaymentCardImage1);

  CustomCardTextField _cardHolderTextField(BuildContext context) =>
      CustomCardTextField(
        type: TextInputType.text,
        label: 'CardHolder Name',
        hintText: 'Ex: John Deo',
        controller: _cardHolderController,
        focusNode: _cardHolderFocus,
        validator: validateHolderName,
        onPressed: (t) {
          fieldFocusChange(context, _cardHolderFocus, _cardNumberFocus);
        },
      );

  CustomCardTextField _cardNumberTextField(BuildContext context) =>
      CustomCardTextField(
        type: TextInputType.number,
        label: 'Card Number',
        hintText: '**** **** **** 1234',
        controller: _cardNumberController,
        focusNode: _cardNumberFocus,
        validator: validateCardNumber,
        onPressed: (t) {
          fieldFocusChange(context, _cardNumberFocus, _cvvFocus);
        },
      );

  Row _cvvAndExpirationDate(BuildContext context) => Row(
        children: [
          _cvvTextField(context),
          _expirationDateTextField(),
        ],
      );

  Expanded _cvvTextField(BuildContext context) => Expanded(
        child: CustomCardTextField(
          type: TextInputType.number,
          label: 'CVV',
          hintText: 'Ex: 123',
          controller: _cvvController,
          focusNode: _cvvFocus,
          validator: validateCVV,
          onPressed: (t) {
            fieldFocusChange(context, _cvvFocus, _expirationDateFocus);
          },
        ),
      );

  Expanded _expirationDateTextField() => Expanded(
        child: CustomCardTextField(
          type: TextInputType.text,
          label: 'Expiration Date',
          hintText: '03/22',
          controller: _expirationDataController,
          focusNode: _expirationDateFocus,
          validator: validateExpirationDate,
          onPressed: (t) {
            _expirationDateFocus.unfocus();
          },
        ),
      );

  Padding _addNewCardButton() => Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          label: 'ADD NEW CARD',
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
        ),
      );
}
