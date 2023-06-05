import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/Place_DetailedScreen/data/Place_Detailedscreen_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../common/basic_elevated_card.dart';

class OverviewTab extends StatelessWidget {
  OverviewTab({super.key, required this.place});
  Place_DetailedResponse place;
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.placeName,
                      style: theme.font8
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      place.description,
                      style: theme.font7.copyWith(fontSize: 14),
                    ),
                  )
                ],
              )),
          SizedBox(height: s.height / 70),
          Container(
              padding: const EdgeInsets.all(17.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/pic-1.png',
                                width: s.width / 12,
                              ),
                              SizedBox(width: s.width / 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Distance',
                                      style: theme.font8.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: s.height / 300,
                                  ),
                                  Text(place.distance.toString(),
                                      style: theme.font8.copyWith(fontSize: 13))
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mode of Transport',
                                      style: theme.font8.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: s.height / 300,
                                  ),
                                  Text(place.transportMode,
                                      style: theme.font8.copyWith(fontSize: 13))
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
                                'assets/images/pic-4.png',
                                width: s.width / 12,
                              ),
                              SizedBox(width: s.width / 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Visitors Rating',
                                      style: theme.font8.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: s.height / 300,
                                  ),
                                  Text("place.vistorsRating",
                                      style: theme.font8.copyWith(fontSize: 13))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Inner Plugin Iframe.png',
                                width: s.width / 12,
                              ),
                              SizedBox(width: s.width / 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Trip Time',
                                      style: theme.font8.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: s.height / 300,
                                  ),
                                  Text('${place.tripTime} hours',
                                      style: theme.font8.copyWith(fontSize: 13))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: s.height / 60,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/pic-3.png'),
                              SizedBox(width: s.width / 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tags',
                                      style: theme.font8.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: s.height / 300,
                                  ),
                                  ListView.builder(
                                      itemCount: place.tags.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text("${place.tags[index]} ",
                                            style: theme.font8
                                                .copyWith(fontSize: 13));
                                      }),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: s.height / 60,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/pic-5.png'),
                              SizedBox(width: s.width / 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Best time to visit',
                                      style: theme.font8.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: s.height / 300,
                                  ),
                                  Text(place.bestTime,
                                      style: theme.font8.copyWith(fontSize: 13))
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
          SizedBox(height: s.height / 70),
          Container(
            padding: const EdgeInsets.all(17.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key things to do',
                    style: theme.font8
                        .copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: s.height / 100,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: s.height / 20,
                        child: Stack(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Positioned(
                                top: 0,
                                left: 2,
                                child: SizedBox(
                                  width: 8,
                                  height: s.height / 20,
                                  child: Center(
                                    child: Container(
                                      color: theme.selectbackgroundcolor,
                                    ),
                                  ),
                                )),
                            Positioned(
                              top: 5,
                              left: 2,
                              child: Container(
                                height: 3.5,
                                width: 3.5,
                                margin: const EdgeInsets.all(2.0),
                                decoration:
                                    BoxDecoration(color: theme.searchcolor),
                              ),
                            ),
                            Positioned(
                                top: 5,
                                left: s.width / 17,
                                child: SizedBox(
                                  width: s.width / 1.2,
                                  child: RichText(
                                    textScaleFactor: 1.1,
                                    text: TextSpan(
                                      text:
                                          ' ${place.thingsToDo[index].title}: ',
                                      style: theme.font8.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text:
                                                ' ${place.thingsToDo[index].description} ',
                                            style: theme.font8.copyWith(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
/** Text(
    'Trekking: Explore Skandagiri, Brahmagiri, Chennarayana Durga.',
    style: theme.font8.copyWith(fontSize: 13),
    ),**/
