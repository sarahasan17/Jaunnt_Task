import 'package:flutter/material.dart';

int primaryColorCode      = 0xFFADC8CE;
int primaryDarkColorCode  = 0xFF00425A;
int bgFillColorCode       = 0xFFD8E9EB;

Color primaryColor          = Color(primaryColorCode);
Color primaryDarkColor      = Color(primaryDarkColorCode);
Color bgFillColor           = Color(bgFillColorCode);
Color textColorWhite        = const Color(0xFFFFFFFF);
Color textColorBlack        = const Color(0xFF262626);
Color textColorPrimaryDark  = Color(primaryDarkColorCode);

MaterialColor primaryColorSpectrum = MaterialColor(primaryColorCode, {
  50: primaryColor.withOpacity(0.1),
  100: primaryColor.withOpacity(0.2),
  200: primaryColor.withOpacity(0.3),
  300: primaryColor.withOpacity(0.4),
  400: primaryColor.withOpacity(0.5),
  500: primaryColor.withOpacity(0.6),
  600: primaryColor.withOpacity(0.7),
  700: primaryColor.withOpacity(0.8),
  800: primaryColor.withOpacity(0.9),
  900: primaryColor.withOpacity(1.0),
});

MaterialColor primaryDarkColorSpectrum = MaterialColor(primaryDarkColorCode, {
  50: primaryDarkColor.withOpacity(0.1),
  100: primaryDarkColor.withOpacity(0.2),
  200: primaryDarkColor.withOpacity(0.3),
  300: primaryDarkColor.withOpacity(0.4),
  400: primaryDarkColor.withOpacity(0.5),
  500: primaryDarkColor.withOpacity(0.6),
  600: primaryDarkColor.withOpacity(0.7),
  700: primaryDarkColor.withOpacity(0.8),
  800: primaryDarkColor.withOpacity(0.9),
  900: primaryDarkColor.withOpacity(1.0),
});
