import 'package:flutter/material.dart';

//icon size
const double kIconSize = 28;

//normal font size
const double kNormalFontSize = 16;

//padding
const kAllPadding = EdgeInsets.all(20);
const kCardPadding = EdgeInsets.all(10);
const kSymmetricPaddingVer = EdgeInsets.symmetric(vertical: 10);
const kBottomPadding = EdgeInsets.only(bottom: 10);
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

//boxshadow
BoxDecoration kBoxShadow = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(.2),
      blurRadius: 20.0, // soften the shadow
      spreadRadius: 0.0, //extend the shadow
      offset: const Offset(
        2.0, // Move to right 10  horizontally
        2.0, // Move to bottom 10 Vertically
      ),
    )
  ],
);

//gridview text style
const kViewTitleStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18,
  letterSpacing: 2,
  fontWeight: FontWeight.bold,
);
const kViewSubTitleStyle = TextStyle(
  fontSize: kNormalFontSize,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

//profile
const kProfileTileTitleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
);
const kProfileTileSubTitleTextStyle = TextStyle(fontSize: kNormalFontSize);

//change the focus of text field
void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
