import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _otpFormKey = GlobalKey<FormFieldState>();
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
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 40, right: 40),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Reset Password',
                                style: theme.font10.copyWith(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: s.height / 70,
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
                                        color: theme.buttoncolor2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: s.sheight(6),
                                  width: s.width / 2.6,
                                  margin: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.0),
                                      border:
                                          Border.all(color: theme.searchcolor)),
                                  child: TextFormField(
                                    style: theme.font10.copyWith(fontSize: 14),
                                    obscureText: false,
                                    controller: otp,
                                    textAlign: TextAlign.start,
                                    key: _otpFormKey,
                                    cursorColor: theme.searchcolor,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
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
                                  width: s.width / 2.6,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0, 1),
                                          blurRadius: 1,
                                          spreadRadius: 0.5)
                                    ],
                                    borderRadius: BorderRadius.circular(13.0),
                                    color: theme.backgroundColor,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 11),
                                  child: Center(
                                    child: Text(
                                      'GET OTP',
                                      style:
                                          theme.font10.copyWith(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: s.sheight(6),
                              margin:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: condition
                                          ? theme.searchcolor
                                          : Colors.grey.shade400)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      enabled: condition ? true : false,
                                      style:
                                          theme.font10.copyWith(fontSize: 14),
                                      obscureText: view ? true : false,
                                      controller: password,
                                      textAlign: TextAlign.start,
                                      key: _passwordFormKey,
                                      cursorColor: theme.searchcolor,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter New Password",
                                          hintStyle: theme.font2.copyWith(
                                              color: condition
                                                  ? theme.buttoncolor2
                                                  : Colors.grey.shade400,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
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
                                      color: condition
                                          ? theme.searchcolor
                                          : Colors.grey.shade300,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(15),
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
                          borderRadius: BorderRadius.circular(10.0),
                          color: theme.searchcolor,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: theme.font10.copyWith(
                                fontSize: 16, color: theme.backgroundColor),
                          ),
                        ),
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
