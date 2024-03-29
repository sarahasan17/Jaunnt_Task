import 'package:app_frontend/constant/screen_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../constant/theme/themehelper.dart';

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
