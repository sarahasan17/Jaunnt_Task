import 'dart:io';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/ProfileScreen/presentation/ImagePickerScreen2/ImagePickerScreen.dart';
import 'package:app_frontend/screen/ProfileScreen/presentation/Profilecubit/ProfileCubit.dart';
import 'package:app_frontend/screen/Profile_followers/presentation/ProfileFollowersScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/errors/error_popup.dart';
import '../../constant/hive.dart';
import '../../constant/loading_widget.dart';
import 'EditProfile/Presentation/cubit/EditProfileCubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  bool edit = false;
  final GlobalKey<FormFieldState> _edit_nameFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _edit_bioFormKey =
      GlobalKey<FormFieldState>();
  TextEditingController edit_name = TextEditingController();
  TextEditingController edit_bio = TextEditingController();
  @override
  String? edit_name1;
  String? edit_bio1;
  @override
  int val = 10;
  String? image;
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ErrorPopup(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const LoadingWidget();
            } else if (state is ProfileSuccess) {
              var profile = state.response;
              return Scaffold(
                body: SafeArea(
                  child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, bottom: 0),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: s.height / 4.8,
                            child: BlocConsumer<EditProfileCubit,
                                EditProfileState>(listener: (context, state) {
                              if (state is EditProfileError) {
                                ErrorPopup(context, state.msg);
                              }
                              if (state is EditProfileSuccess) {
                                const SnackBar(
                                  content: Text('Profile Updated Successfully'),
                                  backgroundColor: Colors.green,
                                );
                                //context.router.popAndPush(const LoginScreen());
                              }
                            }, builder: (context, state) {
                              if (state is EditProfileLoading) {
                                return const LoadingWidget();
                              }
                              return Stack(
                                children: [
                                  Positioned(
                                      top: s.height / 60,
                                      left: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (edit == true) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ImagePickerScreen2()));
                                          }
                                        },
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: mybox.get(4) != null
                                                ? Image.file(
                                                    File(mybox.get(4)),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    profile.profilePhoto),
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                      top: s.height / 40,
                                      left: s.width / 3.3,
                                      child: edit == true
                                          ? SizedBox(
                                              height: s.height / 25,
                                              width: s.width / 2,
                                              child: TextFormField(
                                                style: theme.font1.copyWith(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                controller: edit_name,
                                                key: _edit_nameFormKey,
                                                textAlign: TextAlign.start,
                                                cursorColor: theme.buttoncolor,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0,
                                                          vertical: 0),
                                                  hintText: edit_name1,
                                                  hintStyle: theme.font1
                                                      .copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              ),
                                            )
                                          : Text(
                                              profile.fullName,
                                              style: theme.font1.copyWith(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                  Positioned(
                                      top: s.height / 16,
                                      left: s.width / 3.3,
                                      child: edit == true
                                          ? SizedBox(
                                              height: s.height / 25,
                                              width: s.width / 1.7,
                                              child: TextFormField(
                                                style: theme.font2,
                                                controller: edit_bio,
                                                key: _edit_bioFormKey,
                                                textAlign: TextAlign.start,
                                                cursorColor:
                                                    theme.buttoncolor,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    hintText: edit_bio1,
                                                    hintStyle: theme.font2),
                                              ),
                                            )
                                          : Container(
                                              width: s.width / 1.7,
                                              child: Text(
                                                edit_bio1!,
                                                style: theme.font2
                                                    .copyWith(fontSize: 14),
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
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(35),
                                              bottomLeft: Radius.circular(35),
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileFollowersScreen(
                                                              initialIndex: 0,
                                                            )));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    profile.followingCount
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileFollowersScreen(
                                                              initialIndex: 1,
                                                            )));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    profile.followersCount
                                                        .toString(),
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
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/share.png'),
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
                                              BlocProvider.of<EditProfileCubit>(
                                                      context)
                                                  .editprofile(File(image!),
                                                      edit_bio.text);
                                            }
                                            edit = !edit;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: const Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                              color: edit == true
                                                  ? theme.savechangescolor
                                                  : theme.profilebuttoncolor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            edit == true
                                                ? "Save changes"
                                                : 'Edit Profile',
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
                              );
                            }),
                          ),
                          SizedBox(height: s.height / 180),
                          Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: Center(
                              child: TabBar(
                                  controller: tabcontroller,
                                  labelColor: theme.buttoncolor,
                                  unselectedLabelColor: theme.buttoncolor,
                                  labelPadding: EdgeInsets.symmetric(
                                      horizontal: s.width / 12),
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
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}

class TabBars extends StatelessWidget {
  TabBars({Key? key, required this.part}) : super(key: key);
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
