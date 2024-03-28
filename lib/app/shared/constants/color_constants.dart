import 'package:flutter/material.dart';

class ColorConstants {
  static Color gray50 = hexToColor('#e9e9e9');
  static Color gray100 = hexToColor('#bdbebe');
  static Color gray200 = hexToColor('#929293');
  static Color gray300 = hexToColor('#666667');
  static Color gray400 = hexToColor('#505151');
  static Color gray500 = hexToColor('#242526');
  static Color gray600 = hexToColor('#202122');
  static Color gray700 = hexToColor('#191a1b');
  static Color gray800 = hexToColor('#121313');
  static Color gray900 = hexToColor('#0e0f0f');
  static  Color? scaffoldBackground = Colors.grey[100];

  //black
  static Color black100 = hexToColor('#000000');

  static Color textcolor = hexToColor('#000000');

  //green
  static Color green100 = hexToColor('#7BB274');

  //white
  static Color white100 = hexToColor('#FFFFFF');
  //green
  static Color orange100 = hexToColor('#FFA500');
  static Color fadedgrey = hexToColor('#f2f2f2');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xFF000000 : 0x00000000));
}

class LightColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = Color(0xff1d2635);
  static const Color subTitleTextColor =  Color(0xff797878);

  static const Color skyBlue = Color(0xff2890c8);
  static const Color lightBlue = Color(0xff5c3dff);

  static const Color blackBold = Color(0xff1D1E20);


  static const Color orange = Color(0xffE65829);
  static const Color red = Color(0xffF72804);

  static const Color lightGrey = Color(0xffE1E2E4);
  static const Color lightGrey1 = Color(0xffececec);
  static const Color grey = Color(0xffA1A3A6);
  static const Color darkgrey = Color(0xff747F8F);

  static const Color iconColor = Color(0xffa8a09b);
  static const Color yellowColor = Color(0xfffbba01);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);

  static const Color facebookcolor = Color(0xff4267B2);
  static const Color twittercolor = Color(0xff1DA1F2);
  static const Color googlecolor = Color(0xffEA4335);

  static const Color buttongradient1 = Color(0xffFEB62B);
  static const Color buttongradient2 = Color(0xffFFCC4A);
  static const Color greycolor = Color(0xff8F959E);
  static const Color redcolor = Color(0xffEA4335);
  static const Color whitecolor = Color(0xffFEFEFE);
  static const Color textcolor = Color(0xff1D1E20);
  static const Color whitecolor1 = Color(0xffF5F6FA);
  static const Color cardcolor = Color(0xffF5F6FA);
  static const Color logoutTextColor = Color(0xffFF5757);
  static const Color fadedgrey = Color(0xffF5F6FA);
  static const Color fadedgrey1 = Color(0xffeeeef7);
  static const Color fadedred= Color(0xffff8486);
  static const Color red200= Color(0xffEF9A9A);
  static const Color lightBlue100= Color(0xffB3E5FC);
  static const Color lightBlue200= Color(0xff81D4FA);
  static const Color green200= Color(0xffA5D6A7);
  static const Color green300= Color(0xff81C784);
  static const Color green400= Color(0xff66BB6A);
  static const Color blue300= Color(0xff64B5F6);
  static const Color blue200= Color(0xff90CAF9);
  static const Color yellow300= Color(0xffFFB74D);
  static const Color yellow200= Color(0xffFFF176);
  static const Color gray300= Color(0xffD6D6D6);
  static const Color gray400= Color(0xffBDBDBD);
  static const Color primary= Color(0xff17B5B6);
  static const Color fadedPrimary= Color(0xffD4F5F6);
  static const Color bgPrimary= Color(0xff4EC9CA);

//blue
// static const Color blue300= Color(0xff64B5F6);

}