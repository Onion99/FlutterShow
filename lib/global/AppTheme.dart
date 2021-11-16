import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const int _themeLight = 1;
  static const int _themeDark = 2;
  static int themeMode = _themeLight;

  // 获取Material主题样式
  static getMaterialThemeFromMode() {
    return themeMode == _themeLight ? lightTheme : darkTheme;
  }

  // 获取自定义主题样式
  static getCustomThemeFromMode(){
    return themeMode == _themeLight ? CustomTheme.lightCustomAppTheme : CustomTheme.darkCustomAppTheme;
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xff3d63ff),
    canvasColor: Colors.transparent,
    backgroundColor: Color(0xfff6f6f6),
    scaffoldBackgroundColor: Color(0xfff6f6f6),
    appBarTheme: AppBarTheme(
      textTheme: lightAppBarTextTheme,
      actionsIconTheme: IconThemeData(
        color: Color(0xff495057),
      ),
      color: Color(0xffffffff),
      iconTheme: IconThemeData(color: Color(0xff495057), size: 24),
    ),
    navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme:
            IconThemeData(color: Color(0xff3d63ff), opacity: 1, size: 24),
        unselectedIconTheme:
            IconThemeData(color: Color(0xff495057), opacity: 1, size: 24),
        backgroundColor: Color(0xffffffff),
        elevation: 3,
        selectedLabelTextStyle: TextStyle(color: Color(0xff3d63ff)),
        unselectedLabelTextStyle: TextStyle(color: Color(0xff495057))),
    colorScheme: ColorScheme.light(
        primary: Color(0xff3d63ff),
        onPrimary: Colors.white,
        primaryVariant: Color(0xff0055ff),
        secondary: Color(0xff495057),
        secondaryVariant: Color(0xff3cd278),
        onSecondary: Colors.white,
        surface: Color(0xffe2e7f1),
        background: Color(0xfff3f4f7),
        onBackground: Color(0xff495057)),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.4),
      elevation: 1,
      margin: EdgeInsets.all(0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 15, color: Color(0xaa495057)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Color(0xff3d63ff)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.black54),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.black54)),
    ),
    splashColor: Colors.white.withAlpha(100),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: lightTextTheme,
    indicatorColor: Colors.white,
    disabledColor: Color(0xffdcc7ff),
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xff3d63ff),
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: Color(0xff3d63ff),
        hoverColor: Color(0xff3d63ff),
        foregroundColor: Colors.white),
    dividerColor: Color(0xffd1d1d1),
    errorColor: Color(0xfff0323c),
    cardColor: Colors.white,
    accentColor: Color(0xff3d63ff),
    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xffffffff),
      textStyle:
          lightTextTheme.bodyText2!.merge(TextStyle(color: Color(0xff495057))),
    ),
    bottomAppBarTheme:
        BottomAppBarTheme(color: Color(0xffffffff), elevation: 2),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff3d63ff),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff3d63ff), width: 2.0),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xff3d63ff),
      inactiveTrackColor: Color(0xff3d63ff).withAlpha(140),
      trackShape: RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: Color(0xff3d63ff),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      canvasColor: Colors.transparent,
      primaryColor: Color(0xff3d63ff),
      scaffoldBackgroundColor: Color(0xff1b1b1b),
      backgroundColor: Color(0xff1b1b1b),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xff1b1b1b)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xff3d63ff),
        primaryVariant: Color(0xff3d63ff),
        secondary: Color(0xff00cc77),
        secondaryVariant: Color(0xff00cc77),
        background: Color(0xff1b1b1b),
        onPrimary: Colors.white,
        onBackground: Colors.white,
        onSecondary: Colors.white,
        surface: Color(0xff585e63),
      ),
      cardTheme: CardTheme(
        color: Color(0xff37404a),
        shadowColor: Color(0xff000000),
        elevation: 1,
        margin: EdgeInsets.all(0),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: darkTextTheme,
      indicatorColor: Colors.white,
      disabledColor: Color(0xffa3a3a3),
      highlightColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Color(0xff3d63ff)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.white70),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.white70)),
      ),
      dividerColor: Color(0xff363636),
      errorColor: Colors.orange,
      cardColor: Color(0xff282a2b),
      splashColor: Colors.white.withAlpha(100),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff3d63ff),
          splashColor: Colors.white.withAlpha(100),
          highlightElevation: 8,
          elevation: 4,
          focusColor: Color(0xff3d63ff),
          hoverColor: Color(0xff3d63ff),
          foregroundColor: Colors.white),
      accentColor: Color(0xff3d63ff),
      popupMenuTheme: PopupMenuThemeData(
        color: Color(0xff37404a),
        textStyle: lightTextTheme.bodyText2!
            .merge(TextStyle(color: Color(0xffffffff))),
      ),
      bottomAppBarTheme:
          BottomAppBarTheme(color: Color(0xff464c52), elevation: 2),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Color(0xff495057),
        labelColor: Color(0xff3d63ff),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xff3d63ff), width: 2.0),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Color(0xff3d63ff),
        inactiveTrackColor: Color(0xff3d63ff).withAlpha(100),
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbColor: Color(0xff3d63ff),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      cupertinoOverrideTheme: CupertinoThemeData());

  // 标题栏颜色样式
  static const int _appBarTextColorLight = 0xff495057;
  static const int _appBarTextColorDark = 0xffffffff;

  // AppBar文字样式 light
  static final TextTheme lightAppBarTextTheme = TextTheme(
    headline1: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 102, color: Color(_appBarTextColorLight))),
    headline2: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 64, color: Color(_appBarTextColorLight))),
    headline3: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 51, color: Color(_appBarTextColorLight))),
    headline4: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 36, color: Color(_appBarTextColorLight))),
    headline5: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 25, color: Color(_appBarTextColorLight))),
    headline6: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 18, color: Color(_appBarTextColorLight))),
    subtitle1: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 17, color: Color(_appBarTextColorLight))),
    subtitle2: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 15, color: Color(_appBarTextColorLight))),
    bodyText1: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 16, color: Color(_appBarTextColorLight))),
    bodyText2: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 14, color: Color(_appBarTextColorLight))),
    button: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 15, color: Color(_appBarTextColorLight))),
    caption: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 13, color: Color(_appBarTextColorLight))),
    overline: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 11, color: Color(_appBarTextColorLight))),
  );

  // AppBar文字样式 dark
  static final TextTheme darkAppBarTextTheme = TextTheme(
    headline1: GoogleFonts.ibmPlexSans(
        textStyle:
            TextStyle(fontSize: 102, color: Color(_appBarTextColorDark))),
    headline2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 64, color: Color(_appBarTextColorDark))),
    headline3: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 51, color: Color(_appBarTextColorDark))),
    headline4: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 36, color: Color(_appBarTextColorDark))),
    headline5: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 25, color: Color(_appBarTextColorDark))),
    headline6: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 20, color: Color(_appBarTextColorDark))),
    subtitle1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 17, color: Color(_appBarTextColorDark))),
    subtitle2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(_appBarTextColorDark))),
    bodyText1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 16, color: Color(_appBarTextColorDark))),
    bodyText2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 14, color: Color(_appBarTextColorDark))),
    button: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(_appBarTextColorDark))),
    caption: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 13, color: Color(_appBarTextColorDark))),
    overline: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 11, color: Color(_appBarTextColorDark))),
  );

  static final int _textColorLight = 0xff4a4c4f;
  static final Color _textColorDark = Colors.white;

  // Content 文字样式 light
  static final TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 102, color: Color(_textColorLight))),
    headline2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 64, color: Color(_textColorLight))),
    headline3: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 51, color: Color(_textColorLight))),
    headline4: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 36, color: Color(_textColorLight))),
    headline5: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 25, color: Color(_textColorLight))),
    headline6: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 18, color: Color(_textColorLight))),
    subtitle1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 17, color: Color(_textColorLight))),
    subtitle2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(_textColorLight))),
    bodyText1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 16, color: Color(_textColorLight))),
    bodyText2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 14, color: Color(_textColorLight))),
    button: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: Color(_textColorLight))),
    caption: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 13, color: Color(_textColorLight))),
    overline: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 11, color: Color(_textColorLight))),
  );

  // Content 文字样式 dark
  static final TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 102, color: _textColorDark)),
    headline2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 64, color: _textColorDark)),
    headline3: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 51, color: _textColorDark)),
    headline4: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 36, color: _textColorDark)),
    headline5: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 25, color: _textColorDark)),
    headline6: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 18, color: _textColorDark)),
    subtitle1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 17, color: _textColorDark)),
    subtitle2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: _textColorDark)),
    bodyText1: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 16, color: _textColorDark)),
    bodyText2: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 14, color: _textColorDark)),
    button: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 15, color: _textColorDark)),
    caption: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 13, color: _textColorDark)),
    overline: GoogleFonts.ibmPlexSans(
        textStyle: TextStyle(fontSize: 11, color: _textColorDark)),
  );

  static TextStyle getTextStyle(TextStyle? textStyle, { int fontWeight = 500,
         bool muted = false, bool xMuted =false, double letterSpacing = 0.15,
         Color? color, TextDecoration decoration = TextDecoration.none,
         double? height, double wordSpacing = 0, double? fontSize} ) {
    double? finalFontSize = fontSize != null ? fontSize : textStyle!.fontSize;
    Color? finalColor;
    if(color==null){
      finalColor= xMuted ? textStyle!.color!.withAlpha(160) : (muted ? textStyle!.color!.withAlpha(200) : textStyle!.color);
    }else{
      finalColor = xMuted ? color.withAlpha(160) : ( muted ? color.withAlpha(200) : color);
    }
    return GoogleFonts.ibmPlexSans(fontSize: finalFontSize, fontWeight: _getFontWeight(fontWeight), letterSpacing: letterSpacing, color: finalColor, decoration: decoration, height: height, wordSpacing: wordSpacing);
  }

  static FontWeight _getFontWeight(int weight) {
    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w300;
      case 500:
        return FontWeight.w400;
      case 600:
        return FontWeight.w500;
      case 700:
        return FontWeight.w600;
      case 800:
        return FontWeight.w700;
      case 900:
        return FontWeight.w900;
    }
    return FontWeight.w400;
  }
}

