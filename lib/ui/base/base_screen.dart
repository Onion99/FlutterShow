import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then((_) {
        if (mounted) afterFirstLayout(context);
      }
    );
  }

  void afterFirstLayout(BuildContext context) {}

  /// Get size screen
  Size get screenSize => MediaQuery.of(context).size;
}
