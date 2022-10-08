import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspireui/extensions.dart';

import '../common/constants/route_list.dart';
import '../ui/onboard/onboard_screen.dart';
import '../util/logs.dart';

class Routes {
  /// ------------------------------------------------------------------------
  /// 生成跳转路由
  /// ------------------------------------------------------------------------
  static MaterialPageRoute _buildRoute(RouteSettings settings, WidgetBuilder builder, {bool fullscreenDialog = false}) {
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
      case RouteList.onBoarding:
        return _buildRoute(
          settings,
          (context) => const OnBoardScreen(),
        );
      default: return _ErrorRoute();
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
