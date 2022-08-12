import 'package:flutter/material.dart';

import '../model/entities/user.dart';

abstract class UserModelDelegate {
  void onLoaded(User user);

  void onLoggedIn(User user);

  void onLogout(User user);
}

class UserModel with ChangeNotifier{
  UserModel();

}