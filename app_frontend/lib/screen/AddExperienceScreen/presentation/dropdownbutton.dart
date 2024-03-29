import 'package:app_frontend/constant/screen_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constant/theme/themehelper.dart';

class Dropdownbutton3 extends StatefulWidget {
  Dropdownbutton3({Key? key, required this.items}) : super(key: key);
  List<String> items;
  @override
  State<Dropdownbutton3> createState() => _Dropdownbutton3State();
}

class _Dropdownbutton3State extends State<Dropdownbutton3> {
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
              width: size.width / 10,
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
                              if (widget.items.length > index) {
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
                                          widget.items[index],
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
                                                  widget.items[i] =
                                                      widget.items[i + 1];
                                                }
                                                widget.items[count1] = '';
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
