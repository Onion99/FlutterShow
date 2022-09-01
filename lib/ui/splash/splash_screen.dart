
import 'package:flutter_show/widget/image/flux_image.dart';
import 'package:flutter_show/widget/image/image_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show/common/config/defalut_env.dart';
import 'package:flutter_show/ui/splash/splash_screen_anim.dart';
import 'package:flutter_show/ui/splash/splash_screen_static_anim.dart';

import '../../util/colors.dart';
import '../../util/helper.dart';
import 'splash_screen_static.dart';

class SplashScreenTypeConstants {
  // 这里都是配合进场图片,完成进场动画
  static const fadeIn = 'fade-in';
  static const zoomIn = 'zoom-in';
  static const zoomOut = 'zoom-out';
  static const topDown = 'top-down';
  static const static = 'static';
  // 下面三种,需要对应动画文件路径
  static const rive = 'rive';
  static const flare = 'flare';
  static const lottie = 'lottie';
}

Map get SplashScreenConfig => DefaultConfig.splashScreen;

class SplashScreenIndex extends StatelessWidget {
  final Function actionDone;
  final String splashScreenType;
  final String imageUrl;
  final int duration;

  const SplashScreenIndex({
    Key? key,
    required this.actionDone,
    required this.imageUrl,
    this.splashScreenType = SplashScreenTypeConstants.static,
    this.duration = 2000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxFit = ImageTools.boxFit(
      SplashScreenConfig['boxFit'],
      defaultValue: BoxFit.contain,
    );
    final backgroundColor = HexColor(SplashScreenConfig['backgroundColor'] ?? '#ffffff');
    final paddingTop = Helper.formatDouble(SplashScreenConfig['paddingTop']) ?? 0.0;
    final paddingBottom = Helper.formatDouble(SplashScreenConfig['paddingBottom']) ?? 0.0;
    final paddingLeft = Helper.formatDouble(SplashScreenConfig['paddingLeft']) ?? 0.0;
    final paddingRight = Helper.formatDouble(SplashScreenConfig['paddingRight']) ?? 0.0;
    switch (splashScreenType) {
      case SplashScreenTypeConstants.rive:
        var animationName = SplashScreenConfig['animationName'];
        return RiveSplashScreen(
          onSuccess: actionDone,
          imageUrl: imageUrl,
          animationName: animationName,
          duration: duration,
          backgroundColor: backgroundColor,
          boxFit: boxFit,
          paddingTop: paddingTop,
          paddingBottom: paddingBottom,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
        );
      case SplashScreenTypeConstants.flare:
        return FlareSplashScreen.navigate(
          name: imageUrl,
          startAnimation: SplashScreenConfig['animationName'],
          backgroundColor: backgroundColor,
          boxFit: boxFit,
          paddingTop: paddingTop,
          paddingBottom: paddingBottom,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
          next: actionDone,
          until: () => Future.delayed(Duration(milliseconds: duration)),
        );
      case SplashScreenTypeConstants.lottie:
        return LottieSplashScreen(
          imageUrl: imageUrl,
          onSuccess: actionDone,
          duration: duration,
          backgroundColor: backgroundColor,
          boxFit: boxFit,
          paddingTop: paddingTop,
          paddingBottom: paddingBottom,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
        );
      case SplashScreenTypeConstants.fadeIn:
      case SplashScreenTypeConstants.topDown:
      case SplashScreenTypeConstants.zoomIn:
      case SplashScreenTypeConstants.zoomOut:
        return AnimatedSplash(
          imagePath: imageUrl,
          animationEffect: splashScreenType,
          next: actionDone,
          duration: duration,
          backgroundColor: backgroundColor,
          boxFit: boxFit,
          paddingTop: paddingTop,
          paddingBottom: paddingBottom,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
        );
      case SplashScreenTypeConstants.static:
      default:
        return StaticSplashScreen(
          imagePath: imageUrl,
          onNextScreen: actionDone,
          duration: duration,
          backgroundColor: backgroundColor,
          boxFit: boxFit,
          paddingTop: paddingTop,
          paddingBottom: paddingBottom,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
        );
    }
  }
}
