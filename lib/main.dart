import 'dart:async';
import 'dart:io';

import 'package:flutter_show/services/locale_service.dart';
import 'package:flutter_show/util/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'inject/injection.dart';

void main() {
  printLog('[main] ===== START main.dart =======');

  /// 提前初始化App与Widget框架的绑定,避免一些白屏问题
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    // 设置安卓状态栏和导航栏颜色
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black));
  }
  // 全局捕获异常
  runZonedGuarded(() async {
    // 依赖注入初始化
    await DependencyInjection.initInject();

    // 固定屏幕方向
    unawaited(
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

    // 获取系统语言
    var lang = injector<SharedPreferences>().getString('language');

    if (lang?.isEmpty ?? true) {
      lang = await LocaleService().getDeviceLanguage();
    }
    // 开始初始化UI
    runApp(App(lang.toString()));
  }, (error, stack) {
    printLog(error);
    printLog(stack);
  });
}
