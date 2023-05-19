import 'package:app_frontend/screen/Explore/Data/ExploreScreen_response.dart';
import 'package:app_frontend/screen/Explore/Presentation/pages/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constant/errors/error_popup.dart';
import '../../../../constant/loading_widget.dart';
import '../../../../constant/screen_width.dart';
import '../../../../constant/theme/themehelper.dart';
import '../cubit/ExploreScreen_cubit.dart';

class Object {
  String value;
  int distance;
  int triptime;
  List<String> text;
  Object(
      {required this.value,
      required this.distance,
      required this.triptime,
      required this.text});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController type = TextEditingController();
  List<String> image = [
    "image_1.png",
    "review3.png",
    "VIT Vellore.png",
    "mountain2.png"
  ];
  List<bool> bookmark = List.filled(10000, false);

  bool filter = false;
  @override
  int _activepage = 0;
  List<String> text = ['', '', '', '', ''];
  static List<String> text1 = ['trending', 'popular'];
  static List<String> text2 = ['trending'];
  static List<String> items = [
    'Nandi Hills',
    'Agra Fort',
    'Ooty',
    'lucknow',
    'Wonderla',
    'Imagicaa'
  ];

  List<int> index1 = List.filled(10, 0);
  List<String> getItems = List.from(items);

  /**bool? searchplacemain(
      String query, int trip_time, int distance, List<String> text1) {
    if (query == '') {
      return true;
    } else {
      if (trip_time >= values1.start.round() &&
          trip_time <= values1.end.round() &&
          distance >= values2.start.round() &&
          distance <= values2.end.round()) {
        int c = text.length;
        for (int i = 0; i < text.length; i++) {
          if (text[i] == '') {
            c = c - 1;
          }
        }
        if (c == 0) {
          if (query == '') {
            return true;
          } else {
            if (query.contains(search.text)) {
              return true;
            } else {
              return false;
            }
          }
        } else {
          int b = 0;
          for (int i = 0; i < text1.length; i++) {
            for (int j = 0; j < text.length; j++) {
              if (text[j] == text1[i]) {
                b = b + 1;
              }
            }
          }
          if (b == c) {
            if (query == '') {
              return true;
            } else {
              if (query.toLowerCase().contains(search.text.toLowerCase())) {
                return true;
              } else {
                return false;
              }
            }
          }
        }
      } else {
        return false;
      }
    }
  }**/

  bool trip_time = false;
  bool trip_dist = false;
  int count_trip = 0;
  int count_filters = 0;
  @override
  final PageController _controller = PageController();
  int distance = 9;
  int trip = 8;
  final GlobalKey<FormFieldState> _searchkey = GlobalKey<FormFieldState>();
  TextEditingController search = TextEditingController();
  RangeValues values1 = const RangeValues(1, 24);
  RangeValues values2 = const RangeValues(1, 20);
  @override
  /**void searchplace(
      String query, int trip_time, int distance, List<String> text1) {
    setState(() {
      if (trip_time >= values1.start.round() &&
          trip_time <= values1.end.round() &&
          distance >= values2.start.round() &&
          distance <= values2.end.round()) {
        print(values1.start.round());
        print(values1.end.round());
        int a = text1.length;
        int c = text.length;
        for (int i = 0; i < text.length; i++) {
          if (text[i] == '') {
            c = c - 1;
          }
        }
        int b = 0;
        for (int i = 0; i < a; i++) {
          for (int j = 0; j < c; j++) {
            if (text1[i] == text[j]) {
              b = b + 1;
            }
          }
        }
        if (b == c) {
          getItems = items
              .where((element) =>
                  element.toLowerCase().contains(query.toLowerCase()))
              .toList();
        } else {
          getItems = [];
        }
      } else {
        getItems = [];
      }
    });
  }**/
  static List<ExploreResponse2> item1 = [];
  static List<ExploreResponse2> getItem1 = List.from(item1);
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    void searchlist(String query) {
      setState(() {
        getItem1 = item1.where((element) {
          return element.placeName
                  .toLowerCase()
                  .contains(query.toLowerCase()) &&
              element.tripTime.round().toDouble() >=
                  values1.start.round().toDouble() &&
              element.tripTime.round().toDouble() <=
                  values1.end.round().toDouble() &&
              element.distance.round().toDouble() >=
                  values2.start.round().toDouble() &&
              element.distance.round().toDouble() <=
                  values2.end.round().toDouble();
        }).toList();
      });
    }

