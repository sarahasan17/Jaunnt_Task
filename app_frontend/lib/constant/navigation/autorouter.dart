import 'package:app_frontend/screen/AddExperienceScreen/presentation/ImagePickerScreen/ImagePickerScreen.dart'
    as _i2;
import 'package:flutter/material.dart' as _iA;
import 'package:auto_route/auto_route.dart' as _iB;
import 'package:app_frontend/screen/AddExperienceScreen/presentation/AddExperienceScreen.dart'
    as _i1;

import '../../screen/AddExperienceScreen/presentation/AddExperienceScreen.dart';

class AppRouter extends _iB.RootStackRouter {
  AppRouter([_iA.GlobalKey<_iA.NavigatorState> navigatorKey])
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
  };
  @override
  // TODO: implement routes
  List<_iB.RouteConfig> get routes => [
        _iB.RouteConfig(AddExperienceScreen.name, path: '/addexp'),
        _iB.RouteConfig(ImagePickerScreen.name, path: '/img'),
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
