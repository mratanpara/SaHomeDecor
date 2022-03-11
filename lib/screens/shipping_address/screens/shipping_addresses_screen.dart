import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/get_counts_data.dart';
import 'package:decor/screens/shipping_address/components/add_sipping_address.dart';
import 'package:decor/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShippingAddresses extends StatefulWidget {
  static const String id = 'shipping_address';
  const ShippingAddresses({Key? key}) : super(key: key);

  @override
  _ShippingAddressesState createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
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

  Padding _address(List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Padding(
        padding: kSymmetricPaddingVer,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            '${data[index]['address']} ${data[index]['city']} - ${data[index]['zipcode']}',
            style:
                const TextStyle(fontSize: kNormalFontSize, color: Colors.grey),
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

  Row _editAndDeleteButton(BuildContext context,
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Row(children: [
        _editButton(context, data, index),
        _deleteButton(context, data, index),
      ]);

  IconButton _deleteButton(BuildContext context,
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      IconButton(
        onPressed: () async {
          await _databaseService.deleteShippingAddress(data[index].id);
          Navigator.pop(context);
          await getAddressCount(context, _scaffoldKey);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
      );

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

  Text _fullNameText(List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Text(data[index]['fullName'],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold));

  Row _setPrimaryAddressCheckBox(
          List<QueryDocumentSnapshot<Object?>> data, int index) =>
      Row(
        children: [
          Checkbox(
            activeColor: Colors.black,
            value: data[index]['isPrimary'],
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

  CustomAppBar _appbar(BuildContext context) => CustomAppBar(
        title: 'Shipping Address',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Future<dynamic> _confirmationAlertDialog(
          BuildContext context, String dataId) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Are you sure you want to delete!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(onPressed: () async {}, child: const Text('Yes')),
          ],
        ),
      );
}
