import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatabaseService {
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _currentUser = FirebaseAuth.instance.currentUser;
  late Users data;

  void addUsers(Users user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await _userCollection.doc(currentUser!.uid).set({
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
    });
  }

  Future<void> addShippingAddress(
      {required String title, required String address}) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .add({
      'addressTitle': title,
      'address': address,
    });
  }

  Future<void> deleteShippingAddress(String doc) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .delete();
  }

  Future<void> updateShippingAddress(
      {required String doc,
      required String title,
      required String address}) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .update({
      'addressTitle': title,
      'address': address,
    });
  }

  Future<void> addToFavourites(Categories cat) async {
    await _userCollection.doc(_currentUser!.uid).collection('favourites').add({
      'name': cat.name,
      'url': cat.url,
      'desc': cat.desc,
      'category': cat.category,
      'price': cat.price,
      'star': cat.star,
    });
  }

  Future<void> deleteFromFavourite(String doc) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('favourites')
        .doc(doc)
        .delete();
  }
}
