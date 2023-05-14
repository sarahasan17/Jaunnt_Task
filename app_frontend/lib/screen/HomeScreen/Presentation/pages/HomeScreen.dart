import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../../constant/screen_width.dart';
import '../../../../constant/theme/themehelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> image = [
    "himanshu-choudhary-I0RsGcZIxMU-unsplash 3.png",
    "image 1.png"
  ];
  List<bool> bookmark = List.filled(10000, false);
  int _activepage = 0;
  final GlobalKey<FormFieldState> _searchkey = GlobalKey<FormFieldState>();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          int i = index;
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 217,
                            width: double.maxFinite / 1.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: image.length,
                                onPageChanged: (int page) {
                                  setState(() {
                                    _activepage = page;
                                  });
                                },
                                itemBuilder: (_, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/${image[index]}"),
                                        fit: BoxFit.cover,
                                      ),
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
                                              position: index.toDouble(),
                                              decorator: DotsDecorator(
                                                activeSize: const Size(15, 7),
                                                activeShape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(20.0),
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
                                                      'Nandi Hills',
                                                      style: theme.font3
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            bookmark[i] =
                                                                !bookmark[i];
                                                            print(bookmark);
                                                          });
                                                        },
                                                        child: Icon(
                                                          bookmark[i] == false
                                                              ? Icons
                                                                  .bookmark_border
                                                              : Icons.bookmark,
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
                                                    '9 hours trip time',
                                                    style: theme.font6.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    'I',
                                                    style: theme.font6.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    '40 km from you',
                                                    style: theme.font6.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    'I',
                                                    style: theme.font6.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    'Popular, Trending',
                                                    style: theme.font6.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    height: 83,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
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
                                      setState(() {});
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
                        Icon(
                          Icons.filter_alt_sharp,
                          color: theme.searchcolor,
                          size: 30,
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