class CustomTheme{
  Color bgLayer1, bgLayer2,
        border1, border2, disabledColor, onDisabled,
        colorInfo, colorWarning,
        colorSuccess, colorError,
        shadowColor, onInfo,
        onWarning, onSuccess, onError;
  Color lightBlack, red, green, yellow, orange, blue, purple, pink, brown;

  // 隐式{Color border1 = const Color(0xffeeeeee)}
  CustomTheme( {
    this.border1 = const Color(0xffeeeeee),
    this.border2 = const Color(0xffe6e6e6),
    this.bgLayer1 = const Color(0xfff0f0f0),
    this.bgLayer2 = const Color(0xfffefefe),
    this.disabledColor = const Color(0xffdcc7ff),
    this.onDisabled = const Color(0xffffffff),
    this.colorWarning = const Color(0xffffc837),
    this.colorInfo = const Color(0xffff784b),
    this.colorSuccess = const Color(0xff3cd278),
    this.shadowColor = const Color(0xff1f1f1f),
    this.onInfo = const Color(0xffffffff),
    this.onWarning = const Color(0xffffffff),
    this.onSuccess = const Color(0xffffffff),
    this.colorError = const Color(0xfff0323c),
    this.onError = const Color(0xffffffff),
    //Color
    this.lightBlack = const Color(0xffa7a7a7),
    this.red = const Color(0xffFF0000),
    this.green = const Color(0xff008000),
    this.yellow = const Color(0xfffff44f),
    this.orange = const Color(0xffFFA500),
    this.blue = const Color(0xff0000ff),
    this.purple = const Color(0xff800080),
    this.pink = const Color(0xffFFC0CB),
    this.brown = const Color(0xffA52A2A),
  });


