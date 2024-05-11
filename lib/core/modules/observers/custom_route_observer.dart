import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../utils/methods/aliases.dart';

class CustomRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    logIt.info('New route pushed: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logIt.info('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logIt.info('Tab route re-visited: ${route.name}');
  }
}
