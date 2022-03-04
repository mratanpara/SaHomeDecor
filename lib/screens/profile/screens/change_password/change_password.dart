import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/components/custom_text_field.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'change_password';

  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _databaseService = DatabaseService();
  final _authService = AuthServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController _newPasswordController;
  late FocusNode _newPasswordFocus;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();

    _newPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();

    _newPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Change Password',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: kAllPadding,
        child: SingleChildScrollView(
          physics: kPhysics,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Change Password!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: kSymmetricPaddingVer,
                child: Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/success_screen/background.png'),
                    Image.asset('assets/images/success_screen/Group.png'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: kBoxShadow,
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: kAllPadding,
                    child: Column(
                      children: [
                        CustomTextField(
                          onSubmitted: (val) {
                            _newPasswordFocus.unfocus();
                          },
                          type: TextInputType.text,
                          label: 'Password',
                          hintText: 'Enter new password',
                          controller: _newPasswordController,
                          focusNode: _newPasswordFocus,
                        ),
                        CustomButton(
                          label: 'SAVE PASSWORD',
                          onPressed: () async {
                            if (_newPasswordController.text.isNotEmpty) {
                              await _databaseService.changePassword(
                                  _newPasswordController.text.trim());

                              await _authService.signOutUser();
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
