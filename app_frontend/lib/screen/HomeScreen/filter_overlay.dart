import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/screen_width.dart';
import '../../constant/theme/themehelper.dart';

class FilterOverlay extends StatefulWidget {
  bool filter;
  bool notification;
  bool trip;
  bool experience;
  FilterOverlay(
      {Key? key,
      required this.filter,
      required this.notification,
      required this.trip,
      required this.experience})
      : super(key: key);

  @override
  State<FilterOverlay> createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  final layerLink = LayerLink();
  OverlayEntry? entry;
  final focusnode = FocusNode();
  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;
    entry = OverlayEntry(builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Positioned(
          width: size.width + 15,
          child: CompositedTransformFollower(
              offset: Offset(0, size.height + 10),
              showWhenUnlinked: false,
              link: layerLink,
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: ThemeHelper().selectbackgroundcolor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: widget.trip == true
                                        ? Colors.green
                                        : ThemeHelper().selectbackgroundcolor,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Colors.red)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text('Trips'),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              widget.trip = !widget.trip;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: widget.experience == true
                                        ? Colors.green
                                        : ThemeHelper().selectbackgroundcolor,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Colors.red)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text('Experiences'),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              widget.experience = !widget.experience;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      });
    });
    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: theme.selectbackgroundcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: widget.trip == true
                              ? Colors.green
                              : theme.selectbackgroundcolor,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.red)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('Trips'),
                  ],
                ),
                onTap: () {
                  setState(() {
                    widget.trip = !widget.trip;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.blueAccent)),
                  ),
                  Text('Experiences'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Container(
      child: CompositedTransformTarget(
        link: layerLink,
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: s.width / 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.filter = !widget.filter;
                        if (widget.filter == true) {
                          widget.notification = false;
                        }

                        if (widget.filter == true) {
                          hideOverlay();
                          showOverlay();
                          print('done');
                        } else {
                          print('out');
                          hideOverlay();
                        }
                      });
                    },
                    child: Icon(
                      Icons.filter_alt,
                      color: theme.searchcolor,
                      size: 28,
                    ),
                  ),
                  widget.filter == true
                      ? SizedBox(
                          height: 2.5,
                          width: s.width / 10,
                          child: Center(
                            child: Container(
                              color: theme.searchcolor,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: s.width / 10,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
