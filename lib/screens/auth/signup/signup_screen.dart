import 'package:decor/components/custom_button.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/users_model.dart';
import 'package:decor/components/custom_text_field.dart';
import 'package:decor/screens/auth/components/facebook_signin_button.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/services/auth_services.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _normalUserPhotoURl =
    'https://banner2.cleanpng.com/20180319/pde/kisspng-computer-icons-icon-design-avatar-flat-face-icon-5ab06e33bee962.122118601521511987782.jpg';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthServices();
  final _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPressed = false;

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final TextEditingController _confirmPasswordController;
  late final FocusNode _nameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  late final FocusNode _confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordController = TextEditingController();

    _nameFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _nameFocus.dispose();
    _confirmPasswordFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _image(size),
                _headingText(size),
                _cardWithTextFieldsAndSignUpButton(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _cardWithTextFieldsAndSignUpButton(Size size) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.01, horizontal: size.height * 0.01),
        child: Container(
          decoration: kBoxShadow,
          child: Card(
            shadowColor: Colors.transparent,
            color: kBgColor,
            child: Padding(
              padding: kCardPadding,
              child: Column(
                children: [
                  _fullNameTextField(),
                  _emailTextField(),
                  _passwordTextField(),
                  _confirmPasswordTextField(),
                  _signupButton(size),
                  _richTextButton(size),
                  const Divider(thickness: 1),
                  _facebookButton(size),
                ],
              ),
            ),
          ),
        ),
      );

  CustomTextField _confirmPasswordTextField() => CustomTextField(
        label: 'Confirm Password',
        hintText: 'Enter Confirm Password',
        controller: _confirmPasswordController,
        type: TextInputType.visiblePassword,
        focusNode: _confirmPasswordFocus,
        onSubmitted: (term) {
          _confirmPasswordFocus.unfocus();
        },
      );

  CustomTextField _passwordTextField() => CustomTextField(
        label: 'Password',
        hintText: 'Enter Password',
        controller: _passwordController,
        focusNode: _passwordFocus,
        type: TextInputType.visiblePassword,
        onSubmitted: (term) {
          fieldFocusChange(context, _passwordFocus, _confirmPasswordFocus);
        },
      );

  CustomTextField _emailTextField() => CustomTextField(
        label: 'Email',
        hintText: 'Enter Email',
        controller: _emailController,
        focusNode: _emailFocus,
        type: TextInputType.emailAddress,
        onSubmitted: (term) {
          fieldFocusChange(context, _emailFocus, _passwordFocus);
        },
      );

  CustomTextField _fullNameTextField() => CustomTextField(
        label: 'Full Name',
        hintText: 'Enter Full Name',
        controller: _nameController,
        focusNode: _nameFocus,
        type: TextInputType.text,
        onSubmitted: (term) {
          fieldFocusChange(context, _nameFocus, _emailFocus);
        },
      );

  Padding _facebookButton(Size size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
        child: FacebookSigninButton(
            label: 'Sign up with Facebook', scaffoldKey: _scaffoldKey),
      );

  void _toggleSpinner() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  Padding _signupButton(Size size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
        child: isPressed
            ? const CustomProgressIndicator()
            : CustomButton(
                label: 'Sign Up',
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty) {
                    _toggleSpinner();
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim());

                      _databaseService.addUsers(Users(
                          displayName: _nameController.text,
                          email: _emailController.text,
                          photoURL: _normalUserPhotoURl));
                      final _prefs = await SharedPreferences.getInstance();
                      _prefs.setBool('isLoggedIn', true);
                      Navigator.pushNamedAndRemoveUntil(
                          context, DashBoard.id, (route) => false);
                    } catch (e) {
                      _toggleSpinner();
                      _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                          content: 'Failed to signup!', color: Colors.red));
                    }
                  } else {
                    _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                        content: 'Required all the fields!',
                        color: Colors.red));
                  }
                },
              ),
      );

  Padding _richTextButton(Size size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: RichText(
            text: const TextSpan(
              text: 'Already have a account? ',
              style: TextStyle(fontSize: kNormalFontSize, color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Padding _headingText(Size size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: Text(
          'welcome'.toUpperCase(),
          style: kSecondHeadingTextStyle,
        ),
      );

  Padding _image(Size size) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.01, horizontal: size.height * 0.02),
        child: Image.asset('assets/images/img.png'),
      );
}
