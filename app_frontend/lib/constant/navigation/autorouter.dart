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
  };

  @override
  // TODO: implement routes
  List<_iB.RouteConfig> get routes => [
        _iB.RouteConfig(AddExperienceScreen.name, path: '/addexp'),
      ];
}

/// generated route for
/// [_i1.AddExperienceScreen]
class AddExperienceScreen extends _iB.PageRouteInfo<void> {
  const AddExperienceScreen() : super(AddExperienceScreen.name, path: '/login');

  static const String name = 'LoginScreen';
}
