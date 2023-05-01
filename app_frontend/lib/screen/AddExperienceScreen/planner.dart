import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/screen_width.dart';
import '../../constant/theme/themehelper.dart';

class Planner extends StatefulWidget {
  Planner(
      {key,
      this.s,
      this.theme,
      this.asset,
      this.question,
      this.count,
      this.unit,
      this.controller});

  final ScreenWidth s;
  final ThemeHelper theme;
  int count;
  String unit;
  String asset;
  String question;
  TextEditingController controller;
  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
    ScreenWidth s = ScreenWidth(context);
    return Row(
      children: [
        Container(
          width: widget.s.width / 2.5,
          child: Row(
            children: [
              Image.asset(widget.asset),
              SizedBox(
                width: widget.s.width / 18,
              ),
              Text(
                widget.question,
                style: widget.theme.font2,
              ),
            ],
          ),
        ),
        SizedBox(
          width: widget.s.width / 12,
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: s.width / 6.5,
              child: TextFormField(
                style: ThemeHelper().font2,
                textAlign: TextAlign.start,
                cursorColor: widget.theme.borderColor,
                controller: widget.controller,
              ),
            ),
            SizedBox(width: widget.s.width / 30),
            Text(
              widget.unit,
              style: widget.theme.font2,
            ),
          ],
        ))
      ],
    );
  }
}
