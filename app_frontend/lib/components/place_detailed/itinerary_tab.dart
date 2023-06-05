import 'package:app_frontend/screen/Place_DetailedScreen/data/Place_Detailedscreen_response.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';

class ItineraryItem {
  const ItineraryItem(
      {required this.time, required this.name, this.description = ""});

  final String time;
  final String name;
  final String description;
}

const double circleRadius = 8;
const double circleContainerWidth = 40;
const double circleBarWidth = 4;

const double cardRadius = 16;
const double cardElevation = 8;

class ItineraryTab extends StatelessWidget {
  ItineraryTab({super.key, required this.place});
  Place_DetailedResponse place;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: ListView.builder(
        itemCount: place.itenirary.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.fromLTRB(circleContainerWidth, 0, 0, 0),
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular((index == 0) ? cardRadius : 0),
                      bottom: Radius.circular(
                          (index == place.itenirary.length - 1)
                              ? cardRadius
                              : 0),
                    ),
                  ),
                  elevation: cardElevation,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: ExpandablePanel(
                      header: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "${place.itenirary[index].time}:  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: textColorBlack)),
                            TextSpan(
                                text: place.itenirary[index].title,
                                style: TextStyle(
                                    fontSize: 16, color: textColorBlack)),
                          ],
                        ),
                      ),
                      collapsed: const SizedBox.shrink(),
                      expanded: (place.itenirary[index].description == "")
                          ? const SizedBox.shrink()
                          : Column(
                              children: <Widget>[
                                const SizedBox(height: 8),
                                Text(
                                  place.itenirary[index].description,
                                  style: TextStyle(
                                      color: textColorBlack, fontSize: 14),
                                ),
                              ],
                            ),
                      theme: const ExpandableThemeData(
                          iconPadding: EdgeInsets.all(0),
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (circleContainerWidth / 2 - circleRadius),
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: primaryDarkColor, width: circleRadius),
                  ),
                ),
              ),
              Positioned(
                left: (circleContainerWidth - circleBarWidth) / 2,
                top: 0,
                bottom: 0,
                child: Container(
                  color: primaryDarkColor,
                  width: circleBarWidth,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
