import 'package:decor/providers/common_provider.dart';
import 'package:decor/screens/auth/forgot_password/forgot_password.dart';
import 'package:decor/screens/auth/login/login_screen.dart';
import 'package:decor/screens/auth/signup/signup_screen.dart';
import 'package:decor/screens/cart/cart_screen.dart';
import 'package:decor/screens/dashboard/dashboard.dart';
import 'package:decor/screens/favourite/favourite_screen.dart';
import 'package:decor/screens/home/screens/home_screen.dart';
import 'package:decor/screens/notification/notification_screen.dart';
import 'package:decor/screens/onboarding/onboarding.dart';
import 'package:decor/screens/profile/components/add_payment_method.dart';
import 'package:decor/screens/profile/screens/change_password/change_password.dart';
import 'package:decor/screens/profile/screens/myorder/myorder_screen.dart';
import 'package:decor/screens/profile/screens/payment_method/payment_method_screen.dart';
import 'package:decor/screens/profile/screens/profile_screen.dart';
import 'package:decor/screens/profile/screens/myreviews/reviews_screen.dart';
import 'package:decor/screens/profile/screens/settings/screens/faqs_screen.dart';
import 'package:decor/screens/profile/screens/settings/screens/privacy_policy.dart';
import 'package:decor/screens/profile/screens/settings/screens/terms_and_conditions.dart';
import 'package:decor/screens/search_screen/search_screen.dart';
import 'package:decor/screens/shipping_address/screens/shipping_addresses_screen.dart';
import 'package:decor/screens/splash_screen/splash_screen.dart';
import 'package:decor/screens/success/success_screen.dart';
import 'package:decor/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _route = {
    DashBoard.id: (context) => const DashBoard(),
    HomeScreen.id: (context) => const HomeScreen(),
    FavouriteScreen.id: (context) => const FavouriteScreen(),
    NotificationScreen.id: (context) => const NotificationScreen(),
    ProfileScreen.id: (context) => const ProfileScreen(),
    SuccessScreen.id: (context) => SuccessScreen(),
    ChangePassword.id: (context) => ChangePassword(),
    ForgotPassword.id: (context) => ForgotPassword(),
    OrderScreen.id: (context) => const OrderScreen(),
    PaymentMethodScreen.id: (context) => const PaymentMethodScreen(),
    AddPaymentMethod.id: (context) => AddPaymentMethod(),
    ReviewsScreen.id: (context) => const ReviewsScreen(),
    SearchScreen.id: (context) => const SearchScreen(),
    SplashScreen.id: (context) => SplashScreen(),
    CartScreen.id: (context) => const CartScreen(),
    ShippingAddresses.id: (context) => const ShippingAddresses(),
    LoginScreen.id: (context) => const LoginScreen(),
    SignupScreen.id: (context) => const SignupScreen(),
    FAQsScreen.id: (context) => FAQsScreen(),
    TermsAndConditionsScreen.id: (context) => TermsAndConditionsScreen(),
    PrivacyPolicyScreen.id: (context) => PrivacyPolicyScreen(),
    OnBoarding.id: (context) => const OnBoarding(),
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CommonProvider(),
      child: MaterialApp(
        title: 'SaHomeDecor',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: _route,
        theme: lightTheme(),
      ),
    );
  }
}
