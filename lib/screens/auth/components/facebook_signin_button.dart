// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/custom_progress_indicator.dart';
import '../../../constants/constants.dart';
import '../../../models/users_model.dart';
import '../../../services/auth_services.dart';
import '../../../services/database_services.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../dashboard/dashboard.dart';

class FacebookSigninButton extends StatefulWidget {
  const FacebookSigninButton({required this.label, required this.scaffoldKey});

  final String label;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<FacebookSigninButton> createState() => _FacebookSigninButtonState();
}

class _FacebookSigninButtonState extends State<FacebookSigninButton> {
  bool isPressed = false;
  final _auth = AuthServices();
  final _databaseService = DatabaseService();

  void _toggleSpinner() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: isPressed
          ? const CustomProgressIndicator()
          : _facebookButton(context),
    );
  }

  ElevatedButton _facebookButton(BuildContext context) => ElevatedButton.icon(
        onPressed: _onPressed,
        label: Text(widget.label),
        icon: const Icon(Icons.facebook, size: 32),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: kNormalFontSize,
          ),
        ),
      );

  void _onPressed() async {
    _toggleSpinner();
    try {
      await _auth.signInWithFacebook();
      final currentUser = FirebaseAuth.instance.currentUser;
      _databaseService.addUsers(Users(
        displayName: currentUser!.displayName.toString(),
        email: currentUser.email.toString(),
        photoURL: currentUser.photoURL.toString(),
      ));
      final _prefs = await SharedPreferences.getInstance();
      _prefs.setBool('isLoggedIn', true);
      Navigator.pushNamedAndRemoveUntil(
          context, DashBoard.id, (route) => false);
    } catch (e) {
      _toggleSpinner();
      widget.scaffoldKey.currentState
          ?.showSnackBar(showSnackBar(content: 'Failed to login!'));
    }
  }
}
