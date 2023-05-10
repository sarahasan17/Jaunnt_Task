import 'package:flutter/material.dart';

import '../../../../constant/screen_width.dart';
import '../../../../constant/theme/themehelper.dart';
import '../../../Profile_followers/presentation/ProfileFollowersScreen.dart';
import '../../presentation/ImagePickerScreen2/ImagePickerScreen.dart';
/*
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                SizedBox(
                  height: s.height / 4.8,
                  child: Stack(
                    children: [
                      Positioned(
                          top: s.height / 60,
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ImagePickerScreen2()));
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: mybox.get(4) != null
                                    ? Image.file(
                                        File(mybox.get(4)),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(state.response.profilePhoto),
                              ),
                            ),
                          )),
                      Positioned(
                          top: s.height / 40,
                          left: s.width / 3.3,
                          child: SizedBox(
                            height: s.height / 25,
                            width: s.width / 2,
                            child: TextFormField(
                              style: theme.font1.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                              controller: edit_name,
                              key: _edit_nameFormKey,
                              textAlign: TextAlign.start,
                              cursorColor: theme.buttoncolor,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                hintText: edit_name1,
                                hintStyle: theme.font1.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          )),
                      Positioned(
                          top: s.height / 16,
                          left: s.width / 3.3,
                          child: SizedBox(
                            height: s.height / 25,
                            width: s.width / 1.7,
                            child: Container(
                              child: TextFormField(
                                style: theme.font2,
                                controller: edit_bio,
                                key: _edit_bioFormKey,
                                textAlign: TextAlign.start,
                                cursorColor: theme.buttoncolor,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    hintText: edit_bio1,
                                    hintStyle: theme.font2),
                              ),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileFollowersScreen()));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.response.followingCount
                                            .toString(),
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
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.response.followersCount.toString(),
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
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (edit == true) {
                                  edit_bio1 = edit_bio.text;
                                  edit_name1 = edit_name.text;
                                  image = mybox.get(4);
                                }
                                edit = !edit;
                              });
                            },
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
                                  color: edit == true
                                      ? theme.savechangescolor
                                      : theme.profilebuttoncolor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                edit == true ? "Save changes" : 'Edit Profile',
                                style: theme.font2,
                              ),
                            ),
                          )),
                      Positioned(
                          top: s.height / 40,
                          left: s.width / 5,
                          child: edit == true
                              ? const Icon(
                                  CupertinoIcons.pencil,
                                  size: 30,
                                )
                              : Container()),
                    ],
                  ),
                ),
                SizedBox(height: s.height / 180),
                Container(
                  padding: const EdgeInsets.only(right: 20),
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
                        tabs: [
                          Tab(text: "Experiences ${val * 2}"),
                          const Tab(text: "Saved places"),
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
}*/
