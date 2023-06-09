import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_frontend/constant/navigation/autorouter.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:app_frontend/screen/HomeScreen/presentation/home.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),
        () => context.router.push(const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash.png"),
                  fit: BoxFit.cover)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 197,
                    height: 212,
                    child: Image.asset(
                      "assets/images/logooo 1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text('JAUNNT', style: theme.font10)),
                ),
                Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text('Rediscover travel like never before',
                          style: theme.font10.copyWith(fontSize: 15))),
                )
              ])),
    );
  }
}
