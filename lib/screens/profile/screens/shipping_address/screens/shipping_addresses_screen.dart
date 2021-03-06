import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../components/custom_app_bar.dart';
import '../../../../../components/custom_progress_indicator.dart';
import '../../../../../constants/constants.dart';
import '../../../../../constants/params_constants.dart';
import '../../../../../services/database_services.dart';
import '../../../../../utils/methods/get_address_count.dart';
import '../components/add_sipping_address.dart';

class ShippingAddresses extends StatelessWidget {
  static const String id = 'shipping_address';
  ShippingAddresses({Key? key}) : super(key: key);

  final _currentUser = FirebaseAuth.instance.currentUser;
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appbar(context),
      body: _shippingAddressStreamBuilder(),
      floatingActionButton: _addShippingAddressFAB(context),
    );
  }

  CustomAppBar _appbar(BuildContext context) => CustomAppBar(
        title: 'Shipping Address',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  StreamBuilder<QuerySnapshot<Object?>> _shippingAddressStreamBuilder() =>
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser!.uid)
            .collection('shipping_address')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CustomProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomProgressIndicator());
          }
          final data = snapshot.data!.docs;
          return _addressListView(data);
        },
      );

  ListView _addressListView(List<QueryDocumentSnapshot<Object?>> data) =>
      ListView.builder(
        shrinkWrap: true,
        physics: kPhysics,
        itemCount: data.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return _customTile(data, index, context);
        },
      );

  Column _customTile(List<QueryDocumentSnapshot<Object?>> data, int index,
          BuildContext context) =>
      Column(
        children: [
          _setPrimaryAddressCheckBox(data, index),
          _card(data, index, context),
        ],
      );

  Row _setPrimaryAddressCheckBox(
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Row(
        children: [
          Checkbox(
            value: data[index][paramIsPrimary],
            onChanged: (value) {
              _databaseService.setPrimaryShippingAddress(
                  doc: data[index].id, isPrimary: value);
            },
          ),
          const Text(
            'Use as the shipping address',
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
        ],
      );

  Container _card(List<QueryDocumentSnapshot<Object?>> data, int index,
          BuildContext context) =>
      Container(
        decoration: kBoxShadow,
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: kAllPadding,
            child: Column(
              children: [
                _fullNameAndEditDeleteButton(data, index, context),
                const Divider(thickness: 1),
                _address(data, index)
              ],
            ),
          ),
        ),
      );

  Row _fullNameAndEditDeleteButton(List<QueryDocumentSnapshot<Object?>> data,
          int index, BuildContext context) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _fullNameText(data, index),
          _editAndDeleteButton(context, data, index),
        ],
      );

  Text _fullNameText(List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Text(data[index][paramFullName],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold));

  Row _editAndDeleteButton(BuildContext context,
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Row(children: [
        _editButton(context, data, index),
        _deleteButton(context, data, index),
      ]);

  IconButton _editButton(BuildContext context,
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddShippingAddress(
                        data: data[index],
                      )));
        },
        icon: const Icon(
          Icons.edit,
          color: Colors.lightGreen,
        ),
      );

  IconButton _deleteButton(BuildContext context,
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      IconButton(
        onPressed: () async {
          await _databaseService.deleteShippingAddress(data[index].id);
          await getAddressCount(context, _scaffoldKey);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
      );

  Padding _address(List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Padding(
        padding: kSymmetricPaddingVer,
        child: Column(
          children: [
            _areaFlatVillage(data, index),
            _ciyStateZipcode(data, index),
            const Divider(thickness: 1),
            _phoneNumberCountry(data, index),
          ],
        ),
      );

  Align _areaFlatVillage(
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: kSymmetricPaddingVer,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.location_solid,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '${data[index][paramAddress]}',
                  style: kShippingAddTextStyle,
                ),
              ),
            ],
          ),
        ),
      );

  Align _ciyStateZipcode(
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: kSymmetricPaddingVer,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.building_2_fill,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '${data[index][paramCity]}, ${data[index][paramState]} ${data[index][paramZipcode]}'
                      .toUpperCase(),
                  style: kShippingAddTextStyle,
                ),
              ),
            ],
          ),
        ),
      );

  Row _phoneNumberCountry(
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _phoneNumber(data, index),
          Row(
            children: [
              const Icon(
                CupertinoIcons.flag_fill,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                '${data[index][paramCountry]}',
                style: kShippingAddTextStyle,
              ),
            ],
          )
        ],
      );

  Row _phoneNumber(List<QueryDocumentSnapshot<Object?>> data, int index) => Row(
        children: [
          const Icon(
            CupertinoIcons.phone_fill,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(
            '${data[index][paramPhone]}',
            style: kShippingAddTextStyle,
          ),
        ],
      );

  FloatingActionButton _addShippingAddressFAB(BuildContext context) =>
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddShippingAddress(data: null)));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.black,
        ),
      );
}
