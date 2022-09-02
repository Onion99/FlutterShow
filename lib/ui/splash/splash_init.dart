


import 'package:flutter/material.dart';
import 'package:flutter_show/ui/base/base_screen.dart';
import 'package:flutter_show/ui/splash/splash_screen.dart';

import '../../common/config/ui_config.dart';
import '../../common/constants/route_list.dart';
import '../../util/logs.dart';

class SplashInit extends StatefulWidget{

  @override
  State createState()  => _SplashInitState();

  const SplashInit();
}

class _SplashInitState extends BaseScreen<SplashInit>{

  void checkToShowNextScreen() {
    Navigator.of(context).pushReplacementNamed(RouteList.onBoarding);
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

}