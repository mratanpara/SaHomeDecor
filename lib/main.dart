import 'package:decor/components/custom_bottom_navigation_bar.dart';
import 'package:decor/models/bottom_nav_bar_index.dart';
import 'package:decor/screens/auth/login/screen/login_screen.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/screens/favorite/favorite_screen.dart';
import 'package:decor/screens/home/home_screen.dart';
import 'package:decor/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BottomNavBarIndex(),
      child: MaterialApp(
        title: 'SaHomeDecor',
        debugShowCheckedModeBanner: false,
        initialRoute: DashBoard.id,
        routes: {
          DashBoard.id: (context) => const DashBoard(),
          HomeScreen.id: (context) => const HomeScreen(),
          FavoriteScreen.id: (context) => const FavoriteScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
        },
        theme: lightTheme(),
        home: const LoginScreen(),
      ),
    );
  }
}
