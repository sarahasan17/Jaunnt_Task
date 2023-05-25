import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';

class ExperienceTab extends StatelessWidget {
  const ExperienceTab(
      {super.key, required this.placeName, required this.description});

  final String placeName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(left: 17, right: 17, bottom: 5),
            child: BasicElevatedCard(
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
          );
        });
  }
}