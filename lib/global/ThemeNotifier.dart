import 'package:flutter/cupertino.dart';
import 'package:onion_flutter/global/AppTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 如果标识符以下划线（_）开头，则它相对于库是私有的
class ThemeNotifier extends ChangeNotifier{

  static int _themeMode = 1;

  ThemeNotifier(){ init(); }

  init() async {
    // 异步等待结果
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? data = sp.getInt("themeMode");
    // data 为空则用默认主题
    _themeMode = data?? 1;
    // 配置主题
    _changeTheme(_themeMode);
    // 通知监听器
    notifyListeners();
  }



  _changeTheme(int mode){
    _themeMode = mode;
    AppTheme.themeMode = mode;
  }
}