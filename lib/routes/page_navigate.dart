import 'package:flutter/material.dart';
import 'package:flutter_show/menu/maintab_delegate.dart';

import '../app.dart';

/// Push screen on TabBar
class PageNavigate {
  static NavigatorState get _rootNavigator => Navigator.of(App.appNavigatorKey.currentContext!);

  static NavigatorState get _tabNavigator => Navigator.of(MainTabControlDelegate.getInstance().tabKey()!.currentContext!);

  static NavigatorState get _navigator => true ? _tabNavigator : _rootNavigator;

  static dynamic generateUri(arguments, routeName) {
    var id = null;
    if (id != null) {
      return Uri(path: routeName, queryParameters: {'id': id}).toString();
    }
    return routeName;
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool forceRootNavigator = false,
  }) {
    /// Override the routeName with new Uri format, support Web param
    routeName = generateUri(arguments, routeName);

    if (forceRootNavigator) {
      return _rootNavigator.pushNamed<T?>(
        routeName,
        arguments: arguments,
      );
    }

    return _navigator.pushNamed<T?>(
      routeName,
      arguments: arguments,
    );
  }

  static Future pushReplacementNamed(String routeName, {Object? arguments, bool forceRootNavigator = false}) {
    if (forceRootNavigator) {
      return _rootNavigator.pushReplacementNamed(routeName);
    }
    return _navigator.pushReplacementNamed(routeName);
  }

  static Future pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate, {Object? arguments, bool forceRootNavigator = false,}) {
    if (forceRootNavigator) {
      return _rootNavigator.pushNamedAndRemoveUntil(routeName, predicate,
          arguments: arguments);
    }
    return _navigator.pushNamedAndRemoveUntil(routeName, predicate,
        arguments: arguments);
  }

  static Future<dynamic> push(Route<dynamic> route, {bool forceRootNavigator = false}) {
    if (forceRootNavigator) {
      return _rootNavigator.push(route);
    }
    return _navigator.push(route);
  }
}
