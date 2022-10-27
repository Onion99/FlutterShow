
import 'package:flutter_show/routes/route.dart';
import 'package:flutter_show/util/colors.dart';
import 'package:flutter_show/widget/overlay/overlay_control_delegate.dart';
import 'package:flutter_show/routes/route_observer.dart';
import 'package:flutter_show/ui/splash/splash_init.dart';
import 'package:flutter_show/util/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_show/widget/main_layout/main_layout.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'common/theme/dark_theme.dart';
import 'common/theme/light_theme.dart';
import 'generated/l10n.dart';
import 'modules/dynamic_layout/config/app_config.dart';
import 'notifier/app_model.dart';
import 'notifier/user_model.dart';


class App extends StatefulWidget {
  /// -------- eg:en ------------///
  final String languageCode;

  App(this.languageCode);

  static final GlobalKey<NavigatorState> fluxStoreNavigatorKey = GlobalKey();


  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver{

  late AppModel appModel;

  final _user = UserModel();

  @override
  void initState() {
    printLog('[AppState] initState');
    appModel = AppModel(widget.languageCode);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    printLog('[AppState] Build app.dart');

    return ChangeNotifierProvider<AppModel>.value(
      value: appModel,
      // Selector https://juejin.cn/post/6844904145774870536
      child: Selector<AppModel,Tuple3<String,ThemeMode,AppConfig?>>(
        selector: (context,model) => Tuple3(model.langCode,model.themeMode, model.appConfig),
        builder: (context,value,child){
          var languageCode = value.item1;
          var themeMode = value.item2;
          var appConfig = value.item3;
          var countryCode = '';

          if (languageCode.contains('_')) {
            countryCode = languageCode.substring(languageCode.indexOf('_') + 1);
            languageCode = languageCode.substring(0, languageCode.indexOf(('_')));
          }

          return Directionality(
              textDirection: TextDirection.rtl,
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<UserModel>.value(value: _user),
                  // Provider<RecentModel>.value(value: _recent),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: Locale(languageCode, countryCode),
                  // 定义全局 navigatorKey (context)
                  navigatorKey: App.fluxStoreNavigatorKey,
                  // 路由变化的监听
                  navigatorObservers: [
                    MyRouteObserver(action: (screenName) => OverlayControlDelegate().emitRoute?.call(screenName)),
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
                    appConfig: appConfig,
                    langCode: languageCode,
                    themeMode: themeMode,
                  ),
                  // 路由生成
                  onGenerateRoute: Routes.getRouteGenerate,
                  themeMode: themeMode,
                  home: const Scaffold(
                    body: SplashInit(),
                  ),
                  //所以一些toast库等需要全局context的三方库，会用builder将自己加到widget tree中。MaterialApp的builder属性提供的方法，只会在MaterialApp构建时被调用一回
                  builder: (_,widget) => MainLayout(widget: widget!),
                ),
              )
          );
        },
      ),
    );
  }




  /// Build the App Theme
  ThemeData getTheme({required AppConfig? appConfig, required String langCode, required ThemeMode themeMode,}) {

    var theme =  buildLightTheme(langCode);
    /// 首次加载白色主题
    if (appConfig == null) {
      return theme;
    }
    /// 判断是不是黑暗模式
    var isDarkTheme = themeMode == ThemeMode.dark;

    if (isDarkTheme) {
      theme = buildDarkTheme(langCode);
    } else {
      theme = buildLightTheme(langCode);
    }


    /// The app will use mainColor from env.dart,
    /// or override it with mainColor from config JSON if found.
    var mainColor = appConfig.settings.mainColor;
    var colorScheme = theme.colorScheme.copyWith(
      primary: HexColor(mainColor),
    );

    return theme.copyWith(
      primaryColor: HexColor(mainColor),
      colorScheme: colorScheme,
      useMaterial3: appConfig.settings.useMaterial3,
    );
  }
}