import 'package:flutter/material.dart';


/// ------------------------------------------------------------------------
/// 一个Navigator观察者，它通知RouteAware其Route状态的更改
/// ------------------------------------------------------------------------
class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {

  final Function(String?) action;
  MyRouteObserver({required this.action});

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    action.call(screenName);
    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
