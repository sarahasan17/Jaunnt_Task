import 'package:flutter/material.dart';
import '../../../constant/screen_width.dart';
import '../../../constant/theme/themehelper.dart';

class Planner extends StatefulWidget {
  Planner(
      {Key key,
      this.s,
      this.theme,
      this.asset,
      this.question,
      this.count,
      this.unit,
      this.controller,
      this.globalKey})
      : super(key: key);

  final ScreenWidth s;
  final ThemeHelper theme;
  int count;
  String unit;
  String asset;
  String question;
  TextEditingController controller;
  GlobalKey<FormFieldState> globalKey;

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
    ScreenWidth s = ScreenWidth(context);
    return Row(
      children: [
        SizedBox(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: s.width / 6.5,
              child: Column(children: [
                TextFormField(
                  key: widget.globalKey,
                  style: ThemeHelper().font2,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  cursorColor: widget.theme.borderColor,
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    border: InputBorder.none,
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: ThemeHelper().buttoncolor,
                )
              ]),
            ),
            SizedBox(width: widget.s.width / 30),
            Text(
              widget.unit,
              style: widget.theme.font2,
            ),
          ],
        )
      ],
    );
  }
}
