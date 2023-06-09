import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _nameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _usernameFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  bool isdisabled = false;
  bool view = false;
  bool condition = false;
  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: s.height,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child:
                            Image.asset('assets/images/Nomads Road Trip.png')),
                    SizedBox(
                      height: s.height / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logooo 1.png',
                            width: s.height / 11),
                        Text('JAUNNT',
                            style: theme.font10.copyWith(
                              fontSize: 30,
                            ))
                      ],
                    ),
                    Container(
                      child: Text(
                        'Rediscover travel like never before',
                        style: theme.font10.copyWith(fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: s.height / 50,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, left: 40, right: 40),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  child: Text(
                                    'Create an account by filling the following:',
                                    style: theme.font10.copyWith(fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: s.height / 50,
                              ),
                              Container(
                                height: s.sheight(6),
                                margin: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border:
                                        Border.all(color: theme.searchcolor)),
                                child: TextFormField(
                                  style: theme.font10.copyWith(fontSize: 14),
                                  obscureText: false,
                                  controller: name,
                                  textAlign: TextAlign.start,
                                  key: _nameFormKey,
                                  cursorColor: theme.searchcolor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle: theme.font2.copyWith(
                                          color: theme.searchcolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      isdisabled =
                                          _emailFormKey.currentState!.isValid;
                                      _emailFormKey.currentState?.validate();
                                    });
                                  },
                                  /**validator: (text) {
                                      if (text == null || text.isEmpty) {
                                      return 'Please enter some text';
                                      } else {
                                      return null;
                                      }
                                      },**/
                                ),
                              ),
                              Container(
                                height: s.sheight(6),
                                margin: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border:
                                        Border.all(color: theme.searchcolor)),
                                child: TextFormField(
                                  style: theme.font10.copyWith(fontSize: 14),
                                  obscureText: false,
                                  controller: email,
                                  textAlign: TextAlign.start,
                                  key: _emailFormKey,
                                  cursorColor: theme.searchcolor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone Number or Email",
                                      hintStyle: theme.font2.copyWith(
                                          color: theme.searchcolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      isdisabled =
                                          _emailFormKey.currentState!.isValid;
                                      _emailFormKey.currentState?.validate();
                                    });
                                  },
                                  /**validator: (text) {
                                      if (text == null || text.isEmpty) {
                                      return 'Please enter some text';
                                      } else {
                                      return null;
                                      }
                                      },**/
                                ),
                              ),
                              Container(
                                height: s.sheight(6),
                                margin: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border:
                                        Border.all(color: theme.searchcolor)),
                                child: TextFormField(
                                  style: theme.font10.copyWith(fontSize: 14),
                                  obscureText: false,
                                  controller: username,
                                  textAlign: TextAlign.start,
                                  key: _usernameFormKey,
                                  cursorColor: theme.searchcolor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: theme.font2.copyWith(
                                          color: theme.searchcolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  onChanged: (value) {
                                    setState(() {
                                      isdisabled =
                                          _emailFormKey.currentState!.isValid;
                                      _emailFormKey.currentState?.validate();
                                    });
                                  },
                                  /**validator: (text) {
                                      if (text == null || text.isEmpty) {
                                      return 'Please enter some text';
                                      } else {
                                      return null;
                                      }
                                      },**/
                                ),
                              ),
                              Container(
                                height: s.sheight(6),
                                margin: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border:
                                        Border.all(color: theme.searchcolor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: TextFormField(
                                        style:
                                            theme.font10.copyWith(fontSize: 14),
                                        obscureText: view ? true : false,
                                        controller: password,
                                        textAlign: TextAlign.start,
                                        key: _passwordFormKey,
                                        cursorColor: theme.searchcolor,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: theme.font2.copyWith(
                                                color: theme.searchcolor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                        onChanged: (value) {
                                          setState(() {
                                            isdisabled = _emailFormKey
                                                .currentState!.isValid;
                                            _emailFormKey.currentState
                                                ?.validate();
                                          });
                                        },
                                        /**validator: (text) {
                                            if (text == null || text.isEmpty) {
                                            return 'Please enter some text';
                                            } else {
                                            return null;
                                            }
                                            },**/
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          view = !view;
                                        });
                                      },
                                      child: Icon(
                                        view == false
                                            ? CupertinoIcons.eye
                                            : CupertinoIcons.eye_slash,
                                        color: theme.searchcolor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: s.height / 100,
                              ),
                              Container(
                                color: Colors.white,
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0, 3),
                                          blurRadius: 3,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: theme.searchcolor,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Center(
                                    child: Text(
                                      'Create Account',
                                      style: theme.font10.copyWith(
                                          fontSize: 16,
                                          color: theme.backgroundColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
