
import 'package:flutter/material.dart';

// 屏幕宽高配置
class SizeConfig{
  static late MediaQueryData _mediaQueryData;
  // 屏幕的宽高
  static late double screenWidth;
  static late double screenHeight;
  // 异形屏需要注意的宽高
  static late double safeWidth;
  static late double safeHeight;
  static late double scaleFactorWidth;
  static late double scaleFactorHeight;


  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth =  _mediaQueryData.size.width;
    screenHeight =  _mediaQueryData.size.height;
    double _safeAreaWidth = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    double _safeAreaHeight = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeWidth = (screenWidth - _safeAreaWidth);
    safeHeight = (screenHeight - _safeAreaHeight);
    //Scale factor for responsive UI
    scaleFactorHeight = (safeHeight / 820);
    if (scaleFactorHeight < 1) {
      double diff = (1 - scaleFactorHeight) * (1 - scaleFactorHeight);
      scaleFactorHeight += diff;
    }
    scaleFactorWidth = safeWidth / 392;
    if (scaleFactorWidth < 1) {
      double diff = (1 - scaleFactorWidth) * (1 - scaleFactorWidth);
      scaleFactorWidth += diff;
    }
  }

  static double getScaledSizeWidth(double size) {
    return (size * scaleFactorWidth);
  }

  static double getScaledSizeHeight(double size) {
    return (size * scaleFactorHeight);
  }
}

// 间距配置
class Spacing {
  static EdgeInsetsGeometry only({double top = 0, double right = 0, double bottom = 0, double left = 0}) {
    return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
  }

  static EdgeInsetsGeometry fromLTRB(double left, double top, double right, double bottom) {
    return Spacing.only(bottom: bottom, top: top, right: right, left: left);
  }
}

// 空间大小配置
class Space{

  static Widget height(double space){
    return SizedBox(height: SizeConfig.getScaledSizeHeight(space),);
  }

  static Widget width(double space){
    return SizedBox(width: SizeConfig.getScaledSizeHeight(space),);
  }

}


enum ShapeTypeFor{
  container,
  button
}

class Shape{

  static dynamic circular(double radius,{ShapeTypeFor shapeTypeFor=ShapeTypeFor.container}){
    BorderRadius borderRadius = BorderRadius.all(Radius.circular(SizeConfig.getScaledSizeHeight(radius)));
    switch(shapeTypeFor) {
      case ShapeTypeFor.container:
        return borderRadius;
      case ShapeTypeFor.button:
        return RoundedRectangleBorder(borderRadius: borderRadius);
    }
  }

  static dynamic circularTop(double radius,{ShapeTypeFor shapeTypeFor=ShapeTypeFor.container}){

    BorderRadius borderRadius = BorderRadius.only(topLeft: Radius.circular(SizeConfig.getScaledSizeHeight(radius)),topRight: Radius.circular(SizeConfig.getScaledSizeHeight(radius)));
    switch(shapeTypeFor) {
      case ShapeTypeFor.container:
        return borderRadius;
      case ShapeTypeFor.button:
        return RoundedRectangleBorder(borderRadius: borderRadius);
    }
  }

}