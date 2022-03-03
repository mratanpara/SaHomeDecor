import 'package:decor/providers/address_provider.dart';
import 'package:decor/providers/common_provider.dart';
import 'package:decor/screens/auth/forgot_password/forgot_password.dart';
import 'package:decor/screens/auth/login/screen/login_screen.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/screens/favourite/favourite_screen.dart';
import 'package:decor/screens/home/home_screen.dart';
import 'package:decor/screens/notification/notification_screen.dart';
import 'package:decor/screens/profile/screens/change_password.dart';
import 'package:decor/screens/profile/screens/profile_screen.dart';
import 'package:decor/screens/shipping_address/shipping_addresses_screen.dart';
import 'package:decor/screens/splash_screen/splash_screen.dart';
import 'package:decor/screens/success/success_screen.dart';
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
      create: (BuildContext context) => CommonProvider(),
      child: MaterialApp(
        title: 'SaHomeDecor',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          DashBoard.id: (context) => const DashBoard(),
          HomeScreen.id: (context) => const HomeScreen(),
          FavouriteScreen.id: (context) => const FavouriteScreen(),
          NotificationScreen.id: (context) => const NotificationScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          SuccessScreen.id: (context) => SuccessScreen(),
          ChangePassword.id: (context) => ChangePassword(),
          ForgotPassword.id: (context) => ForgotPassword(),
          SplashScreen.id: (context) => SplashScreen(),
          CartScreen.id: (context) => const CartScreen(),
          ShippingAddresses.id: (context) => const ShippingAddresses(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
        },
        theme: lightTheme(),
      ),
    );
  }
}
