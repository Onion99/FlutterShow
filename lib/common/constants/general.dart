
part of '../constants.dart';

/// check if the environment is web
final bool kIsWeb = UniversalPlatform.isWeb;
final bool isIos = UniversalPlatform.isIOS;
final bool isAndroid = UniversalPlatform.isAndroid;
final bool isMacOS = UniversalPlatform.isMacOS;
final bool isWindow = UniversalPlatform.isWindows;
final bool isFuchsia = UniversalPlatform.isFuchsia;
final bool isMobile = UniversalPlatform.isIOS || UniversalPlatform.isAndroid;
final bool isDesktop = UniversalPlatform.isMacOS || UniversalPlatform.isWindows;


class SettingConstants {
  static const aboutUsUrl = 'https://inspireui.com/about';
}
