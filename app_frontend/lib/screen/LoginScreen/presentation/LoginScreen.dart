import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/HomeScreen/presentation/home.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constant/navigation/autorouter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  bool isdisabled = false;
  bool view = false;
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
                    Center(child: Image.asset('assets/images/Nomads Moto.png')),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          SizedBox(
                            height: s.height / 100,
                          ),
                          Container(
                            height: s.sheight(6),
                            margin:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: theme.searchcolor)),
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
                            margin:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: theme.searchcolor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    style: theme.font10.copyWith(fontSize: 14),
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
                          GestureDetector(
                            onTap: () {
                              context.router.push(const ResetPasswordScreen());
                            },
                            child: Container(
                              //margin: const EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Forgot Password?',
                                style: theme.font10.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 25, bottom: 25, right: 25),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'New to Jaunnt?',
                              style: theme.font10.copyWith(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: s.height / 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.router.push(const SignUpScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(0, 3),
                                          blurRadius: 3,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: theme.backgroundColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Text(
                                    'Sign Up',
                                    style: theme.font10.copyWith(fontSize: 16),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.router.push(const BottomNavbar());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0, 3),
                                          blurRadius: 3,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: theme.searchcolor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Text(
                                    'Login',
                                    style: theme.font10.copyWith(
                                        fontSize: 16,
                                        color: theme.backgroundColor),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
