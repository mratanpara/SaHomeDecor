import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/address_provider.dart';
import 'providers/amount_provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/auth/forgot_password/forgot_password.dart';
import 'screens/auth/login/login_screen.dart';
import 'screens/auth/signup/signup_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/favourite/favourite_screen.dart';
import 'screens/home/screens/home_screen.dart';
import 'screens/notification/notification_screen.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/profile/screens/change_password/change_password.dart';
import 'screens/profile/screens/myorder/myorder_screen.dart';
import 'screens/profile/screens/myreviews/reviews_screen.dart';
import 'screens/profile/screens/payment_method/components/add_payment_method.dart';
import 'screens/profile/screens/payment_method/payment_method_screen.dart';
import 'screens/profile/screens/profile_screen.dart';
import 'screens/profile/screens/settings/screens/faqs_screen.dart';
import 'screens/profile/screens/settings/screens/privacy_policy.dart';
import 'screens/profile/screens/settings/screens/terms_and_conditions.dart';
import 'screens/search_screen/search_screen.dart';
import 'screens/shipping_address/screens/shipping_addresses_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/success/success_screen.dart';
import 'providers/theme_provider.dart';

final _route = {
  DashBoard.id: (context) => const DashBoard(),
  HomeScreen.id: (context) => const HomeScreen(),
  FavouriteScreen.id: (context) => FavouriteScreen(),
  NotificationScreen.id: (context) => const NotificationScreen(),
  ProfileScreen.id: (context) => const ProfileScreen(),
  SuccessScreen.id: (context) => const SuccessScreen(),
  ChangePassword.id: (context) => const ChangePassword(),
  ForgotPassword.id: (context) => const ForgotPassword(),
  OrderScreen.id: (context) => const OrderScreen(),
  PaymentMethodScreen.id: (context) => const PaymentMethodScreen(),
  AddPaymentMethod.id: (context) => const AddPaymentMethod(),
  ReviewsScreen.id: (context) => const ReviewsScreen(),
  SearchScreen.id: (context) => const SearchScreen(),
  SplashScreen.id: (context) => const SplashScreen(),
  CartScreen.id: (context) => const CartScreen(),
  ShippingAddresses.id: (context) => ShippingAddresses(),
  LoginScreen.id: (context) => const LoginScreen(),
  SignupScreen.id: (context) => const SignupScreen(),
  FAQsScreen.id: (context) => const FAQsScreen(),
  TermsAndConditionsScreen.id: (context) => const TermsAndConditionsScreen(),
  PrivacyPolicyScreen.id: (context) => const PrivacyPolicyScreen(),
  OnBoarding.id: (context) => const OnBoarding(),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AddressProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AmountProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            ThemeProvider(isDarkMode: prefs.getBool("isDarkTheme") ?? false),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: 'Asap'),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'SaHomeDecor',
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.id,
            routes: _route,
            theme: themeProvider.getTheme,
          );
        },
      ),
    );
  }
}
