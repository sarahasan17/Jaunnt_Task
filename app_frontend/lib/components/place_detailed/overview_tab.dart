import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab(
      {super.key, required this.placeName, required this.description});

  final String placeName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        BasicElevatedCard(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    placeName,
                    style: TextStyle(
                        color: textColorPrimaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: textColorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
        BasicElevatedCard(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    placeName,
                    style: TextStyle(
                        color: textColorPrimaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: textColorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
        BasicElevatedCard(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    placeName,
                    style: TextStyle(
                        color: textColorPrimaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: textColorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
        BasicElevatedCard(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    placeName,
                    style: TextStyle(
                        color: textColorPrimaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: textColorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
        BasicElevatedCard(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    placeName,
                    style: TextStyle(
                        color: textColorPrimaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: textColorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
