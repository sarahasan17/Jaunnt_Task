import 'package:flutter/material.dart';

import '../../config/colors.dart';

class TabButton extends StatelessWidget {
  const TabButton(
      {super.key,
      required this.text,
      required this.active,
      required this.onPressed});

  final String text;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: active ? primaryDarkColor : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        animationDuration: const Duration(milliseconds: 300),
        foregroundColor: primaryColor,
      ),
      child: Text(
        text,
        style: TextStyle(
            color: active ? textColorWhite : textColorBlack, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}
