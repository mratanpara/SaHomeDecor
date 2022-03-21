import 'package:decor/constants/params_constants.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  String displayName = '';
  String email = '';
  String photoURL = '';

  void updateCurrentUser(snapshot) {
    displayName = snapshot.get(paramDisplayName);
    email = snapshot.get(paramEmail);
    photoURL = snapshot.get(paramPhotoURL);
    notifyListeners();
  }

  String get userDisplayName => displayName;
  String get userEmail => email;
  String get userPhotoUrl => photoURL;
}
