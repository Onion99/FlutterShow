import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onion_flutter/config/UIConfig.dart';
import 'package:onion_flutter/global/AppTheme.dart';
import 'package:onion_flutter/global/ThemeNotifier.dart';
import 'package:onion_flutter/ui/home/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  // 提前初始化App与Widget框架的绑定,避免一些白屏问题
  WidgetsFlutterBinding.ensureInitialized();
  // 固定横屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value){
        // 通过Provider实现主题状态监听
       runApp(ChangeNotifierProvider<ThemeNotifier>(
           create: (context) => ThemeNotifier(),
           child: MyApp(),
       ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return MaterialApp(
      theme: AppTheme.getMaterialThemeFromMode(),
      home: Homepage(),
    );
  }
}
