import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final _categories = FirebaseFirestore.instance.collection('categories');
  final _users = FirebaseFirestore.instance.collection('users');
  late Users data;

  void addUsers(Users user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await _users.doc(currentUser!.uid).set({
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
    });
  }

  Future<DocumentSnapshot?> getCurrentUser(String uid) async {
    await _users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot;
      }
    });
  }
}
