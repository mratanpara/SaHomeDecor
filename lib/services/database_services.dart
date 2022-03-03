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

  Future<void> addAddress({
    required String fullName,
    required String address,
    required int zipcode,
    required String country,
    required String city,
    required String district,
  }) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .add({
      'fullName': fullName,
      'address': address,
      'zipcode': zipcode,
      'country': country,
      'city': city,
      'district': district,
    });
  }

  Future<void> updateAddress({
    required String doc,
    required String fullName,
    required String address,
    required int zipcode,
    required String country,
    required String city,
    required String district,
  }) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .update({
      'fullName': fullName,
      'address': address,
      'zipcode': zipcode,
      'country': country,
      'city': city,
      'district': district,
    });
  }

  Future<void> deleteShippingAddress(String doc) async {
    await _userCollection
        .doc(_currentUser!.uid)
        .collection('shipping_address')
        .doc(doc)
        .delete();
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

  Future<void> addToCart(Categories cat, dynamic data) async {
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
      }
    });
  }

  Future<void> decreaseItemCount(String doc, int currentItemCount) async {
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
      await deleteFromCart(doc);
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

  Future<void> deleteFromCart(String doc) async {
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
