import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/HomeScreen/filter_overlay.dart';
import 'package:flutter/material.dart';
import '../../components/home/experience_card.dart';
import '../../components/home/place_card.dart';

const double bodyPadding = 10;

const List<String> dummyImages = [
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/213/360/50213-backdrop-1651222749937-2.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/366/360/79366-backdrop-1680879935093-1.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/213/360/50213-backdrop-1651222749937-2.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/366/360/79366-backdrop-1680879935093-1.jpeg?country=in",
];
const dummyUserProfileName = "Romanch Manchala";
const dummyPlace =
    "Kabini backwaters hvjhvhcgfc  gchv nvhfcvvjfhfchg gcghfxhvhgcxtdx b";
const dummyDescription =
    "One of the best places to visit in the morning. Bahut acha place bhai. Esa kabhi nahi dekha jeevan mein... now bloddy dummy text gchv nvhfcvvjfhfchg gcghfxhvhgcxtdx b";
const dummyPlaceDescription =
    "9 hrs trip time | 40 kms from you | Sunrise, Bike Ride";
const dummyPlaceTags = "Popular, Trending";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// TODO: AppBar
// TODO: Pull to refresh
// TODO: Save place flow
// TODO: Profile pic flow
class _HomeState extends State<Home> {
  @override
  bool filter = false;
  bool notification = false;
  bool trip = false;
  bool experience = false;
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: s.height / 100,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/home_icon1.png'),
                    SizedBox(
                      width: s.width / 8,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/logo.png'),
                        Text('Jaunnt',
                            style: theme.font8.copyWith(fontSize: 24))
                      ],
                    ),
                    Row(
                      children: [
                        FilterOverlay(
                          experience: experience,
                          trip: trip,
                          filter: filter,
                          notification: notification,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    notification = !notification;
                                    if (notification == true) {
                                      filter = false;
                                    }
                                  });
                                },
                                child: Image.asset(
                                    'assets/images/home_icon3.png')),
                            notification == true
                                ? SizedBox(
                                    height: s.height / 200,
                                  )
                                : const SizedBox(),
                            notification == true
                                ? SizedBox(
                                    height: 2.5,
                                    width: s.width / 15,
                                    child: Center(
                                      child: Container(
                                        color: theme.searchcolor,
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: s.height / 50,
              ),
              notification == true
                  ? Container(
                      height: s.height / 5,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border:
                                            Border.all(color: Colors.black54)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        'assets/images/image_1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Manoj started following you',
                                    style: theme.font8.copyWith(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: s.width / 20,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: s.height / 50),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        '1 min ago',
                                        style: theme.font9,
                                      )),
                                ],
                              ),
                            );
                          }),
                    )
                  : const SizedBox(),
              Flexible(
                child: ColorFiltered(
                  colorFilter: notification
                      ? ColorFilter.mode(
                          Colors.grey.withOpacity(0.5), BlendMode.srcATop)
                      : const ColorFilter.mode(
                          Colors.transparent, BlendMode.srcATop),
                  child: Container(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                    color: notification
                        ? Colors.grey.withOpacity(0.5)
                        : Colors.transparent,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        if (index % 4 == 0) {
                          return const ExperienceCard(
                            images: dummyImages,
                            profileName: dummyUserProfileName,
                            description: dummyDescription,
                            placeName: dummyPlace,
                          );
                        }
                        if (index % 4 == 1) {
                          return const PlaceCard(
                            images: dummyImages,
                            placeName: dummyPlace,
                            description: dummyPlaceDescription,
                            tags: dummyPlaceTags,
                          );
                        }
                        if (index % 4 == 2) {
                          return const ExperienceCard(
                            images: dummyImages,
                            profileName: dummyUserProfileName,
                            description: "",
                            placeName: dummyPlace,
                          );
                        }
                        return const PlaceCard(
                          images: dummyImages,
                          placeName: dummyPlace,
                          description: dummyPlaceDescription,
                          tags: dummyPlaceTags,
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
