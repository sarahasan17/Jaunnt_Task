import 'package:app_frontend/screen/Bottomnavbarscreen/sidenavbar.dart';
import 'package:app_frontend/screen/HomeScreen/presentation/home.dart';
import 'package:app_frontend/screen/Explore/Presentation/pages/ExploreScreen.dart';
import 'package:app_frontend/screen/AddExperienceScreen/presentation/ImagePickerScreen/ImagePickerScreen.dart';
import 'package:app_frontend/screen/ProfileScreen/profile_screen.dart';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constant/hive.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../../constant/theme/themehelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List screen = [
    const Home(),
    const ExploreScreen(),
    const ImagePickerScreen(),
    const ProfileScreen()
  ];
  int count = 0;
  void ontap(int index) {
    setState(() {
      count = index;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    mybox.put(4, _scaffoldkey);
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ThemeHelper t = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
      key: _scaffoldkey,
      body: screen[count],
      drawer: const SideNavDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 12,
        selectedFontSize: 12,
        onTap: ontap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: t.searchcolor,
        backgroundColor: Colors.white,
        currentIndex: count,
        unselectedItemColor: t.searchcolor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                CupertinoIcons.home,
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Explore",
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                CupertinoIcons.search,
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Upload",
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.add_circle_outline_outlined,
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                CupertinoIcons.person,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
