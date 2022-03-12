import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/users_model.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookSigninButton extends StatefulWidget {
  FacebookSigninButton({required this.label, required this.scaffoldKey});

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
      widget.scaffoldKey.currentState?.showSnackBar(
          showSnackBar(content: 'Failed to login!', color: Colors.red));
    }
  }
}
