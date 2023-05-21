import 'package:flutter/material.dart';

class BasicElevatedCard extends StatelessWidget {
  const BasicElevatedCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(0),
  });

  final EdgeInsetsGeometry margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}