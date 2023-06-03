import 'package:app_frontend/constant/navigation/autorouter.dart';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../../constant/hive.dart';
import '../../constant/theme/themehelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SideNavDrawer extends StatefulWidget {
  const SideNavDrawer({Key? key}) : super(key: key);

  @override
  State<SideNavDrawer> createState() => _SideNavDrawerState();
}

class _SideNavDrawerState extends State<SideNavDrawer> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper t = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return ClipRRect(
      child: Drawer(
        width: s.width / 1.5,
        child: Container(
            height: s.height,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: t.selectbackgroundcolor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: s.height / 10,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: t.searchcolor,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: Text(
                        'Romanch',
                        style: t.font8.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: t.sidenavcolor1),
                      ),
                    ),
                    Container(
                      //padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '10 experiences',
                        style: t.font8.copyWith(
                            color: t.searchcolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: s.height / 18,
                    ),
                    /**NewWidget(
                        name: 'Current Itinerary',
                        icon: 'assets/images/sidenav1.png'),
                    NewWidget(
                        name: 'Settings', icon: 'assets/images/sidenav2.png'),**/
                    NewWidget(
                        name: 'Rate us on App Store',
                        icon: 'assets/images/sidenav3.png'),
                    TextButton(
                      onPressed: () {
                        print('yo');
                        Share.share('ok');
                      },
                      child: NewWidget(
                          name: 'Share with friends',
                          icon: 'assets/images/sidenav4.png'),
                    ),
                    NewWidget(
                        name: 'Log Out', icon: 'assets/images/sidenav5.png')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Follow us on',
                      style: t.font8.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: s.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://www.instagram.com/jaunnt/?igshid=MjEwN2IyYWYwYw%3D%3D'),
                                ),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: t.searchcolor,
                              child: Icon(FontAwesomeIcons.instagram,
                                  color: t.selectbackgroundcolor, size: 24),
                            )),
                        SizedBox(
                          width: s.width / 30,
                        ),
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse(
                              'https://www.linkedin.com/company/jaunnt/')),
                          child: Icon(FontAwesomeIcons.linkedin,
                              color: t.searchcolor, size: 37),
                        ),
                        SizedBox(
                          width: s.width / 30,
                        ),
                        GestureDetector(
                            onTap: () => launchUrl(Uri.parse(
                                'https://twitter.com/jaunntapp?s=21&t=LU1YyV7NL2edDWWXYnsE6g')),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: t.searchcolor,
                              child: Icon(FontAwesomeIcons.twitter,
                                  color: t.selectbackgroundcolor, size: 20),
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(height: s.height / 10)
              ],
            )),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  String name;
  String icon;
  NewWidget({Key? key, this.name = '', required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            width: 40,
          ),
          SizedBox(
            width: ScreenWidth(context).width / 70,
          ),
          Text(name, style: ThemeHelper().font8.copyWith(fontSize: 16))
        ],
      ),
    );
  }
}
