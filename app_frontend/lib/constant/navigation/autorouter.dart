import 'package:app_frontend/screen/AddExperienceScreen/presentation/ImagePickerScreen/ImagePickerScreen.dart'
    as _i2;
import 'package:app_frontend/screen/ProfileScreen/profile_screen.dart' as _i3;
import 'package:flutter/material.dart' as _iA;
import 'package:auto_route/auto_route.dart' as _iB;
import 'package:app_frontend/screen/AddExperienceScreen/presentation/AddExperienceScreen.dart'
    as _i1;
import 'package:app_frontend/screen/HomeScreen/presentation/pages/HomeScreen.dart'
    as _i4;

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
    HomeScreen.name: (routeData) {
      return _iB.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.HomeScreen());
    },
  };
  @override
  // TODO: implement routes
  List<_iB.RouteConfig> get routes => [
        _iB.RouteConfig(AddExperienceScreen.name, path: '/addexp'),
        _iB.RouteConfig(ImagePickerScreen.name, path: '/img'),
        _iB.RouteConfig(ProfileScreen.name, path: '/profile'),
        _iB.RouteConfig(HomeScreen.name, path: '/home'),
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
/// [_i4.HomeScreen]
class HomeScreen extends _iB.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/home');

  static const String name = 'home';
}
