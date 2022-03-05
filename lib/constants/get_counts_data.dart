import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/providers/common_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

final _currentUser = FirebaseAuth.instance.currentUser;
final _usersCollection = FirebaseFirestore.instance.collection('users');

Future<void> getAddressCount(BuildContext context) async {
  try {
    await _usersCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .get()
        .then((QuerySnapshot querySnapshot) {
      Provider.of<CommonProvider>(context, listen: false)
          .setAddressCount(querySnapshot.docs.length);
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> getTotalAmount(BuildContext context) async {
  try {
    await _usersCollection
        .doc(_currentUser!.uid)
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      Provider.of<CommonProvider>(context, listen: false)
          .setTotalAmount(querySnapshot.docs);
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}

// return;
