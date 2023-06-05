import 'package:app_frontend/screen/Place_DetailedScreen/ExperienceOfPlace/data/experienceofplace_response.dart';
import 'package:app_frontend/screen/Place_DetailedScreen/data/Place_Detailedscreen_response.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';

class ExperienceTab extends StatelessWidget {
  ExperienceTab({super.key, required this.place});
  ExperienceOfPlaceResponse place;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: place.experienceOfPlaceResponse.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(left: 17, right: 17, bottom: 5),
            child: BasicElevatedCard(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        place.experienceOfPlaceResponse[index].postedBy,
                        style: TextStyle(
                            color: textColorPrimaryDark,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        place.experienceOfPlaceResponse[index].discription,
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
