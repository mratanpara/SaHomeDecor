import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/constants/params_constants.dart';
import 'package:decor/models/address_model.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/models/users_model.dart';
import 'package:decor/utils/methods/reusable_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _currentUser = FirebaseAuth.instance.currentUser;
  late Users data;

  //add user
  void addUsers(Users user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await _userCollection.doc(currentUser!.uid).set({
      paramDisplayName: user.displayName,
      paramEmail: user.email,
      paramPhotoURL: user.photoURL,
    });
  }

  //address
  Future<void> addAddress(AddressModel addressData) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .add({
      paramFullName: addressData.fullName,
      paramPhone: addressData.phone,
      paramAddress: addressData.address,
      paramZipcode: addressData.zipcode,
      paramCountry: addressData.country,
      paramCity: addressData.city,
      paramState: addressData.state,
      paramIsPrimary: addressData.isPrimary,
    });
  }

  Future<void> updateAddress({
    required String doc,
    required AddressModel addressData,
  }) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .update({
      paramFullName: addressData.fullName,
      paramPhone: addressData.phone,
      paramAddress: addressData.address,
      paramZipcode: addressData.zipcode,
      paramCountry: addressData.country,
      paramCity: addressData.city,
      paramState: addressData.state,
      paramIsPrimary: addressData.isPrimary,
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
              .update({paramIsPrimary: true});
        } else {
          _userCollection
              .doc(_currentUser!.uid)
              .collection('shipping_address')
              .doc(element.id)
              .update({paramIsPrimary: false});
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

  //favourite
  Future<void> addToFavourites(
      Categories cat, GlobalKey<ScaffoldState> _scaffoldKey) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('favourites')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          if (element[paramName] == cat.name) {
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
            paramName: cat.name,
            paramUrl: cat.url,
            paramDesc: cat.desc,
            paramCategory: cat.category,
            paramPrice: cat.price,
            paramStar: cat.star,
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
          paramName: cat.name,
          paramUrl: cat.url,
          paramDesc: cat.desc,
          paramCategory: cat.category,
          paramPrice: cat.price,
          paramStar: cat.star,
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

  //cart
  Future<void> addToCart(
      Categories cat, GlobalKey<ScaffoldState> _scaffoldKey) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          if (element[paramName] == cat.name) {
            await _userCollection
                .doc(_currentUser!.uid)
                .collection('cart')
                .doc(element.id)
                .update(
              {
                paramItemCount: (element[paramItemCount] + 1),
              },
            );
            return;
          }
        }
        if (querySnapshot.docs.isNotEmpty) {
          await _userCollection.doc(_currentUser!.uid).collection('cart').add({
            paramName: cat.name,
            paramUrl: cat.url,
            paramDesc: cat.desc,
            paramCategory: cat.category,
            paramPrice: cat.price,
            paramStar: cat.star,
            paramItemCount: cat.itemCount,
          });
          _scaffoldKey.currentState?.showSnackBar(
              showSnackBar(content: "${cat.name} added to cart !"));
        }
      }
      if (querySnapshot.docs.isEmpty) {
        await _userCollection.doc(_currentUser!.uid).collection('cart').add({
          paramName: cat.name,
          paramUrl: cat.url,
          paramDesc: cat.desc,
          paramCategory: cat.category,
          paramPrice: cat.price,
          paramStar: cat.star,
          paramItemCount: cat.itemCount,
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
          paramItemCount: (currentItemCount - 1),
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
        paramItemCount: (currentItemCount + 1),
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

  //change password
  Future<void> changePassword(String newPassword) async {
    await _currentUser?.updatePassword(newPassword);
  }

  //forgot password
  Future<void> forgotPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
