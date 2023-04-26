import 'package:app_frontend/constant/screen_width.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/themehelper.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({Key? key}) : super(key: key);

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  TextEditingController place = TextEditingController();
  String? dropdownvalue = 'Item 1';
  int count1 = 2;
  int count2 = 2;
  int count3 = 2;
  // List of items in our dropdown menu
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  DateTime selectedDate = DateTime.now();

  datepicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0XFF00425A), // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Color(0XFF00425A), // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: const Color(0XFF00425A), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      setState(() {
        selectedDate = value!;
      });
    });
  }

  String selectedValue = 'Item1';
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: s.height / 20),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 13.0, left: 8, right: 15, bottom: 13.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: theme.white,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            height: s.height / 8,
                            width: 100,
                            alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: theme.backgroundColor),
                            child: const Icon(Icons.copy),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date:  ',
                                    style: theme.font2,
                                  ),
                                  GestureDetector(
                                    onTap: () => datepicker(),
                                    child: Container(
                                      height: s.height / 25,
                                      width: s.width / 2.3,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: theme.borderColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                              style: theme.font2),
                                          const Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: s.height / 100),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Place: ',
                                    style: theme.font2,
                                  ),
                                  Container(
                                    height: s.height / 25,
                                    width: s.width / 2.3,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: theme.borderColor),
                                    ),
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      cursorColor: theme.borderColor,
                                      controller: place,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: s.height / 200),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: s.width / 8,
                                  ),
                                  Text(
                                    'Could\'nt find?',
                                    style: theme.font2.copyWith(fontSize: 12),
                                  ),
                                  Text(
                                    '  Add Place',
                                    style: theme.font2.copyWith(
                                        color: theme.placeColor, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: s.height / 35,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 12, right: 12, bottom: 20.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: theme.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Share your experience:', style: theme.font1),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                                'As I stood atop Nandi Hills at 5am, watching the sunrise, I felt an overwhelming sense of awe and wonder. The stunning colors of the sky and the peaceful surroundings made me appreciate the beauty of nature. It was a truly unforgettable ',
                                style: theme.font2),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: s.height / 35,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 12, right: 12, bottom: 20.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: theme.white),
                      child: Column(
                        children: [
                          Planner(
                              s: s,
                              theme: theme,
                              unit: 'hours',
                              count: count1,
                              question: 'Total trip time?',
                              asset: 'assets/images/Inner Plugin Iframe.png'),
                          SizedBox(
                            height: s.height / 50,
                          ),
                          Planner(
                              s: s,
                              theme: theme,
                              unit: 'people',
                              count: count2,
                              question: 'Group size?',
                              asset: 'assets/images/Vector.png'),
                          SizedBox(
                            height: s.height / 50,
                          ),
                          Planner(
                              s: s,
                              theme: theme,
                              unit: 'Thousand',
                              count: count3,
                              question: 'Total budget?',
                              asset: 'assets/images/circle-coin-vertical.png'),
                          SizedBox(
                            height: s.height / 50,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/signpost.png'),
                              SizedBox(
                                width: s.width / 18,
                              ),
                              Text(
                                '  Mode of transport:',
                                style: theme.font2,
                              ),
                              SizedBox(
                                width: s.width / 15,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        size: 18,
                                      ),
                                      Expanded(
                                          child: Text('Select Item',
                                              style: theme.font2)),
                                    ],
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: theme.font2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: s.height / 32,
                                    width: s.width / 3.7,
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: theme.borderColor,
                                        ),
                                        color: theme.white),
                                    elevation: 2,
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: theme.borderColor,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      maxHeight: s.height / 5,
                                      width: s.width / 3.7,
                                      padding: null,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: theme.white),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(5),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: s.height / 5.5,
                ),
                Container(
                  height: s.height / 14,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: theme.buttoncolor.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                      color: theme.buttoncolor),
                  child: Center(
                    child: Text(
                      'Save Experience',
                      style: theme.font2
                          .copyWith(color: theme.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            )),
      ),
    ));
  }
}

class Planner extends StatefulWidget {
  Planner(
      {super.key,
      required this.s,
      required this.theme,
      required this.asset,
      required this.question,
      required this.count,
      required this.unit});

  final ScreenWidth s;
  final ThemeHelper theme;
  int count;
  String unit;
  String asset;
  String question;

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
                onTap: () {
                  setState(() {
                    widget.count = widget.count - 1;
                  });
                },
                child: const Icon(CupertinoIcons.minus_circle)),
            SizedBox(width: widget.s.width / 50),
            Text(
              widget.count.toString(),
              style: widget.theme.font2,
            ),
            SizedBox(width: widget.s.width / 50),
            GestureDetector(
                onTap: () {
                  setState(() {
                    widget.count = widget.count + 1;
                  });
                },
                child: const Icon(CupertinoIcons.plus_circle)),
            SizedBox(width: widget.s.width / 50),
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
