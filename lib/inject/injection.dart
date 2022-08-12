

import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants/local_storage_key.dart';

GetIt injector = GetIt.instance;

class DependencyInjection{
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