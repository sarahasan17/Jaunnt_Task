import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';
import '../common/image_carousel.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard(
      {super.key,
      required this.images,
      required this.placeName,
      required this.description,
      required this.tags});

  final List<String> images;
  final String placeName;
  final String description;
  final String tags;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  Widget _getBottomInfoWidget() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.placeName,
                      style: TextStyle(
                          color: textColorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  const Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
              Text(
                widget.description,
                style: TextStyle(
                    color: textColorWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 2,
                    overflow: TextOverflow.ellipsis),
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.placeName == "") || (widget.images.isEmpty)) {
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