  static CustomTheme lightCustomAppTheme = CustomTheme(
    bgLayer1: Color(0xfff6f6f6),
    bgLayer2: Color(0xffffffff),
    disabledColor: Color(0xff636363),
    onDisabled: Color(0xffffffff),
    colorInfo: Color(0xffff784b),
    colorWarning: Color(0xffffc837),
    colorSuccess: Color(0xff3cd278),
    shadowColor: Color(0xffd9d9d9),
    onInfo: Color(0xffffffff),
    onSuccess: Color(0xffffffff),
    onWarning: Color(0xffffffff),
    colorError: Color(0xfff0323c),
    onError: Color(0xffffffff),
  );

  static CustomTheme darkCustomAppTheme = CustomTheme(
      bgLayer1: Color(0xff1b1b1b),
      bgLayer2: Color(0xff252525),
      border1: Color(0xff303030),
      border2: Color(0xff363636),
      disabledColor: Color(0xffbababa),
      onDisabled: Color(0xff000000),
      colorInfo: Color(0xffff784b),
      colorWarning: Color(0xffffc837),
      colorSuccess: Color(0xff3cd278),
      shadowColor: Color(0xff202020),
      onInfo: Color(0xffffffff),
      onSuccess: Color(0xffffffff),
      onWarning: Color(0xffffffff),
      colorError: Color(0xfff0323c),
      onError: Color(0xffffffff)
  );

}
