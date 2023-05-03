import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.only(top: 20, left: 10, bottom: 0),
            child: ListView(
              children: [
                Container(
                  height: s.height / 4.8,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10,
                          left: 0,
                          child: CircleAvatar(
                              backgroundColor: theme.white,
                              radius: s.width / 8)),
                      Positioned(
                          top: 20,
                          left: s.width / 3.5,
                          child: Text(
                            'Romanch Bygari',
                            style: theme.font1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )),
                      Positioned(
                          top: 50,
                          left: s.width / 3.5,
                          child: Container(
                            width: s.width / 1.7,
                            child: Text(
                              'Travel enthusiast who loves coffee and dogs!',
                              style: theme.font2,
                            ),
                          )),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: s.width / 1.55,
                            height: s.height / 11,
                            decoration: BoxDecoration(
                                color: theme.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  bottomLeft: Radius.circular(35),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '100',
                                      style: theme.font3,
                                    ),
                                    SizedBox(
                                      height: s.height / 300,
                                    ),
                                    Text(
                                      'Following',
                                      style: theme.font4,
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '87',
                                      style: theme.font3,
                                    ),
                                    SizedBox(
                                      height: s.height / 300,
                                    ),
                                    Text(
                                      'Followers',
                                      style: theme.font4,
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/share.png'),
                                    SizedBox(
                                      height: s.height / 200,
                                    ),
                                    Text(
                                      'Share',
                                      style: theme.font4,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: s.height / 50,
                          left: s.width / 50,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                color: theme.profilebuttoncolor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Edit Profile',
                              style: theme.font2,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: s.height / 180),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Center(
                    child: TabBar(
                        controller: tabcontroller,
                        labelColor: theme.buttoncolor,
                        unselectedLabelColor: theme.buttoncolor,
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: s.width / 12),
                        unselectedLabelStyle: theme.font2,
                        labelStyle: theme.font2,
                        isScrollable: true,
                        indicatorColor: theme.buttoncolor,
                        tabs: const [
                          Tab(text: "Experiences (11)"),
                          Tab(text: "Saved places"),
                        ]),
                  ),
                ),
                SizedBox(height: s.height / 150),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  height: s.height / 1.5,
                  child: TabBarView(
                    controller: tabcontroller,
                    children: [
                      TabBars(part: 'experience'),
                      TabBars(part: 'saved places'),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class TabBars extends StatelessWidget {
  TabBars({Key key, this.part}) : super(key: key);
  String part;
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                      color: theme.white,
                      image: const DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.cover)),
                  margin: const EdgeInsets.all(7),
                  width: s.width / 2.28,
                  height: s.height / 6.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        width: s.width / 2.2,
                        height: s.height / 35,
                        decoration: BoxDecoration(
                            color: theme.buttoncolor.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        child: Text(
                          'Chunchi Falls',
                          style: theme.font2
                              .copyWith(color: theme.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                      color: theme.white,
                      image: const DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.cover)),
                  margin: const EdgeInsets.all(7),
                  width: s.width / 2.3,
                  height: s.height / 6.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        width: s.width / 2.3,
                        height: s.height / 35,
                        decoration: BoxDecoration(
                            color: theme.buttoncolor.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        child: Text(
                          'Chunchi Falls',
                          style: theme.font2
                              .copyWith(color: theme.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
