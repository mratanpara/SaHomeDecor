import '../screens/auth/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  //create user with email & pass
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //signin with email & password
  Future<void> signinWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  //facebook login
  Future<void> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    await _auth.signInWithCredential(facebookAuthCredential);
  }

  //sign out
  Future<void> signOutUser(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isLoggedIn', false);
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  }
}
