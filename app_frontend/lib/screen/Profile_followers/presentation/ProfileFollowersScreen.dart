import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter/material.dart';

class ProfileFollowersScreen extends StatefulWidget {
  const ProfileFollowersScreen({Key key}) : super(key: key);

  @override
  State<ProfileFollowersScreen> createState() => _ProfileFollowersScreenState();
}

class _ProfileFollowersScreenState extends State<ProfileFollowersScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.only(
            left: s.width / 18, right: s.width / 18, top: s.height / 50),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back, color: theme.buttoncolor, size: 30),
                Text(
                  'romi.bygari',
                  style: theme.font3
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(),
              ],
            ),
            SizedBox(
              height: s.height / 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: s.width / 12),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: theme.backgroundfollowercolor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(28)),
              alignment: Alignment.topLeft,
              child: TabBar(
                  controller: tabcontroller,
                  labelColor: theme.white,
                  unselectedLabelColor: theme.white,
                  labelPadding: EdgeInsets.symmetric(horizontal: s.width / 9.5),
                  unselectedLabelStyle: theme.font2,
                  labelStyle: theme.font2,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: theme.buttoncolor2,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  tabs: const [
                    Tab(text: "Following"),
                    Tab(text: "Followers"),
                  ]),
            ),
            SizedBox(
              height: s.height / 50,
            ),
            Container(
              height: s.height / 1.2,
              child: TabBarView(
                controller: tabcontroller,
                children: const [
                  TabBars(data: 'Following', count: 12),
                  TabBars(data: 'Followers', count: 0),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class TabBars extends StatelessWidget {
  const TabBars({Key key, this.data, this.count}) : super(key: key);

  final String data;
  final int count;
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    if (count > 0) {
      return ListView.builder(
          itemCount: count,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: s.width / 15,
                        backgroundColor: theme.white,
                      ),
                      Text(
                        'Romanch Bygari',
                        style: theme.font3.copyWith(fontSize: 16),
                      ),
                      SizedBox(),
                      SizedBox(),
                      SizedBox(),
                      Container(
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
                            color: theme.followbackgroundcolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Unfollow', style: theme.font5),
                      )
                    ],
                  ),
                ));
          });
    } else {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Sorry, No matches found:(',
                  style:
                      ThemeHelper().font3.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: s.height / 8,
              )
            ],
          ),
        ),
      );
    }
  }
}
