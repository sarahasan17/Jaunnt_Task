import 'package:flutter/material.dart';

import '../components/common/image_carousel.dart';
import '../components/place_detailed/experience_tab.dart';
import '../components/place_detailed/itinerary_tab.dart';
import '../components/place_detailed/overview_tab.dart';
import '../components/place_detailed/tab_button.dart';
import '../config/colors.dart';

const List<String> dummyImages = [
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/366/360/79366-backdrop-1680879935093-1.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/213/360/50213-backdrop-1651222749937-2.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/366/360/79366-backdrop-1680879935093-1.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/213/360/50213-backdrop-1651222749937-2.jpeg?country=in",
];
const String dummyPlace = "Kabini backwaters";
const String dummyDescription =
    "One of the best places to visit in the morning. Bahut acha place bhai. Esa kabhi nahi dekha jeevan mein... now bloody dummy text gchv nvhfcvvjfhfchg gcghfxhvhgcxtdx b";
const List<ItineraryItem> dummyItinerary = [
  ItineraryItem(
      time: "04.00 am",
      name: "Depart from Bengaluru",
      description:
          "Nandi Hills is around 60 km away from Bangalore and takes approximately 1.5-2 hours to reach"),
  ItineraryItem(time: "05.30 am", name: "Sunrise at Nandi Hills"),
  ItineraryItem(
      time: "07.00 am",
      name: "Exploring in and around",
      description: "There is temple and small parks on top of Nandi hills"),
  ItineraryItem(
      time: "04.00 am",
      name: "Depart from Bengaluru",
      description:
          "Nandi Hills is around 60 km away from Bangalore and takes approximately 1.5-2 hours to reach"),
  ItineraryItem(time: "05.30 am", name: "Sunrise at Nandi Hills"),
  ItineraryItem(
      time: "07.00 am",
      name: "Exploring in and around",
      description: "There is temple and small parks on top of Nandi hills"),
  ItineraryItem(
      time: "04.00 am",
      name: "Depart from Bengaluru",
      description:
          "Nandi Hills is around 60 km away from Bangalore and takes approximately 1.5-2 hours to reach"),
  ItineraryItem(time: "05.30 am", name: "Sunrise at Nandi Hills"),
  ItineraryItem(
      time: "07.00 am",
      name: "Exploring in and around",
      description: "There is temple and small parks on top of Nandi hills"),
  ItineraryItem(
      time: "04.00 am",
      name: "Depart from Bengaluru",
      description:
          "Nandi Hills is around 60 km away from Bangalore and takes approximately 1.5-2 hours to reach"),
  ItineraryItem(time: "05.30 am", name: "Sunrise at Nandi Hills"),
  ItineraryItem(
      time: "07.00 am",
      name: "Exploring in and around",
      description: "There is temple and small parks on top of Nandi hills"),
];

class PlaceDetailed extends StatefulWidget {
  const PlaceDetailed({super.key});

  @override
  State<PlaceDetailed> createState() => _PlaceDetailedState();
}

class _PlaceDetailedState extends State<PlaceDetailed> {
  final PageController _controller = PageController(initialPage: 0);
  final int _numTabs = 3;
  final List<String> _tabHeaders = ["Overview", "Itinerary", "Experiences"];
  final List<Widget> _tabs = [
    const OverviewTab(placeName: dummyPlace, description: dummyDescription),
    const ItineraryTab(items: dummyItinerary),
    const ExperienceTab(placeName: dummyPlace, description: dummyDescription),
  ];

  int _activePage = 0;

  List<Widget> _getTabHeaders() {
    List<Widget> headers = [];

    for (int i = 0; i < _numTabs; i++) {
      headers.add(TabButton(
        text: _tabHeaders[i],
        active: (i == _activePage),
        onPressed: () {
          _controller.animateToPage(i,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
      ));
    }

    return headers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: primaryColor,
        child: Column(
          children: <Widget>[
            const ImageCarousel(
              images: dummyImages,
              bottomInfoWidget: SizedBox.shrink(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _getTabHeaders(),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (int newPage) {
                  setState(() {
                    _activePage = newPage;
                  });
                },
                itemCount: _numTabs,
                itemBuilder: (BuildContext context, int index) {
                  return _tabs[index % _numTabs];
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
