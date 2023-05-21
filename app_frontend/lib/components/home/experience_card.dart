import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';
import '../common/image_carousel.dart';

const double avatarRadius = 20;

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.images, required this.profileName, required this.placeName, required this.description});

  final List<String> images;
  final String profileName;
  final String placeName;
  final String description;

  Widget _getBottomInfoWidget() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: avatarRadius,
                    child: Text(
                      profileName[0],
                      style: TextStyle(color: textColorWhite, fontSize: 28),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      constraints: const BoxConstraints(minHeight: 2 * avatarRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            profileName,
                            style: TextStyle(color: textColorWhite, fontSize: 18, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          Text(
                            placeName,
                            style: TextStyle(color: textColorWhite, fontSize: 14, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              (description == "") ? const SizedBox.shrink() : Container(
                padding: const EdgeInsets.fromLTRB(12, 6, 0, 0),
                child: Text(
                  description,
                  style: TextStyle(color: textColorWhite, fontSize: 12, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if ((profileName == "") || (images.isEmpty)) {
      // Empty Widget
      return const SizedBox.shrink();
    }

    return Center(
      child: BasicElevatedCard(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ImageCarousel(
          images: images,
          bottomInfoWidget: _getBottomInfoWidget(),
        ),
      ),
    );
  }
}