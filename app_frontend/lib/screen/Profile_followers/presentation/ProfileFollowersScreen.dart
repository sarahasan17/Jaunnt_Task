import 'dart:io';
import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/errors/error_popup.dart';
import '../../../constant/loading_widget.dart';
import '../../ProfileScreen/AddFriend/presentation/addfriend_cubit.dart';
import '../../ProfileScreen/isFriend/cubit/isfriend_cubit.dart';
import '../../ProfileScreen/unfriend/presentation/unfriend_cubit.dart';
import 'following_cubit/followingcubit.dart';

class ProfileFollowersScreen extends StatefulWidget {
  int initialIndex;
  ProfileFollowersScreen({Key? key, required this.initialIndex})
      : super(key: key);

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
    return BlocProvider(
      create: (context) => FollowingCubit(),
      child: Scaffold(
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
                child: DefaultTabController(
                  initialIndex: widget.initialIndex,
                  length: 2,
                  child: TabBar(
                      controller: tabcontroller,
                      labelColor: theme.white,
                      unselectedLabelColor: theme.white,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: s.width / 9.5),
                      unselectedLabelStyle: theme.font2,
                      labelStyle: theme.font2,
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: theme.buttoncolor2,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      tabs: const [
                        Tab(text: "Friends"),
                        // Tab(text: "Followers"),
                      ]),
                ),
              ),
              SizedBox(
                height: s.height / 50,
              ),
              Container(
                height: s.height / 1.2,
                child: TabBarView(
                  controller: tabcontroller,
                  children: [
                    /**BlocConsumer<FollowerCubit, FollowerState>(
                        listener: (context, state) {
                      if (state is FollowerError) {
                        ErrorPopup(context, state.msg);
                      }
                    }, builder: (context, state) {
                      if (state is FollowerLoading) {
                        return const LoadingWidget();
                      } else if (state is FollowerSuccess) {
                        var follower = state.response;
                        return follower.followers.isNotEmpty
                            ? ListView.builder(
                                itemCount: follower.followers.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: s.width / 15,
                                              backgroundColor: theme.white,
                                              child: Image.file(File(follower
                                                  .followers[index]
                                                  .profilePhoto)),
                                            ),
                                            Text(
                                              follower
                                                  .followers[index].fullName,
                                              style: theme.font3
                                                  .copyWith(fontSize: 16),
                                            ),
                                            SizedBox(),
                                            SizedBox(),
                                            SizedBox(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                  color: theme
                                                      .followbackgroundcolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text('Unfollow',
                                                  style: theme.font5),
                                            )
                                          ],
                                        ),
                                      ));
                                })
                            : Center(
                                child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sorry, No matches found:(',
                                      style: ThemeHelper().font3.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: s.height / 8,
                                    )
                                  ],
                                ),
                              ));
                      } else {
                        return const SizedBox();
                      }
                    }),**/
                    BlocConsumer<FollowingCubit, FollowingState>(
                        listener: (context, state) {
                      if (state is FollowingError) {
                        ErrorPopup(context, state.msg);
                      }
                    }, builder: (context, state) {
                      if (state is FollowingLoading) {
                        return const LoadingWidget();
                      } else if (state is FollowingSuccess) {
                        var following = state.response;
                        return following.following.isNotEmpty
                            ? ListView.builder(
                                itemCount: following.following.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: s.width / 15,
                                              backgroundColor: theme.white,
                                              child: Image.file(File(following
                                                  .following[index]
                                                  .profilePhoto)),
                                            ),
                                            Text(
                                              following
                                                  .following[index].fullName,
                                              style: theme.font3
                                                  .copyWith(fontSize: 16),
                                            ),
                                            const SizedBox(),
                                            const SizedBox(),
                                            const SizedBox(),
                                            BlocConsumer<AddFriendCubit,
                                                    AddFriendState>(
                                                listener: (context, state) {
                                              if (state is AddFriendSuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Friend added successfully'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              }
                                              if (state is AddFriendError) {
                                                ErrorPopup(
                                                    context, state.message);
                                              }
                                            }, builder: (context, state) {
                                              if (state is AddFriendLoading) {
                                                return const LoadingWidget();
                                              }
                                              return BlocConsumer<UnFriendCubit,
                                                      UnFriendState>(
                                                  listener: (context, state) {
                                                if (state is UnFriendSuccess) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Friend removed successfully'),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                                }
                                                if (state is UnFriendError) {
                                                  ErrorPopup(
                                                      context, state.message);
                                                }
                                              }, builder: (context, state) {
                                                if (state is UnFriendLoading) {
                                                  return const LoadingWidget();
                                                }
                                                return BlocConsumer<
                                                        IsFriendCubit,
                                                        IsFriendState>(
                                                    listener: (context, state) {
                                                  if (state
                                                      is IsFriendSuccess) {}
                                                  if (state is IsFriendError) {
                                                    ErrorPopup(
                                                        context, state.message);
                                                  }
                                                }, builder: (context, state) {
                                                  if (state
                                                      is IsFriendLoading) {
                                                    return const LoadingWidget();
                                                  } else if (state
                                                      is IsFriendSuccess) {
                                                    bool isfriend =
                                                        state.response.result;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (isfriend == true) {
                                                          if (isfriend ==
                                                              false) {
                                                            context
                                                                .read<
                                                                    AddFriendCubit>()
                                                                .addfriend(
                                                                    following
                                                                        .id);
                                                          } else {
                                                            context
                                                                .read<
                                                                    UnFriendCubit>()
                                                                .unfriend(
                                                                    following
                                                                        .id);
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.4),
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                offset: const Offset(
                                                                    0,
                                                                    1), // changes position of shadow
                                                              ),
                                                            ],
                                                            color: theme
                                                                .followbackgroundcolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                            isfriend
                                                                ? 'Unfriend'
                                                                : 'Add friend',
                                                            style: theme.font5),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                });
                                              });
                                            }),
                                          ],
                                        ),
                                      ));
                                })
                            : Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Sorry, No matches found:(',
                                          style: ThemeHelper().font3.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: s.height / 8,
                                      )
                                    ],
                                  ),
                                ),
                              );
                      } else {
                        return const SizedBox();
                      }
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class TabBars extends StatelessWidget {
  const TabBars({Key? key, required this.data, required this.count})
      : super(key: key);

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
