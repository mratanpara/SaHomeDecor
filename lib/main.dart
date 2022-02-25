import 'package:decor/screens/auth/login/screen/login_screen.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:decor/screens/home_screen.dart';
import 'package:decor/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaHomeDecor',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
      },
      theme: lightTheme(),
      home: const LoginScreen(),
    );
  }
}
