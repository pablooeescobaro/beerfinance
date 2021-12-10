// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screens/activity/page.dart' as _i2;
import '../screens/home/home_page.dart' as _i1;
import '../screens/income/page.dart' as _i3;
import '../screens/saving/page.dart' as _i5;
import '../screens/spending/page.dart' as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    ActivityPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ActivityPage());
    },
    IncomePageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.IncomePage());
    },
    SpendingPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.SpendingPage());
    },
    SavingPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.SavingPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(HomeRoute.name, path: '/'),
        _i6.RouteConfig(ActivityPageRoute.name, path: '/activity'),
        _i6.RouteConfig(IncomePageRoute.name, path: '/income'),
        _i6.RouteConfig(SpendingPageRoute.name, path: '/spending'),
        _i6.RouteConfig(SavingPageRoute.name, path: '/saving')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.ActivityPage]
class ActivityPageRoute extends _i6.PageRouteInfo<void> {
  const ActivityPageRoute() : super(name, path: '/activity');

  static const String name = 'ActivityPageRoute';
}

/// generated route for [_i3.IncomePage]
class IncomePageRoute extends _i6.PageRouteInfo<void> {
  const IncomePageRoute() : super(name, path: '/income');

  static const String name = 'IncomePageRoute';
}

/// generated route for [_i4.SpendingPage]
class SpendingPageRoute extends _i6.PageRouteInfo<void> {
  const SpendingPageRoute() : super(name, path: '/spending');

  static const String name = 'SpendingPageRoute';
}

/// generated route for [_i5.SavingPage]
class SavingPageRoute extends _i6.PageRouteInfo<void> {
  const SavingPageRoute() : super(name, path: '/saving');

  static const String name = 'SavingPageRoute';
}
