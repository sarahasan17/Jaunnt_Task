import 'package:app_frontend/screen/AddExperienceScreen/presentation/ImagePickerScreen/ImagePickerScreen.dart'
    as _i2;
import 'package:app_frontend/screen/ProfileScreen/profile_screen.dart' as _i3;
import 'package:app_frontend/screen/SplashScreen/presentation/SplashScreen.dart'
    as _i10;
import 'package:flutter/material.dart' as _iA;
import 'package:auto_route/auto_route.dart' as _iB;
import 'package:app_frontend/screen/AddExperienceScreen/presentation/AddExperienceScreen.dart'
    as _i1;
import 'package:app_frontend/screen/HomeScreen/presentation/home.dart' as _i5;
import 'package:app_frontend/screen/Place_DetailedScreen/presentation/place_detailed.dart'
    as _i6;
import '../../screen/Explore/Presentation/pages/ExploreScreen.dart' as _i4;
import 'package:app_frontend/screen/ExperienceScreen/presentation/ExperienceScreen.dart'
    as _i7;
import 'package:app_frontend/screen/Bottomnavbarscreen/bottomnavbar.dart'
    as _i8;
import 'package:app_frontend/screen/LoginScreen/presentation/LoginScreen.dart'
    as _i11;
import 'package:app_frontend/screen/ResetPassword/presentation/pages/ResetPasswordScreen.dart'
    as _i12;

import 'autorouter.dart';

class AppRouter extends _iB.RootStackRouter {
  AppRouter([_iA.GlobalKey<_iA.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _iB.PageFactory> pagesMap = {
    AddExperienceScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AddExperienceScreen());
    },
    PlaceDetailed.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.PlaceDetailed());
    },
    BottomNavbar.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.BottomNavbar());
    },
    ExperienceScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.ExperienceScreen());
    },
    SplashScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.SplashScreen());
    },
    LoginScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: _i11.LoginScreen());
    },
    ResetPasswordScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.RestPasswordScreen());
    },
  };
  @override
  // TODO: implement routes
  List<_iB.RouteConfig> get routes => [
        _iB.RouteConfig(AddExperienceScreen.name, path: '/addexp'),
        _iB.RouteConfig(PlaceDetailed.name, path: '/place'),
        _iB.RouteConfig(ExperienceScreen.name, path: '/experience'),
        _iB.RouteConfig(BottomNavbar.name, path: '/BottomNavbar'),
        _iB.RouteConfig(SplashScreen.name, path: '/SplashScreen'),
        _iB.RouteConfig(LoginScreen.name, path: '/LoginScreen'),
        _iB.RouteConfig(ResetPasswordScreen.name, path: '/ResetPasswordScreen'),
      ];
}

/// generated route for
/// [_i1.AddExperienceScreen]
class AddExperienceScreen extends _iB.PageRouteInfo<void> {
  const AddExperienceScreen()
      : super(AddExperienceScreen.name, path: '/addexp');

  static const String name = 'addexp';
}

/// generated route for
/// [_i6.PlaceDetailed]
class PlaceDetailed extends _iB.PageRouteInfo<void> {
  const PlaceDetailed() : super(PlaceDetailed.name, path: '/place_detailed');

  static const String name = 'place';
}

/// generated route for
/// [_i7.ExperienceScreen]
class ExperienceScreen extends _iB.PageRouteInfo<void> {
  const ExperienceScreen() : super(ExperienceScreen.name, path: '/experience');

  static const String name = 'experience';
}

/// generated route for
/// [_i8.BottomNavbar()]
class BottomNavbar extends _iB.PageRouteInfo<void> {
  const BottomNavbar() : super(BottomNavbar.name, path: '/BottomNavbar');

  static const String name = 'BottomNavbar';
}

/// generated route for
/// [_i10.SplashScreen]
class SplashScreen extends _iB.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/SplashScreen');

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i11.LoginScreen]
class LoginScreen extends _iB.PageRouteInfo<void> {
  const LoginScreen() : super(LoginScreen.name, path: '/LoginScreen');

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i12.ResetPasswordScreen]
class ResetPasswordScreen extends _iB.PageRouteInfo<void> {
  const ResetPasswordScreen()
      : super(ResetPasswordScreen.name, path: '/ResetPasswordScreen');

  static const String name = 'ResetPasswordScreen';
}
