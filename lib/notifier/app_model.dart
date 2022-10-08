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


  String langCode = DefaultConfig.advanceConfig['DefaultLanguage'];

  ThemeMode themeMode = ThemeMode.light;
  late AppConfig appConfig;

  bool get darkTheme => themeMode == ThemeMode.dark;

  set darkTheme(bool value) => themeMode = value ? ThemeMode.dark : ThemeMode.light;



  // Constructor
  AppModel([String? lang]) {
    langCode = lang ?? DefaultConfig.advanceConfig['DefaultLanguage'];
  }



  Future<bool> changeLanguage(String languageCode, BuildContext context) async {
    try {
      langCode = languageCode;
      var prefs = injector<SharedPreferences>();
      await prefs.setString('language', langCode);
      eventBus.fire(const EventChangeLanguage());
      return true;
    } catch (err) {
      return false;
    }
  }


  /// Loading State setting
  bool isLoading = true;
  bool isInit = false;


  Future<AppConfig?> loadAppConfig({isSwitched = false, Map<String, dynamic>? config}) async {
    var startTime = DateTime.now();

    try {
      if (config != null) {
        appConfig = AppConfig.fromJson(config);
      } else {

        var loadAppConfigDone = false;

        if (loadAppConfigDone == false) {
          /// we only apply the http config if isUpdated = false, not using switching language
          if (DefaultConfig.appConfig.indexOf('http') != -1) {
            // load on cloud config and update on air
            var path = DefaultConfig.appConfig;
            if (path.contains('.json')) {
              path = path.substring(0, path.lastIndexOf('/'));
              path += '/config_$langCode.json';
            }
            final appJson = await httpGet(Uri.encodeFull(path).toUri()!,
                headers: {'Accept': 'application/json'});
            appConfig = AppConfig.fromJson(convert.jsonDecode(convert.utf8.decode(appJson.bodyBytes)));
          } else {
            // load local config
            var path = 'lib/config/config_$langCode.json';
            try {
              final appJson = await rootBundle.loadString(path);
              appConfig = AppConfig.fromJson(convert.jsonDecode(appJson));
            } catch (e) {
              final appJson = await rootBundle.loadString(DefaultConfig.appConfig);
              appConfig = AppConfig.fromJson(convert.jsonDecode(appJson));
            }
          }
        }
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

}