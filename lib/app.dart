
import 'package:flutter_show/routes/overlay_control_delegate.dart';
import 'package:flutter_show/routes/route_observer.dart';
import 'package:flutter_show/ui/splash/splash_init.dart';
import 'package:flutter_show/util/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_show/widget/main_layout/main_layout.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'common/theme/light_theme.dart';
import 'generated/l10n.dart';
import 'modules/dynamic_layout/config/app_config.dart';
import 'notifier/app_model.dart';
import 'notifier/user_model.dart';


class App extends StatefulWidget {

  final String  languageCode;

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
  Widget build(BuildContext context) {
    printLog('[AppState] Build app.dart');

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
                  home: const Scaffold(
                    body: SplashInit(),
                  ),
                  builder: (_,widget) => MainLayout(widget: widget!),
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