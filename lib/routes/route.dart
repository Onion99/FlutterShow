import 'package:flutter/material.dart';
import 'package:flutter_show/common/constants.dart';
import 'package:flutter_show/ui/settings/settings_screen.dart';
import 'package:inspireui/extensions.dart';
import '../menu/maintab.dart';
import '../ui/onboard/onboard_screen.dart';
import '../util/logs.dart';

class Routes {
  /// ------------------------------------------------------------------------
  /// 生成跳转路由
  /// ------------------------------------------------------------------------
  static MaterialPageRoute _buildRoute(
      RouteSettings settings, WidgetBuilder builder,
      {bool fullscreenDialog = false}) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }

  /// ------------------------------------------------------------------------
  /// 获取路由生成
  /// ------------------------------------------------------------------------
  static Route getRouteGenerate(RouteSettings settings) {
    var routingData = settings.name!.getRoutingData;

    printLog('[🧬Builder RouteGenerate] ${routingData.route}');

    switch (routingData.route) {
      case RouteList.home:
      case RouteList.category:
      case RouteList.search:
      case RouteList.cart:
      case RouteList.profile:
        return _buildRoute(
          settings,
          (context) => const SettingScreen(),
        );
      case RouteList.dashboard:
        return _buildRoute(
          settings,
          (context) => const MainTabs(),
        );
      case RouteList.onBoarding:
        return _buildRoute(
          settings,
          (context) => const OnBoardScreen(),
        );
      default:
        return _ErrorRoute();
    }
  }

  /// ------------------------------------------------------------------------
  /// 错误路由
  /// ------------------------------------------------------------------------
  static Route _ErrorRoute([String message = 'Page not founds']) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      );
    });
  }
}
