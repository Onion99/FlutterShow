import 'package:flutter/material.dart';
import 'package:flutter_show/config/defalut_env.dart';

import '../modules/dynamic_layout/config/app_config.dart';

class AppModel with ChangeNotifier{


  String langCode = DefaultConfig.advanceConfig['DefaultLanguage'];

  ThemeMode themeMode = ThemeMode.light;
  late AppConfig appConfig;

  bool get darkTheme => themeMode == ThemeMode.dark;
  set darkTheme(bool value) => themeMode = value ? ThemeMode.dark : ThemeMode.light;



  /// App Model Constructor
  AppModel([String? lang]) {
    langCode = lang ?? DefaultConfig.advanceConfig['DefaultLanguage'];
  }
}