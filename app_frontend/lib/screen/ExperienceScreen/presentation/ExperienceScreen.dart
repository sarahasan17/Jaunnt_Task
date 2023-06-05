import 'dart:io';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/common/image_carousel.dart';
import '../../../components/place_detailed/experience_tab.dart';
import '../../../components/place_detailed/itinerary_tab.dart';
import '../../../components/place_detailed/overview_tab.dart';
import '../../../components/place_detailed/tab_button.dart';
import '../../../constant/errors/error_popup.dart';
import '../../../constant/loading_widget.dart';
import 'cubit/Experiencescreen_cubit.dart';

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

class ExperienceScreen extends StatefulWidget {
  //String? id;
  ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool bookmark = false;
  final PageController _controller = PageController(initialPage: 0);
  final PageController _controller2 = PageController(initialPage: 0);
  final int _numTabs = 3;
  int _activepage = 0;
  final List<String> _tabHeaders = ["Overview", "Itinerary", "Experiences"];
  final List<Widget> _tabs = [
    const OverviewTab(placeName: dummyPlace, description: dummyDescription),
    const ItineraryTab(items: dummyItinerary),
    const ExperienceTab(placeName: dummyPlace, description: dummyDescription),
  ];
  List<String> image = [
    "image_1.png",
    "review3.png",
    "VIT Vellore.png",
    "mountain2.png"
  ];
  int _activePage = 0;
  int index1 = 0;
  int index2 = 0;
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
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return BlocProvider(
        create: (context) => ExperienceCubit(),
        child: BlocConsumer<ExperienceCubit, ExperienceState>(
            listener: (context, state) {
          if (state is ExperienceError) {
            ErrorPopup(context, state.message);
          }
        }, builder: (context, state) {
          if (state is ExperienceLoading) {
            return const LoadingWidget();
          } else if (state is ExperienceSuccess) {
            var exp = state.response;
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ImageCarousel(
                        images: dummyImages,
                        bottomInfoWidget: SizedBox.shrink(),
                      ),
                    ),
                    Positioned(
                      top: 218,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: theme.selectbackgroundcolor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0))),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                          child: Image.file(
                                              File(exp.user.profilePhoto)),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              exp.user.fullName,
                                              style: theme.font8.copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              exp.place.placeName,
                                              style: theme.font8.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: s.width / 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  color: theme.searchcolor),
                                              child: Text(
                                                'Experience',
                                                style: theme.font8.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: theme.white),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              exp.exp.dateOfTrip,
                                              style: theme.font8.copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: s.height / 100,
                                    ),
                                    Container(
                                        child: Text(
                                      exp.exp.discription,
                                      style: theme.font8,
                                    ))
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/pic-1.png',
                                                  width: s.width / 12,
                                                ),
                                                SizedBox(width: s.width / 50),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Distance',
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13)),
                                                    SizedBox(
                                                      height: s.height / 300,
                                                    ),
                                                    Text("exp.place.distance",
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontSize: 13))
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: s.height / 60,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/img.png',
                                                  width: s.width / 12,
                                                ),
                                                SizedBox(width: s.width / 50),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Mode of Transport',
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13)),
                                                    SizedBox(
                                                      height: s.height / 300,
                                                    ),
                                                    Text(exp.exp.travelMode,
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontSize: 13))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/Vector.png'),
                                                SizedBox(width: s.width / 50),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Group Size',
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13)),
                                                    SizedBox(
                                                      height: s.height / 300,
                                                    ),
                                                    Text(
                                                        exp.exp.groupSize
                                                            .toString(),
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontSize: 13))
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: s.height / 60,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/Inner Plugin Iframe.png',
                                                  width: s.width / 12,
                                                ),
                                                SizedBox(width: s.width / 50),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Trip Time',
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13)),
                                                    SizedBox(
                                                      height: s.height / 300,
                                                    ),
                                                    Text(
                                                        '${exp.exp.tripTime} hours',
                                                        style: theme.font8
                                                            .copyWith(
                                                                fontSize: 13))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              height: 217,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: PageView.builder(
                                            controller: _controller,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: exp.exp.images.length,
                                            onPageChanged: (int page) {
                                              setState(() {
                                                _activepage = page;
                                              });
                                            },
                                            itemBuilder: (_, index) {
                                              index1 = index;
                                              return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      color: Colors.black),
                                                  child: Image.asset(
                                                      exp.place.coverPhoto,
                                                      fit: BoxFit.cover)
                                                  /**Image.file(File(
                                            'assets/images/${image[index]}'))**/
                                                  );
                                            })),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              DotsIndicator(
                                                dotsCount: image.length,
                                                position: index1.toDouble(),
                                                decorator: DotsDecorator(
                                                  activeSize: const Size(15, 7),
                                                  activeShape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  size: const Size(7, 7),
                                                  color: Colors
                                                      .white30, // Inactive color
                                                  activeColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: theme.transparentcolor
                                                    .withOpacity(0.4),
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0))),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Nandi Hills',
                                                        style: theme.font3
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              bookmark =
                                                                  !bookmark;
                                                            });
                                                          },
                                                          child: Icon(
                                                            bookmark == false
                                                                ? Icons
                                                                    .bookmark_border
                                                                : Icons
                                                                    .bookmark,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '8 hours trip time',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      'I',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      '${20} km from you',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      'I',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      'Popular, Trending',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1.5)),
                                Text(
                                  '  More places like this  ',
                                  style: theme.font8,
                                ),
                                const Expanded(
                                    child: Divider(
                                  thickness: 1.5,
                                )),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              height: 217,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: 0,
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: PageView.builder(
                                            controller: _controller2,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: image.length,
                                            onPageChanged: (int page) {
                                              setState(() {
                                                _activepage = page;
                                              });
                                            },
                                            itemBuilder: (_, index) {
                                              index2 = index;
                                              return ('assets/images/${image[index]}' !=
                                                      null)
                                                  ? Image.asset(
                                                      'assets/images/${image[index]}',
                                                      fit: BoxFit.cover)
                                                  : const SizedBox();
                                              /**Image.file(File(
                                        'assets/images/${image[index]}'))**/
                                            }),
                                      )),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              DotsIndicator(
                                                dotsCount: image.length,
                                                position: index2.toDouble(),
                                                decorator: DotsDecorator(
                                                  activeSize: const Size(15, 7),
                                                  activeShape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  size: const Size(7, 7),
                                                  color: Colors
                                                      .white30, // Inactive color
                                                  activeColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: theme.transparentcolor
                                                    .withOpacity(0.4),
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0))),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Nandi Hills',
                                                        style: theme.font3
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              bookmark =
                                                                  !bookmark;
                                                            });
                                                          },
                                                          child: Icon(
                                                            bookmark == false
                                                                ? Icons
                                                                    .bookmark_border
                                                                : Icons
                                                                    .bookmark,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '8 hours trip time',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      'I',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      '${20} km from you',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      'I',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      'Popular, Trending',
                                                      style: theme.font6
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}
