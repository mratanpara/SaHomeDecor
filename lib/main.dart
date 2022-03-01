import 'package:decor/models/bottom_nav_bar_index.dart';
import 'package:decor/screens/auth/login/screen/login_screen.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/screens/favourite/favourite_screen.dart';
import 'package:decor/screens/home/home_screen.dart';
import 'package:decor/screens/notification/notification_screen.dart';
import 'package:decor/screens/profile/profile_screen.dart';
import 'package:decor/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        initialRoute: LoginScreen.id,
        routes: {
          DashBoard.id: (context) => const DashBoard(),
          HomeScreen.id: (context) => const HomeScreen(),
          FavouriteScreen.id: (context) => const FavouriteScreen(),
          NotificationScreen.id: (context) => const NotificationScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          CartScreen.id: (context) => const CartScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
        },
        theme: lightTheme(),
      ),
    );
  }
}
