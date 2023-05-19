import 'package:app_frontend/constant/screen_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../constant/theme/themehelper.dart';

class TextFieldWidget2 extends StatefulWidget {
  TextFieldWidget2(
      {Key? key,
      required this.text,
      required this.theme,
      required this.count_trip})
      : super(key: key);
  final ThemeHelper theme;
  List<String> text;
  int count_trip;
  @override
  State<TextFieldWidget2> createState() => _TextFieldWidget2State();
}

class _TextFieldWidget2State extends State<TextFieldWidget2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      focusnode.addListener(() {
        if (focusnode.hasFocus) {
          showOverlay();
        } else {
          hideOverlay();
        }
      });
    });
  }

  @override
  static List<String> items = [
    'Trek',
    'trending',
    'popular',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  List<String> getItems = List.from(items);
  void searchBook(String query) {
    setState(() {
      if (query != '') {
        getItems = items
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        getItems = items;
      }
    });
  }

  TextEditingController type = TextEditingController();
  bool willcheck = false;
  int count1 = 0;
  final layerLink = LayerLink();
  OverlayEntry? entry;
  final focusnode = FocusNode();
  void showOverlay() {
    setState(() {
      final overlay = Overlay.of(context);
      final renderbox = context.findRenderObject() as RenderBox;
      final size = renderbox.size;
      final offset = renderbox.localToGlobal(Offset.zero);
      entry = OverlayEntry(
          builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                  offset: Offset(0, size.height + 10),
                  showWhenUnlinked: false,
                  link: layerLink,
                  child: buildOverlay())));
      overlay.insert(entry!);
    });
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  int count = 0;
  StatefulWidget buildOverlay() {
    ScreenWidth s = ScreenWidth(context);
    return Material(
      child: Container(
          height: 200,
          width: s.width / 1.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: ThemeHelper().white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 5.0),
              itemCount: getItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10),
                  child: GestureDetector(
                    onTap: () {
                      for (int i = 0; i < count1; i++) {
                        if (getItems[index] == widget.text[i]) {
                          willcheck = true;
                        }
                      }
                      if (willcheck == false) {
                        widget.text[count1] = getItems[index];
                        setState(() {
                          count1 = count1 + 1;
                          type.text = '';
                          setState(() {
                            widget.count_trip = 1;
                          });
                          print(widget.count_trip);
                        });
                      } else {
                        print('match found');
                      }
                      willcheck = false;
                      //hideOverlay();
                      //focusnode.unfocus();
                    },
                    child: Text(
                      getItems[index],
                      style: ThemeHelper().font2,
                    ),
                  ),
                );
              })),
    );
  }

  bool value1 = false;
  @override
  Widget build(BuildContext context) {
    ScreenWidth s = ScreenWidth(context);
    ThemeHelper theme = ThemeHelper();
    return CompositedTransformTarget(
        link: layerLink,
        child: Container(
            padding: const EdgeInsets.all(0),
            height: 34,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: theme.searchcolor),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: s.width / 1.25,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ListView.builder(
                            shrinkWrap: true, //    <-- Set this to true
                            physics: const ScrollPhysics(),
                            itemCount: count1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              if (widget.text.length > index) {
                                return Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: theme.selectbackgroundcolor,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.text[index],
                                          style: theme.font8
                                              .copyWith(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                count1--;
                                                for (int i = index;
                                                    i < count1;
                                                    i++) {
                                                  widget.text[i] =
                                                      widget.text[i + 1];
                                                }
                                                widget.text[count1] = '';
                                              });
                                              setState(() {
                                                if (count1 == 0) {
                                                  widget.count_trip = 0;
                                                } else {
                                                  widget.count_trip = 1;
                                                }
                                                print(widget.count_trip);
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  theme.selectbackgroundcolor,
                                              radius: 10,
                                              child: Icon(
                                                CupertinoIcons.clear_circled,
                                                color: theme.searchcolor,
                                                size: 16,
                                              ),
                                            ))
                                      ],
                                    ));
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          value1 = !value1;
                          if (value1 == true) {
                            hideOverlay();
                            focusnode.unfocus();
                          } else {
                            hideOverlay();
                            showOverlay();
                          }
                        });
                      },
                      child: Center(
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: theme.searchcolor,
                          size: 40,
                        ),
                      ))
                ])));
  }
}
/**BlocProvider(
    create: (context) => ExploreCubit(),
    child: BlocConsumer<ExploreCubit,ExploreState>(
    listener: (context, state) {
    if (state is ExploreError) {
    ErrorPopup(context, state.message);
    }
    },
    builder: (context, state) {
    if (state is ExploreLoading) {
    return const LoadingWidget();
    } else if (state is ExploreSuccess) {
    return **/
/**Scaffold(
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
    color:
    filter ? Colors.grey.withOpacity(0.5) : Colors.transparent,
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
    borderRadius: BorderRadius.circular(20.0),
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
    position: index1[index].toDouble(),
    decorator: DotsDecorator(
    activeSize: const Size(15, 7),
    activeShape: RoundedRectangleBorder(
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
    borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(20.0),
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
    getItem1[index].value,
    style: theme.font3.copyWith(
    color: Colors.white,
    fontSize: 18),
    ),
    GestureDetector(
    onTap: () {
    setState(() {
    bookmark[i] =
    !bookmark[i];
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
    MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '${getItem1[index].triptime} hours trip time',
    style: theme.font6.copyWith(
    color: Colors.white),
    ),
    Text(
    'I',
    style: theme.font6.copyWith(
    color: Colors.white),
    ),
    Text(
    '${getItem1[index].distance} km from you',
    style: theme.font6.copyWith(
    color: Colors.white),
    ),
    Text(
    'I',
    style: theme.font6.copyWith(
    color: Colors.white),
    ),
    Text(
    '${text1[0]}, ${text1[1]}',
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
    inactiveColor: theme.selectbackgroundcolor,
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
    inactiveColor: theme.selectbackgroundcolor,
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
    borderRadius: BorderRadius.circular(7.0)),
    padding: const EdgeInsets.symmetric(
    vertical: 7, horizontal: 12),
    child: Text(
    'Reset Changes',
    style: theme.font8.copyWith(fontSize: 17),
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
    trip_dist == true && count_trip == 1 ||
    trip_time == true && count_trip == 1) {
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
    borderRadius: BorderRadius.circular(6.0)),
    padding: const EdgeInsets.symmetric(
    vertical: 7, horizontal: 14),
    child: Text(
    'Apply',
    style: theme.font8.copyWith(
    fontSize: 17,
    color: theme.selectbackgroundcolor),
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
    backgroundColor: theme.filtercountcolor,
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
    );**/
