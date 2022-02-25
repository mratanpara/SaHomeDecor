import 'package:flutter/material.dart';

//icon size
const double kIconSize = 26;

//normal font size
const double kNormalFontSize = 20;

//padding
const kAllPadding = EdgeInsets.all(20);
const kCardPadding = EdgeInsets.all(10);
const kSymmetricPaddingVer = EdgeInsets.symmetric(vertical: 10);
const kSymmetricPaddingHor = EdgeInsets.symmetric(horizontal: 20);

//bgColor
const kBgColor = Colors.white;

//TextField lable style
const kTextFieldLabelStyle = TextStyle(
  color: Colors.grey,
  fontSize: kNormalFontSize,
);

//forgot password style
const kForgotPasswordTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
);

//first heading textstyle
const kFirstHeadingTextStyle = TextStyle(
  fontSize: 26,
  color: Colors.grey,
);

//second heading textstyle
const kSecondHeadingTextStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

//Tab indicator
BoxDecoration kTabIndicatorDecoration = BoxDecoration(
  color: Colors.black,
  borderRadius: BorderRadius.circular(14),
  shape: BoxShape.rectangle,
);

//app bar text style
const kFirstTitleTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18,
);
const kSecondTitleTextStyle = TextStyle(
  fontSize: 20,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);
