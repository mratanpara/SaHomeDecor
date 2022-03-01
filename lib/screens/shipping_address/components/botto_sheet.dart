import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants.dart';
import 'package:decor/screens/auth/components/custom_text_field.dart';
import 'package:decor/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddShippingAddress extends StatefulWidget {
  AddShippingAddress({required this.data});

  dynamic? data;

  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final _databaseService = DatabaseService();
  final _currentUser = FirebaseAuth.instance.currentUser;
  bool isProgressing = false;

  late TextEditingController _addressTitleController;
  late TextEditingController _addressController;

  late FocusNode _addressTitleFocusNode;
  late FocusNode _addressFocusNode;

  @override
  void initState() {
    super.initState();
    _addressTitleController = TextEditingController();
    _addressController = TextEditingController();

    if (widget.data != null) {
      _addressTitleController.text = widget.data['addressTitle'];
      _addressController.text = widget.data['address'];
    } else {
      _addressTitleController.text = '';
      _addressController.text = '';
    }

    _addressTitleFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _addressTitleController.dispose();
    _addressController.dispose();
    _addressTitleFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        children: [
          CustomTextField(
            label: 'Title',
            controller: _addressTitleController,
            focusNode: _addressTitleFocusNode,
            onSubmitted: (value) {
              fieldFocusChange(
                  context, _addressTitleFocusNode, _addressFocusNode);
            },
            type: TextInputType.text,
          ),
          CustomTextField(
            label: 'Address',
            controller: _addressController,
            focusNode: _addressFocusNode,
            onSubmitted: (value) {
              _addressFocusNode.unfocus();
            },
            type: TextInputType.text,
          ),
          isProgressing
              ? const CustomProgressIndicator()
              : widget.data != null
                  ? CustomButton(
                      label: 'Save',
                      onPressed: () async {
                        if (_addressTitleController.text.isNotEmpty &&
                            _addressController.text.isNotEmpty) {
                          setState(() {
                            isProgressing = true;
                          });
                          try {
                            await _databaseService.updateShippingAddress(
                                doc: widget.data.id,
                                title: _addressTitleController.text,
                                address: _addressController.text);
                            Navigator.pop(context);
                          } catch (e) {}
                        }
                      },
                    )
                  : CustomButton(
                      label: 'Add',
                      onPressed: () async {
                        if (_addressTitleController.text.isNotEmpty &&
                            _addressController.text.isNotEmpty) {
                          setState(() {
                            isProgressing = true;
                          });
                          try {
                            await _databaseService.addShippingAddress(
                                title: _addressTitleController.text,
                                address: _addressController.text);
                            Navigator.pop(context);
                          } catch (e) {}
                        }
                      },
                    ),
        ],
      ),
    );
  }
}
