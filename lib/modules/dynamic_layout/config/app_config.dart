import 'app_setting.dart';

class AppConfig{
  late AppSetting settings;

  AppConfig({
    required this.settings
  });


  AppConfig.fromJson(dynamic json) {
    if (json['Setting'] != null) {
      settings = AppSetting.fromJson(json['Setting']);
    }
  }
}