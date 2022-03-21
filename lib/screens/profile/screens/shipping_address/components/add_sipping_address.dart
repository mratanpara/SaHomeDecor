// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../components/custom_app_bar.dart';
import '../../../../../components/custom_button.dart';
import '../../../../../components/custom_card_text_field.dart';
import '../../../../../components/custom_progress_indicator.dart';
import '../../../../../constants/constants.dart';
import '../../../../../constants/params_constants.dart';
import '../../../../../models/address_model.dart';
import '../../../../../services/database_services.dart';
import '../../../../../utils/methods/get_address_count.dart';
import '../../../../../utils/methods/reusable_methods.dart';
import '../../../../../utils/methods/validation_methods.dart';

class AddShippingAddress extends StatefulWidget {
  static const String id = 'add_shipping_address';

  AddShippingAddress({Key? key, required this.data}) : super(key: key);

  dynamic data;

  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late bool _isPrimary = false;

  late TextEditingController _fullNameController;
  late TextEditingController _zipcodeController;
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  late FocusNode _fullNameFocus;
  late FocusNode _addressFocus;
  late FocusNode _zipcodeFocus;
  late FocusNode _countryFocus;
  late FocusNode _cityFocus;
  late FocusNode _stateFocus;
  late FocusNode _phoneFocus;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _addressController = TextEditingController();
    _zipcodeController = TextEditingController();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _phoneController = TextEditingController();

    _fullNameFocus = FocusNode();
    _addressFocus = FocusNode();
    _zipcodeFocus = FocusNode();
    _countryFocus = FocusNode();
    _cityFocus = FocusNode();
    _stateFocus = FocusNode();
    _phoneFocus = FocusNode();

    if (widget.data != null) {
      _fullNameController.text = widget.data[paramFullName];
      _addressController.text = widget.data[paramAddress];
      _zipcodeController.text = widget.data[paramZipcode].toString();
      _countryController.text = widget.data[paramCountry];
      _cityController.text = widget.data[paramCity];
      _stateController.text = widget.data[paramState];
      _phoneController.text = widget.data[paramPhone].toString();
      setState(() {
        _isPrimary = widget.data[paramIsPrimary];
      });
    } else {
      _fullNameController.text = '';
      _addressController.text = '';
      _zipcodeController.text = '';
      _countryController.text = '';
      _cityController.text = '';
      _stateController.text = '';
      _phoneController.text = '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _zipcodeController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _phoneController.dispose();

    _fullNameFocus.dispose();
    _addressFocus.dispose();
    _zipcodeFocus.dispose();
    _countryFocus.dispose();
    _cityFocus.dispose();
    _stateFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        physics: kPhysics,
        padding: kAllPadding,
        child: _column(context),
      ),
      bottomNavigationBar: _saveAddressButton(context),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Add Shipping Address',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Form _column(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            _fullNameTextField(context),
            _phoneTextField(context),
            _addressTextField(context),
            _zipcodeTextField(context),
            _cityTextField(context),
            _stateTextField(context),
            _countryTextField(context),
          ],
        ),
      );

  CustomCardTextField _fullNameTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateFullName,
        type: TextInputType.text,
        label: 'Full Name',
        hintText: 'Enter Full Name',
        controller: _fullNameController,
        focusNode: _fullNameFocus,
        onPressed: (t) {
          fieldFocusChange(context, _fullNameFocus, _phoneFocus);
        },
      );

  CustomCardTextField _phoneTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateMobileNumber,
        type: TextInputType.number,
        label: 'Mobile Number',
        hintText: 'Enter Mobile Number',
        controller: _phoneController,
        focusNode: _phoneFocus,
        onPressed: (t) {
          fieldFocusChange(context, _phoneFocus, _addressFocus);
        },
      );

  CustomCardTextField _addressTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateAddress,
        type: TextInputType.text,
        label: 'Address',
        hintText: 'Enter Address',
        controller: _addressController,
        focusNode: _addressFocus,
        onPressed: (t) {
          fieldFocusChange(context, _addressFocus, _zipcodeFocus);
        },
      );

  CustomCardTextField _zipcodeTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateZipcode,
        type: TextInputType.number,
        label: 'Zipcode (Postal Code)',
        hintText: 'Enter Zipcode (Postal Code)',
        controller: _zipcodeController,
        focusNode: _zipcodeFocus,
        onPressed: (t) {
          fieldFocusChange(context, _zipcodeFocus, _cityFocus);
        },
      );

  CustomCardTextField _cityTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateCity,
        type: TextInputType.text,
        label: 'City',
        hintText: 'Enter City',
        controller: _cityController,
        focusNode: _cityFocus,
        onPressed: (t) {
          fieldFocusChange(context, _cityFocus, _stateFocus);
        },
      );

  CustomCardTextField _stateTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateState,
        type: TextInputType.text,
        label: 'State',
        hintText: 'Enter State',
        controller: _stateController,
        focusNode: _stateFocus,
        onPressed: (t) {
          fieldFocusChange(context, _stateFocus, _countryFocus);
        },
      );

  CustomCardTextField _countryTextField(BuildContext context) =>
      CustomCardTextField(
        validator: validateCountry,
        type: TextInputType.text,
        label: 'Country',
        hintText: 'Enter Country',
        controller: _countryController,
        focusNode: _countryFocus,
        onPressed: (t) {
          _countryFocus.unfocus();
        },
      );

  Padding _saveAddressButton(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const CustomProgressIndicator()
            : CustomButton(
                label: 'SAVE ADDRESS',
                onPressed: onSave,
              ),
      );

  void onSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (widget.data != null) {
        try {
          await _databaseService.updateAddress(
              doc: widget.data.id,
              addressData: AddressModel(
                fullName: _fullNameController.text,
                phone: int.parse(_phoneController.text),
                address: _addressController.text,
                zipcode: int.parse(_zipcodeController.text),
                country: _countryController.text,
                city: _cityController.text,
                state: _stateController.text,
                isPrimary: _isPrimary,
              ));
        } catch (e) {
          _scaffoldKey.currentState
              ?.showSnackBar(showSnackBar(content: 'Update failed!'));
        }
      } else {
        try {
          await _databaseService.addAddress(AddressModel(
            fullName: _fullNameController.text,
            phone: int.parse(_phoneController.text),
            address: _addressController.text,
            zipcode: int.parse(_zipcodeController.text),
            country: _countryController.text,
            city: _cityController.text,
            state: _stateController.text,
            isPrimary: false,
          ));
        } catch (e) {
          _scaffoldKey.currentState
              ?.showSnackBar(showSnackBar(content: 'Failed to add address!'));
        }
      }
      getAddressCount(context, _scaffoldKey);
      Navigator.pop(context);
    }
  }
}
