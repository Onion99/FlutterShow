


import 'package:flutter/material.dart';
import 'package:flutter_show/common/constants.dart';
import 'package:flutter_show/ui/base/base_screen.dart';
import 'package:flutter_show/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../common/config/ui_config.dart';
import '../../modules/dynamic_layout/config/app_config.dart';
import '../../notifier/app_model.dart';
import '../../util/logs.dart';

class SplashInit extends StatefulWidget{

  @override
  State createState()  => _SplashInitState();

  const SplashInit();
}

class _SplashInitState extends BaseScreen<SplashInit>{

  late AppConfig? appConfig;

  /// ------------------------------------------------------------------------
  /// 初始化开屏数据
  /// ------------------------------------------------------------------------
  Future<void> loadInitData() async {
    appConfig = await Provider.of<AppModel>(context, listen: false).loadAppConfig();
    /// Request more Async data which is not use on home screen
    Future.delayed(Duration.zero, () {
      /// do some thing

    });
    printLog('[AppState] InitData Finish');
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await loadInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog('[SplashInitState] Build splash_init.dart');

    SizeConfig().init(context);

    var splashScreenType = SplashScreenTypeConstants.rive/*SplashScreenConfig['type']*/;
    dynamic splashScreenImage = 'assets/images/splashscreen.riv'/*SplashScreenConfig['image']*/;
    var duration = SplashScreenConfig['duration'] ?? 2000;

    return SplashScreenIndex(
      imageUrl: splashScreenImage,
      splashScreenType: splashScreenType,
      actionDone: checkToShowNextScreen,
      duration: duration,
    );
  }
  
  /// ------------------------------------------------------------------------
  /// 跳到Slogan页面
  /// ------------------------------------------------------------------------
  void checkToShowNextScreen() {
    Navigator.of(context).pushReplacementNamed(RouteList.onBoarding);
  }

}