import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/amount_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _currentUser = FirebaseAuth.instance.currentUser;
final _usersCollection = FirebaseFirestore.instance.collection('users');

Future<void> getTotalAmount(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
  try {
    await _usersCollection
        .doc(_currentUser!.uid)
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      Provider.of<AmountProvider>(context, listen: false)
          .setTotalAmount(querySnapshot.docs);
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}
