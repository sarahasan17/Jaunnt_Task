import 'package:flutter/material.dart';

import '../../config/colors.dart';

class TabButton extends StatefulWidget {
  const TabButton(
      {super.key,
      required this.text,
      required this.active,
      required this.onPressed});

  final String text;
  final bool active;
  final void Function() onPressed;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: widget.active ? primaryDarkColor : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        animationDuration: const Duration(milliseconds: 300),
        foregroundColor: primaryColor,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
            color: widget.active ? textColorWhite : textColorBlack,
            fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}
