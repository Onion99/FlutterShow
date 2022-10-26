import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspireui/extensions.dart';
import 'package:inspireui/utils/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/config/defalut_env.dart';
import '../common/constants/event_bus.dart';
import '../inject/injection.dart';
import '../modules/dynamic_layout/config/app_config.dart';
import '../util/logs.dart';

import 'dart:convert' as convert;

class AppModel with ChangeNotifier{
  /// -------- 默认语言 ------------///
  String langCode = DefaultConfig.advanceConfig['DefaultLanguage'];
  /// -------- 主题样式 ------------///
  ThemeMode themeMode = ThemeMode.light;
  bool get darkTheme => themeMode == ThemeMode.dark;
  set darkTheme(bool value) => themeMode = value ? ThemeMode.dark : ThemeMode.light;
  /// -------- App配置 ------------///
  AppConfig? appConfig;




  // Constructor
  AppModel([String? lang]) {
    langCode = lang ?? DefaultConfig.advanceConfig['DefaultLanguage'];
  }



  /// ------------------------------------------------------------------------
  /// 切换语言
  /// ------------------------------------------------------------------------
  Future<bool> changeLanguage(String languageCode, BuildContext context) async {
    try {
      langCode = languageCode;
      // 保存语言配置
      var prefs = injector<SharedPreferences>();
      await prefs.setString('language', langCode);
      // 重新加载App配置
      await loadAppConfig(isSwitched: true);
      // 发送语言事件
      eventBus.fire(const EventChangeLanguage());
      return true;
    } catch (err) {
      return false;
    }
  }


  /// Loading State setting
  bool isLoading = true;
  bool isInit = false;
  /// ------------------------------------------------------------------------
  /// 加载App配置
  /// ------------------------------------------------------------------------
  Future<AppConfig?> loadAppConfig({isSwitched = false, Map<String, dynamic>? config}) async {
    var startTime = DateTime.now();
    try {
      // load local config
      var path = 'lib/config/config_$langCode.json';
      try {
        final appJson = await rootBundle.loadString(path);
        appConfig = AppConfig.fromJson(convert.jsonDecode(appJson));
      } catch (e) {
        final appJson = await rootBundle.loadString(DefaultConfig.appConfig);
        appConfig = AppConfig.fromJson(convert.jsonDecode(appJson));
      }
      isLoading = false;
      notifyListeners();
      printLog('[Debug] Finish Load AppConfig', startTime);
      return appConfig;
    } catch (err, trace) {
      printLog('🔴 AppConfig JSON loading error');
      printLog(err);
      printLog(trace);
      isLoading = false;
      notifyListeners();
      return null;
    }
  }


  Future<void> updateTheme(bool theme) async {
    try {
      var prefs = injector<SharedPreferences>();
      darkTheme = theme;
      await prefs.setBool('darkTheme', theme);
      notifyListeners();
    } catch (error) {
      printLog('[updateTheme] error: ${error.toString()}');
    }
  }

}