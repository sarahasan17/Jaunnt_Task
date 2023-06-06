import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';
import '../common/image_carousel.dart';

const double avatarRadius = 20;

class ExperienceCard extends StatefulWidget {
  const ExperienceCard(
      {super.key,
      required this.images,
      required this.profileName,
      required this.placeName,
      required this.description});

  final List<String> images;
  final String profileName;
  final String placeName;
  final String description;

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
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
                      widget.profileName[0],
                      style: TextStyle(color: textColorWhite, fontSize: 28),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      constraints:
                          const BoxConstraints(minHeight: 2 * avatarRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.profileName,
                            style: TextStyle(
                                color: textColorWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          Text(
                            widget.placeName,
                            style: TextStyle(
                                color: textColorWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              (widget.description == "")
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.fromLTRB(12, 6, 0, 0),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            color: textColorWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis),
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
    if ((widget.profileName == "") || (widget.images.isEmpty)) {
      // Empty Widget
      return const SizedBox.shrink();
    }

    return Center(
      child: BasicElevatedCard(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ImageCarousel(
          images: widget.images,
          bottomInfoWidget: _getBottomInfoWidget(),
        ),
      ),
    );
  }
}
