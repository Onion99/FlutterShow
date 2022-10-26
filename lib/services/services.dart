

import 'package:flutter_show/services/service_config.dart';

class Services with ConfigMixin{
  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();
}
