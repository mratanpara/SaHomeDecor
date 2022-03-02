import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/constants/refresh_indicator.dart';
import 'package:decor/screens/shipping_address/components/add_sipping_address.dart';
import 'package:decor/screens/shipping_address/components/botto_sheet.dart';
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
  dynamic addressData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shipping Address',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: CommonRefreshIndicator(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser!.uid)
              .collection('shipping_address')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomProgressIndicator());
            }
            final data = snapshot.data!.docs;
            addressData = data;
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: data.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'Use as the shipping address',
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ],
                    ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data[index]['fullName'],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                  Row(children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddShippingAddress(
                                                      data: addressData[index],
                                                    )));
                                        print(addressData[index]);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _confirmationAlertDialog(
                                            context, data[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: kSymmetricPaddingVer,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${data[index]['address']}, ${data[index]['city']}, - ${data[index]['zipcode']}',
                                    style: const TextStyle(
                                        fontSize: kNormalFontSize,
                                        color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }

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
            TextButton(
                onPressed: () {
                  _databaseService.deleteShippingAddress(dataId);
                  Navigator.pop(context);
                },
                child: const Text('Yes')),
          ],
        ),
      );

  Future<dynamic> _addShippingAddressBottomSheet(BuildContext context,
          [dynamic data]) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BottomAddShippingAddress(data: data),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      );
}
