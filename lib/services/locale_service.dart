import 'package:devicelocale/devicelocale.dart';


class LocaleService {
  /// -------- 获取当前设备语言 ------------///
  Future<String> getDeviceLanguage() async {
    final locale = await Devicelocale.currentLocale;
    return locale.toString().split('-').first.toLowerCase().split('_').first;
  }
}
