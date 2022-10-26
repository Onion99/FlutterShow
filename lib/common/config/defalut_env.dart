class DefaultConfig{


  static String appConfig = 'lib/config/config_en.json';

  // App Config
  static Map advanceConfig = {
    'DefaultLanguage'   : 'en',
    'AutoDetectLanguage': false,
    /// Disable inAppWebView to use webview_flutter
    /// so webview can navigate to external app.
    /// Useful for webview checkout which need to handle payment in another app.
    'inAppWebView': false,
    'AlwaysClearWebViewCache': false,
    'WebViewScript': '',
    /// set isCaching to true if you have upload the config file to mstore-api
    /// set kIsResizeImage to true if you have finished running Re-generate image plugin
    /// ref: https://support.inspireui.com/help-center/articles/3/8/19/app-performance
    'isCaching': false,
    'kIsResizeImage': false,
    'httpCache': true,
    /// if the woo commerce website supports multi languages
    /// set false if the website only have one language
    'isMultiLanguages': false,
  };

  static Map defaultDrawer = {};

  // Splash Config
  static Map splashScreen = {
    'enable': true,
    'type': 'flare',
    'image': 'assets/images/splashscreen.flr',
    'boxFit': 'contain',
    'backgroundColor': '#ffffff',
    'paddingTop': 0,
    'paddingBottom': 0,
    'paddingLeft': 0,
    'paddingRight': 0,
    'animationName': 'fluxstore',
    'duration': 2000,
  };

  // Splash Board Config
  static List onBoardingData = [
    {
      'title': 'Welcome to FluxStore',
      'image': 'assets/images/fogg-delivery-1.png',
      'desc': 'Fluxstore is on the way to serve you. '
    },
    {
      'title': 'Connect Surrounding World',
      'image': 'assets/images/fogg-uploading-1.png',
      'desc':
      'See all things happening around you just by a click in your phone. Fast, convenient and clean.'
    },
    {
      'title': "Let's Get Started",
      'image': 'assets/images/fogg-order-completed.png',
      'desc': "Waiting no more, let's see what we get!"
    }
  ];

  // Language Config
  static List<Map> languagesInfo = [
    // 1 English - en.arb
    {
      "name": "English",
      "icon": "assets/images/country/gb.png",
      "code": "en",
      "text": "English",
      "storeViewCode": ""
    },
    // 2 zh-Chinese
    {
      "name": "Chinese",
      "icon": "assets/images/country/zh.png",
      "code": "zh",
      "text": "中文",
      "storeViewCode": ""
    },
    // 3 Arabic ar.arb
    {
      "name": "Arabic",
      "icon": "assets/images/country/ar.png",
      "code": "ar",
      "text": "العربية",
      "storeViewCode": "ar"
    },
    // 4 Chinese Traditional intl_zh_Hant.arb
    {
      "name": "Chinese (traditional)",
      "icon": "assets/images/country/zh.png",
      "code": "zh_TW",
      "text": "漢語",
      "storeViewCode": ""
    },
    // 5 Chinese Simplified intl_zh_Hans.arb
    {
      "name": "Chinese (simplified)",
      "icon": "assets/images/country/zh.png",
      "code": "zh_CN",
      "text": "汉语",
      "storeViewCode": ""
    }
  ];

  static Map? loadingIcon;

  // Web
  static bool alwaysClearWebViewCache = false;

}