    return BlocProvider(
        create: (context) => ExploreCubit(),
        child: BlocConsumer<ExploreCubit, ExploreState>(
            listener: (context, state) {
          if (state is ExploreError) {
            ErrorPopup(context, state.message);
          }
        }, builder: (context, state) {
          if (state is ExploreLoading) {
            return const LoadingWidget();
          } else if (state is ExploreSuccess) {
            for (int i = 0; i < state.response.response.length; i++) {
              item1.add(state.response.response[i]);
            }
            return Scaffold(
              backgroundColor: theme.backgroundColor,
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                    child: ColorFiltered(
                      colorFilter: filter
                          ? ColorFilter.mode(
                              Colors.grey.withOpacity(0.5), BlendMode.srcATop)
                          : const ColorFilter.mode(
                              Colors.transparent, BlendMode.srcATop),
                      child: Container(
                        color: filter
                            ? Colors.grey.withOpacity(0.5)
                            : Colors.transparent,
                        child: ListView.builder(
                            itemCount: getItem1.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              int i = index;

                              return Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 217,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: PageView.builder(
                                          controller: _controller,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: image.length,
                                          onPageChanged: (int page) {
                                            setState(() {
                                              _activepage = page;
                                            });
                                          },
                                          itemBuilder: (_, index) {
                                            index1[i] = index;
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.asset(
                                                "assets/images/${image[index]}",
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }),
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
                                                  position:
                                                      index1[index].toDouble(),
                                                  decorator: DotsDecorator(
                                                    activeSize:
                                                        const Size(15, 7),
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  color: theme.transparentcolor
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20.0))),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          getItem1[index]
                                                              .placeName,
                                                          style: theme.font3
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                bookmark[i] =
                                                                    !bookmark[
                                                                        i];
                                                              });
                                                            },
                                                            child: Icon(
                                                              bookmark[i] ==
                                                                      false
                                                                  ? Icons
                                                                      .bookmark_border
                                                                  : Icons
                                                                      .bookmark,
                                                              color:
                                                                  Colors.white,
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
                                                        '${getItem1[index].tripTime} hours trip time',
                                                        style: theme.font6
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Text(
                                                        'I',
                                                        style: theme.font6
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Text(
                                                        '${getItem1[index].distance} km from you',
                                                        style: theme.font6
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Text(
                                                        'I',
                                                        style: theme.font6
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Text(
                                                        '${text1[0]}, ${text1[1]}',
                                                        style: theme.font6
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
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
                              );
                            }),
                      ),
                    ),
                  ),
                  filter
                      ? Container(
                          color: filter
                              ? Colors.grey.withOpacity(0.5)
                              : Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                              color: Colors.white,
                            ),
                            height: s.height / 2.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: ListView(
                                    children: [
                                      Text(
                                        'Trip Type:',
                                        style: theme.font8,
                                      ),
                                      SizedBox(height: s.height / 100),
                                      TextFieldWidget2(
                                        text: text,
                                        theme: theme,
                                        count_trip: count_trip,
                                      ),
                                      SizedBox(height: s.height / 80),
                                      Divider(
                                        color: theme.searchcolor,
                                        thickness: 0.3,
                                      ),
                                      SizedBox(height: s.height / 200),
                                      Text('Trip Time:', style: theme.font8),
                                      SizedBox(height: s.height / 100),
                                      RangeSlider(
                                          values: values1,
                                          min: 1,
                                          max: 24,
                                          divisions: 12,
                                          activeColor: theme.searchcolor,
                                          inactiveColor:
                                              theme.selectbackgroundcolor,
                                          labels: RangeLabels(
                                              values1.start.round().toString(),
                                              values1.end.round().toString()),
                                          onChanged: (value) {
                                            setState(() {
                                              values1 = value;
                                              trip_time = true;
                                            });
                                          }),
                                      Divider(
                                        color: theme.searchcolor,
                                        thickness: 0.3,
                                      ),
                                      SizedBox(height: s.height / 200),
                                      Text('Distance:', style: theme.font8),
                                      SizedBox(height: s.height / 100),
                                      RangeSlider(
                                          values: values2,
                                          min: 1,
                                          max: 20,
                                          divisions: 10,
                                          activeColor: theme.searchcolor,
                                          inactiveColor:
                                              theme.selectbackgroundcolor,
                                          labels: RangeLabels(
                                              values2.start.round().toString(),
                                              values2.end.round().toString()),
                                          onChanged: (value) {
                                            setState(() {
                                              values2 = value;
                                              trip_dist = true;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        trip_dist = false;
                                        trip_time = false;
                                        count_trip = 0;
                                        count_filters = 0;
                                        filter = false;
                                        search.text = '';
                                        getItem1 = List.from(item1);
                                        values1 = const RangeValues(1, 24);
                                        values2 = const RangeValues(1, 20);
                                      }),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: theme.selectbackgroundcolor,
                                            borderRadius:
                                                BorderRadius.circular(7.0)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 12),
                                        child: Text(
                                          'Reset Changes',
                                          style: theme.font8
                                              .copyWith(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          filter = false;
                                          searchlist(search.text);
                                          print(getItem1.length);
                                          int i;
                                          for (i = 0; i < text.length; i++) {
                                            if (text[i] == '') {
                                              break;
                                            }
                                          }
                                          if (i > 0) {
                                            count_trip = 1;
                                          } else {
                                            count_trip = 0;
                                          }
                                          if (trip_time == true &&
                                              trip_dist == true &&
                                              count_trip == 1) {
                                            count_filters = 3;
                                          } else if (trip_time == true &&
                                                  trip_dist == true ||
                                              trip_dist == true &&
                                                  count_trip == 1 ||
                                              trip_time == true &&
                                                  count_trip == 1) {
                                            count_filters = 2;
                                          } else if (trip_time == true ||
                                              trip_dist == true ||
                                              count_trip == 1) {
                                            count_filters = 1;
                                          } else {
                                            count_filters = 0;
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: theme.searchcolor,
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 14),
                                        child: Text(
                                          'Apply',
                                          style: theme.font8.copyWith(
                                              fontSize: 17,
                                              color:
                                                  theme.selectbackgroundcolor),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    color: theme.backgroundColor,
                    padding: const EdgeInsets.only(right: 10),
                    height: 76,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            margin: const EdgeInsets.all(12.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: theme.searchcolor,
                                  size: 28,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: TextFormField(
                                    style: theme.font7,
                                    controller: search,
                                    key: _searchkey,
                                    textAlign: TextAlign.start,
                                    cursorColor: theme.searchcolor,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Where do you want to go",
                                        hintStyle: theme.font7),
                                    onChanged: (value) {
                                      setState(() {
                                        print(getItem1.length);
                                        //filter = false;
                                        searchlist(value);
                                        //searchplace(value, trip, distance, text1);
                                      });
                                    },
                                    /*validator: (text) {
    if (text == null || text.isEmpty) {
    return 'Please enter some text';
    } else {
    return null;
    }
    },*/
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                filter = !filter;
                                FocusScope.of(context).unfocus();
                                print(search.text);
                                //FocusManager.instance.primaryFocus?.unfocus();
                              });
                            },
                            child: count_filters > 0
                                ? Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 5,
                                        child: Icon(
                                          Icons.filter_alt_sharp,
                                          color: theme.searchcolor,
                                          size: 30,
                                        ),
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 0,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                theme.filtercountcolor,
                                            radius: 12,
                                            child: Center(
                                              child: Text(
                                                count_filters.toString(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ))
                                    ],
                                  )
                                : Icon(
                                    Icons.filter_alt_sharp,
                                    color: theme.searchcolor,
                                    size: 30,
                                  ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
            );
          }
          return SizedBox();
        }));
  }
}
