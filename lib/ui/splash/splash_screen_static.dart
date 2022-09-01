import 'package:flutter/material.dart';

import 'package:flutter_show/widget/image/flux_image.dart';


class StaticSplashScreen extends StatelessWidget {

  final String imagePath;
  final Function? onNextScreen;
  final int duration;
  final Color backgroundColor;
  final BoxFit boxFit;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;

  const StaticSplashScreen({
    required this.imagePath,
    key,
    this.onNextScreen,
    this.duration = 2500,
    this.backgroundColor = Colors.white,
    this.boxFit = BoxFit.contain,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          left: paddingLeft,
          right: paddingRight,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return imagePath.startsWith('http')
                ? FluxImage(
              imageUrl: imagePath,
              fit: boxFit,
              height: constraints.maxHeight,
              width: constraints.maxWidth, package: '', color: null,
            )
                : Image.asset(
              imagePath,
              gaplessPlayback: true,
              fit: boxFit,
              height: constraints.maxHeight,
              width: constraints.maxWidth,
            );
          },
        ),
      ),
    );
  }
}
