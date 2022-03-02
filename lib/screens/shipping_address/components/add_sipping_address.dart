import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/screens/auth/components/custom_text_field.dart';
import 'package:decor/screens/shipping_address/components/custom_card_text_field.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddShippingAddress extends StatefulWidget {
  static const String id = 'add_shipping_address';

  AddShippingAddress({required this.data});

  dynamic? data;

  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController _fullNameController;
  late TextEditingController _addressController;
  late TextEditingController _zipcodeController;
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;

  late FocusNode _fullNameFocus;
  late FocusNode _addressFocus;
  late FocusNode _zipcodeFocus;
  late FocusNode _countryFocus;
  late FocusNode _cityFocus;
  late FocusNode _districtFocus;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _addressController = TextEditingController();
    _zipcodeController = TextEditingController();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _districtController = TextEditingController();

    _fullNameFocus = FocusNode();
    _addressFocus = FocusNode();
    _zipcodeFocus = FocusNode();
    _countryFocus = FocusNode();
    _cityFocus = FocusNode();
    _districtFocus = FocusNode();

    if (widget.data != null) {
      _fullNameController.text = widget.data['fullName'];
      _addressController.text = widget.data['address'];
      _zipcodeController.text = widget.data['zipcode'].toString();
      _countryController.text = widget.data['country'];
      _cityController.text = widget.data['city'];
      _districtController.text = widget.data['district'];
    } else {
      _fullNameController.text = '';
      _addressController.text = '';
      _zipcodeController.text = '';
      _countryController.text = '';
      _cityController.text = '';
      _districtController.text = '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _zipcodeController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _districtController.dispose();

    _fullNameFocus.dispose();
    _addressFocus.dispose();
    _zipcodeFocus.dispose();
    _countryFocus.dispose();
    _cityFocus.dispose();
    _districtFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Add Shipping Address',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: kAllPadding,
        child: Column(
          children: [
            CustomCardTextField(
              type: TextInputType.text,
              label: 'Full Name',
              hintText: 'Enter Full Name',
              controller: _fullNameController,
              focusNode: _fullNameFocus,
              onPressed: (t) {
                fieldFocusChange(context, _fullNameFocus, _addressFocus);
              },
            ),
            CustomCardTextField(
              type: TextInputType.text,
              label: 'Address',
              hintText: 'Enter Address',
              controller: _addressController,
              focusNode: _addressFocus,
              onPressed: (t) {
                fieldFocusChange(context, _addressFocus, _zipcodeFocus);
              },
            ),
            CustomCardTextField(
              type: TextInputType.number,
              label: 'Zipcode (Postal Code)',
              hintText: 'Enter Zipcode (Postal Code)',
              controller: _zipcodeController,
              focusNode: _zipcodeFocus,
              onPressed: (t) {
                fieldFocusChange(context, _zipcodeFocus, _countryFocus);
              },
            ),
            CustomCardTextField(
              type: TextInputType.text,
              label: 'Country',
              hintText: 'Enter Country',
              controller: _countryController,
              focusNode: _countryFocus,
              onPressed: (t) {
                fieldFocusChange(context, _countryFocus, _cityFocus);
              },
            ),
            CustomCardTextField(
              type: TextInputType.text,
              label: 'City',
              hintText: 'Enter City',
              controller: _cityController,
              focusNode: _cityFocus,
              onPressed: (t) {
                fieldFocusChange(context, _cityFocus, _districtFocus);
              },
            ),
            CustomCardTextField(
              type: TextInputType.text,
              label: 'District',
              hintText: 'Enter District',
              controller: _districtController,
              focusNode: _districtFocus,
              onPressed: (t) {
                _districtFocus.unfocus();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          label: 'SAVE ADDRESS',
          onPressed: () async {
            if (_addressController.text.isNotEmpty &&
                _fullNameController.text.isNotEmpty &&
                _zipcodeController.text.isNotEmpty &&
                _countryController.text.isNotEmpty &&
                _cityController.text.isNotEmpty &&
                _districtController.text.isNotEmpty) {
              if (widget.data != null) {
                await _databaseService.updateAddress(
                    doc: widget.data.id,
                    fullName: _fullNameController.text,
                    address: _addressController.text,
                    zipcode: int.parse(_zipcodeController.text),
                    country: _countryController.text,
                    city: _cityController.text,
                    district: _districtController.text);
              } else {
                await _databaseService.addAddress(
                    fullName: _fullNameController.text,
                    address: _addressController.text,
                    zipcode: int.parse(_zipcodeController.text),
                    country: _countryController.text,
                    city: _cityController.text,
                    district: _districtController.text);
              }
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
