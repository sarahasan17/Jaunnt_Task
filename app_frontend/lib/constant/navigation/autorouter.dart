import 'package:app_frontend/screen/AddExperienceScreen/presentation/ImagePickerScreen/ImagePickerScreen.dart'
    as _i2;
import 'package:app_frontend/screen/ProfileScreen/profile_screen.dart' as _i3;
import 'package:flutter/material.dart' as _iA;
import 'package:auto_route/auto_route.dart' as _iB;
import 'package:app_frontend/screen/AddExperienceScreen/presentation/AddExperienceScreen.dart'
    as _i1;
import 'package:app_frontend/screen/HomeScreen/home.dart' as _i5;
import 'package:app_frontend/screen/Place_DetailedScreen/place_detailed.dart'
    as _i6;

import '../../screen/Explore/Presentation/pages/ExploreScreen.dart' as _i4;

class AppRouter extends _iB.RootStackRouter {
  AppRouter([_iA.GlobalKey<_iA.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _iB.PageFactory> pagesMap = {
    AddExperienceScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AddExperienceScreen());
    },
    ImagePickerScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ImagePickerScreen());
    },
    ProfileScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ProfileScreen());
    },
    ExploreScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ExploreScreen());
    },
    Home.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.Home());
    },
    PlaceDetailed.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.PlaceDetailed());
    },
  };
  @override
  // TODO: implement routes
  List<_iB.RouteConfig> get routes => [
        _iB.RouteConfig(AddExperienceScreen.name, path: '/addexp'),
        _iB.RouteConfig(ImagePickerScreen.name, path: '/img'),
        _iB.RouteConfig(ProfileScreen.name, path: '/profile'),
        _iB.RouteConfig(ExploreScreen.name, path: '/explore'),
        _iB.RouteConfig(Home.name, path: '/home'),
        _iB.RouteConfig(PlaceDetailed.name, path: '/place'),
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
/// [_i2.ImagePickerScreen]
class ImagePickerScreen extends _iB.PageRouteInfo<void> {
  const ImagePickerScreen() : super(ImagePickerScreen.name, path: '/img');

  static const String name = 'img';
}

/// generated route for
/// [_i3.ProfileScreen]
class ProfileScreen extends _iB.PageRouteInfo<void> {
  const ProfileScreen() : super(ProfileScreen.name, path: '/profile');

  static const String name = 'profile';
}

/// generated route for
/// [_i4.ExploreScreen]
class ExploreScreen extends _iB.PageRouteInfo<void> {
  const ExploreScreen() : super(ExploreScreen.name, path: '/explore');

  static const String name = 'explore';
}

/// generated route for
/// [_i5.Home]
class Home extends _iB.PageRouteInfo<void> {
  const Home() : super(Home.name, path: '/home');

  static const String name = 'home';
}

/// generated route for
/// [_i6.PlaceDetailed]
class PlaceDetailed extends _iB.PageRouteInfo<void> {
  const PlaceDetailed() : super(PlaceDetailed.name, path: '/place_detailed');

  static const String name = 'place';
}
