import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> addAddress({
    required String fullName,
    required int phone,
    required String address,
    required int zipcode,
    required String country,
    required String city,
    required String state,
  }) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .add({
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'zipcode': zipcode,
      'country': country,
      'city': city,
      'state': state,
      'isPrimary': false,
    });
  }

  Future<void> updateAddress({
    required String doc,
    required String fullName,
    required int phone,
    required String address,
    required int zipcode,
    required String country,
    required String city,
    required String state,
    required bool isPrimary,
  }) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .update({
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'zipcode': zipcode,
      'country': country,
      'city': city,
      'state': state,
      'isPrimary': isPrimary,
    });
  }

  Future<void> setPrimaryShippingAddress(
      {required String doc, required bool? isPrimary}) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var element in querySnapshot.docs) {
        if (element.id == doc) {
          _userCollection
              .doc(_currentUser!.uid)
              .collection('shipping_address')
              .doc(doc)
              .update({'isPrimary': true});
        } else {
          _userCollection
              .doc(_currentUser!.uid)
              .collection('shipping_address')
              .doc(element.id)
              .update({'isPrimary': false});
        }
      }
    });
  }

  Future<void> deleteShippingAddress(String doc) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .delete();
  }

  Future<void> addToFavourites(
      Categories cat, GlobalKey<ScaffoldState> _scaffoldKey) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('favourites')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          if (element['name'] == cat.name) {
            _scaffoldKey.currentState
                ?.showSnackBar(showSnackBar(content: 'Already in favourites!'));
            return;
          }
        }
        if (querySnapshot.docs.isNotEmpty) {
          await _userCollection
              .doc(_currentUser!.uid)
              .collection('favourites')
              .add({
            'name': cat.name,
            'url': cat.url,
            'desc': cat.desc,
            'category': cat.category,
            'price': cat.price,
            'star': cat.star,
          });
          _scaffoldKey.currentState?.showSnackBar(
              showSnackBar(content: "${cat.name} added to favourites !"));
        }
      }
      if (querySnapshot.docs.isEmpty) {
        await _userCollection
            .doc(_currentUser!.uid)
            .collection('favourites')
            .add({
          'name': cat.name,
          'url': cat.url,
          'desc': cat.desc,
          'category': cat.category,
          'price': cat.price,
          'star': cat.star,
        });
        _scaffoldKey.currentState?.showSnackBar(
            showSnackBar(content: "${cat.name} added to favourites !"));
      }
    });
  }

  Future<void> deleteFromFavourite(
      String doc, GlobalKey<ScaffoldState> _scaffoldKey) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('favourites')
        .doc(doc)
        .delete();
  }

  Future<void> addToCart(
      Categories cat, GlobalKey<ScaffoldState> _scaffoldKey) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          if (element['name'] == cat.name) {
            await _userCollection
                .doc(_currentUser!.uid)
                .collection('cart')
                .doc(element.id)
                .update(
              {
                'itemCount': (element['itemCount'] + 1),
              },
            );
            return;
          }
        }
        if (querySnapshot.docs.isNotEmpty) {
          await _userCollection.doc(_currentUser!.uid).collection('cart').add({
            'name': cat.name,
            'url': cat.url,
            'desc': cat.desc,
            'category': cat.category,
            'price': cat.price,
            'star': cat.star,
            'itemCount': cat.itemCount,
          });
          _scaffoldKey.currentState?.showSnackBar(
              showSnackBar(content: "${cat.name} added to cart !"));
        }
      }
      if (querySnapshot.docs.isEmpty) {
        await _userCollection.doc(_currentUser!.uid).collection('cart').add({
          'name': cat.name,
          'url': cat.url,
          'desc': cat.desc,
          'category': cat.category,
          'price': cat.price,
          'star': cat.star,
          'itemCount': cat.itemCount,
        });
        _scaffoldKey.currentState?.showSnackBar(
            showSnackBar(content: "${cat.name} added to cart !"));
      }
    });
  }

  Future<void> decreaseItemCount(String doc, int currentItemCount,
      GlobalKey<ScaffoldState> _scaffoldKey) async {
    if (currentItemCount != 1) {
      await _userCollection
          .doc(_currentUser!.uid)
          .collection('cart')
          .doc(doc)
          .update(
        {
          'itemCount': (currentItemCount - 1),
        },
      );
    } else {
      await deleteFromCart(doc, _scaffoldKey);
    }
  }

  Future<void> increaseItemCount(String doc, int currentItemCount) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('cart')
        .doc(doc)
        .update(
      {
        'itemCount': (currentItemCount + 1),
      },
    );
  }

  Future<void> deleteFromCart(
      String doc, GlobalKey<ScaffoldState> _scaffoldKey) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('cart')
        .doc(doc)
        .delete();
  }

  Future<void> changePassword(String newPassword) async {
    await _currentUser?.updatePassword(newPassword);
  }

  Future<void> forgotPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
