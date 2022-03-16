import 'dart:io';
import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";

class PrivacyPolicyScreen extends StatefulWidget {
  static const String id = 'privacy_policy_screen';

  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  @override
  PrivacyPolicyScreenState createState() => PrivacyPolicyScreenState();
}

class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: WebView(
        initialUrl: 'https://policies.google.com/privacy?hl=en',
      ),
    );
  }
}
