import 'package:flutter/material.dart';

Color mainTextColor() => Color(0xFF000000);

Color mainColor({double opacity = 1}) {
  if (opacity == 1) return Color(0xFF02457A);

  return Color(((opacity * 255).ceil() << 24) | 0x0002457A);
}

Color accentColor({double opacity = 1}) {

  if (opacity == 1) return Color(0xFFEF4B4C);

  return Color(((opacity * 255).ceil() << 24) | 0x00EF4B4C);
}

Color lightGreyColor() => Color(0xFFECECEC);
Color darkGreyColor() => Color(0xFFA0A0A0);

ThemeData theme() => ThemeData(
  fontFamily: 'AvenirNext',
  primaryColor: mainColor(),
  accentColor: mainColor(),
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: mainTextColor().withOpacity(1),
    ),
    headline5: TextStyle(
      fontSize: 24.0,
      color: mainTextColor(),
      fontWeight: FontWeight.w600,
    ),
    headline4: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: mainTextColor().withOpacity(0.4),
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
    ),
    bodyText2: TextStyle(fontSize: 16.0),
    subtitle2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: mainTextColor().withOpacity(0.4),
    ),
    caption: TextStyle(fontSize: 14.0),
  ),
);

double shimmerTextHeight() => 16.0;