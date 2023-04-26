import 'package:flutter/material.dart';

class ScreenWidth {
  double height = 0;
  double width = 0;

  sheight(double value) {
    return height * value / 100;
  }

  swidth(double value) {
    return width * value / 100;
  }

  ScreenWidth(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
  }
}
