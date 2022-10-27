

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt injector = GetIt.instance;

class DependencyInjection{
  /// ------------------------------------------------------------------------
  /// 初始化依赖注入
  /// ------------------------------------------------------------------------
  static Future<void> initInject() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    injector.registerSingleton<SharedPreferences>(sharedPreferences);

    /// create app folder & init local storage
    await FileHelper.createAppFolder();
    final localStorage = LocalStorage(LocalStorageKey.app);
    await localStorage.ready;
    injector.registerSingleton<LocalStorage>(localStorage);

  }
}


const String appFolder = '';

class FileHelper {
  static Future<String> createAppFolder() async {
    if (appFolder.isEmpty) {
      return '';
    }
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocDirFolder = Directory('${appDocDir.path}/$appFolder');

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final appDocDirNewFolder = await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }
}


class LocalStorageKey {
  static const String loggedIn = '${appFolder}loggedIn';
  static const String app = '${appFolder}fstore';
  static const String notification = '${appFolder}notification';
  static const String blogWishList = '${appFolder}blogWishList';
  static const String recentBlogsSearch = '${appFolder}recentBlogSearch';
  static const String dataOrder = '${appFolder}data_order';
  static const String address = '${appFolder}address';
  static const String userCookie = '${appFolder}userToken';
  static const String instagramLocalKey = '${appFolder}instagram_';

  /// NORMAL APPS
  static const String seen = 'seen';
  static const String posAddress = 'posAddress';
}