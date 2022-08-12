import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onion_flutter/inject/injection.dart';
import 'package:onion_flutter/modules/dynamic_layout/config/app_setting.dart';
import 'package:onion_flutter/notifier/app_model.dart';
import 'package:onion_flutter/notifier/user_model.dart';
import 'package:onion_flutter/routes/overlay_control_delegate.dart';
import 'package:onion_flutter/routes/route_observer.dart';
import 'package:onion_flutter/services/locale_service.dart';
import 'package:onion_flutter/util/colors.dart';
import 'package:onion_flutter/util/logs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import 'common/theme/light_theme.dart';
import 'config/ui_config.dart';
import 'generated/l10n.dart';
import 'modules/dynamic_layout/config/app_config.dart';
import 'notifier/recent_product_model.dart';

void main() {
  printLog('[main] ===== START main.dart =======');
  /// 提前初始化App与Widget框架的绑定,避免一些白屏问题
  WidgetsFlutterBinding.ensureInitialized();
  // 全局捕获异常
  runZonedGuarded(() async {
    // 依赖注入初始化
    await DependencyInjection.initInject();

    // 设置安卓状态栏和导航栏颜色
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black
    ));

    // 固定屏幕方向
    unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));


    // 获取系统语言
    var lang = injector<SharedPreferences>().getString('language');

    if(lang?.isEmpty ?? true){
      lang = await LocaleService().getDeviceLanguage();
    }
    // 开始初始化UI
    runApp(App(lang.toString()));
  }, (error, stack) {
    printLog(error);
    printLog(stack);
  });
}

class App extends StatefulWidget {
  final String  languageCode;

  App(this.languageCode);

  static final GlobalKey<NavigatorState> fluxStoreNavigatorKey = GlobalKey();


  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver{

  late AppModel appModel;

  final user = UserModel();
  final recent = RecentModel();

  @override
  void initState() {
    printLog('[AppState] initState');
    appModel = AppModel(widget.languageCode);
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printLog('[AppState] Build app.dart');
    SizeConfig().init(context);

    return ChangeNotifierProvider<AppModel>.value(
        value: appModel,
        // Selector https://juejin.cn/post/6844904145774870536
        child: Selector<AppModel,Tuple2<String,ThemeMode>>(
          selector: (context,model) => Tuple2(model.langCode,model.themeMode),
          builder: (context,value,child){
            var languageCode = value.item1;
            var themeMode = value.item2;
            var countryCode = '';

            if (languageCode.contains('_')) {
              countryCode = languageCode.substring(languageCode.indexOf('_') + 1);
              languageCode = languageCode.substring(0, languageCode.indexOf(('_')));
            }

            return Directionality(
                textDirection: TextDirection.rtl,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<UserModel>.value(value: user),
                    Provider<RecentModel>.value(value: recent),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: Locale(languageCode, countryCode),
                    // 定义全局 navigatorKey (context)
                    navigatorKey: App.fluxStoreNavigatorKey,
                    // 路由变化的监听
                    navigatorObservers: [
                      MyRouteObserver(
                          action: (screenName) => OverlayControlDelegate().emitRoute?.call(screenName)),
                    ],
                    // 国际化
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    theme: getTheme(
                      appConfig: null,
                      langCode: languageCode,
                      themeMode: themeMode,
                    ),
                    themeMode: themeMode,
                  ),
                )
            );
          },
        ),
    );
  }




  /// Build the App Theme
  ThemeData getTheme({
    required AppConfig? appConfig,
    required String langCode,
    required ThemeMode themeMode,
  }) {
    return buildLightTheme(langCode);
  }
}