import 'package:decor/constants/params_constants.dart';
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
  color: Colors.black,
  fontSize: 18,
);

//forgot password style
const kForgotPasswordTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
);

//first heading textStyle
const kFirstHeadingTextStyle = TextStyle(
  fontSize: 26,
  color: Colors.grey,
);

//second heading textStyle
const kSecondHeadingTextStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
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

//gridview text style
const kViewTitleStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16,
  letterSpacing: 2,
  fontWeight: FontWeight.bold,
);
const kViewSubTitleStyle = TextStyle(
  fontSize: kNormalFontSize,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

//profile page
const kProfileTileTitleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
);
const kProfileTileSubTitleTextStyle = TextStyle(fontSize: kNormalFontSize);

//success page
const kSuccessMsgTextStyle = TextStyle(
  fontSize: 22,
  color: Colors.black54,
  fontWeight: FontWeight.w500,
);

//order page
const kOrderBoldTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);
const kOrderTextStyle = TextStyle(fontSize: 18, color: Colors.grey);
const kOrderTabTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

//settings page
const kSettingsHeadingTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

//welcome page
const kWelcomeFirstHeading = TextStyle(
  fontSize: 24,
  letterSpacing: 2,
  color: Colors.grey,
  fontWeight: FontWeight.w500,
);

const kWelcomeSecondHeading = TextStyle(
  fontSize: 26,
  letterSpacing: 2,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);

var kWelcomeContentStyle = TextStyle(
  color: Colors.grey.shade600,
  letterSpacing: 2,
  fontSize: 20,
);

//onBoarding
const kOnBoardingTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  color: Colors.black,
);
const kOnBoardingContentTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

//shipping address
const kShippingAddTextStyle = TextStyle(fontSize: 18, color: Colors.grey);

//physics
const kPhysics = BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

// all categories collection list
final List<String> allCategoriesCollectionList = [
  paramLampsCollection,
  paramStandsCollection,
  paramDesksCollection,
  paramArmchairCollection,
  paramBedsCollection,
  paramChairsCollection,
  paramSofasCollection,
];

/* box decoration */

//box shadow
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

//Tab indicator
BoxDecoration kTabIndicatorDecoration = BoxDecoration(
  color: Colors.black,
  borderRadius: BorderRadius.circular(14),
  shape: BoxShape.rectangle,
);

BoxDecoration kSwipeToAddDecoration = const BoxDecoration(
  color: Colors.green,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

//delete Decoration
BoxDecoration kSwipeToDeleteDecoration = const BoxDecoration(
  color: Colors.red,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
