import 'package:flutter/material.dart';
import 'package:flutter_show/common/config/defalut_env.dart';
import 'package:flutter_show/widget/loading/spinkit_loading.dart';

import 'loading_config.dart';

/// For Loading Widget
Widget LoadingWidget(context) {
  var loadingConfig = LoadingConfig.fromJson(DefaultConfig.loadingIcon ?? {});
  return SpinkitLoading(loadingConfig);
}
