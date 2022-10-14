import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_show/common/tools/adaptive_tools.dart';
import 'package:flutter_show/util/helper.dart';

class LayoutLeftMenu extends StatefulWidget {
  final Widget? menu;
  final Widget? content;

  const LayoutLeftMenu({
    Key? key,
    this.menu,
    this.content,
  }) : super(key: key);

  @override
  State<LayoutLeftMenu> createState() => _LayoutStateLeftMenu();
}

class _LayoutStateLeftMenu extends State<LayoutLeftMenu>
    with SingleTickerProviderStateMixin {
  bool showMenu = false;
  bool isActive = false;

  Duration duration = const Duration(milliseconds: 600);

  bool get isBigScreen => Layout.isDisplayDesktop(context);

  StreamSubscription? _subOpenCustomDrawer;
  StreamSubscription? _subCloseCustomDrawer;
  StreamSubscription? _subSwitchStateCustomDrawer;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _subOpenCustomDrawer?.cancel();
    _subCloseCustomDrawer?.cancel();
    _subSwitchStateCustomDrawer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = 0.0;
    if (Layout.isDisplayDesktop(context)) {
      if (isActive == false) {
        activeLayout();
      }

      if (showMenu) {
        width =  250;
      } else {
        width = 0;
      }
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedContainer(
              width: width,
              curve: Curves.easeInOutQuint,
              duration: duration,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(bottom: 32),
              color: Theme.of(context).primaryColorLight.withOpacity(0.7),
              child: OverflowBox(
                maxWidth: width,
                maxHeight: 1000,
                alignment: context.isRtl ? Alignment.topLeft : Alignment.topRight,
                child: widget.menu,
              ),
            ),
            Expanded(
              child: widget.content!,
            )
          ],
        ),
      ),
    );
  }

  /// Use the isActive variable to detect first run  instead of
  /// using WidgetsBinding.instance.addPostFrameCallback because:
  /// - According to the old mechanism, hiding/showing the left
  /// menu when switching the screen landscape/portrait based on
  ///  setting the Size of the Left Menu and the variable showMenu=true.
  /// - For tablets with vertical screen app launch, the showMenu
  /// variable will always be false. So when rotating the screen
  ///  left menu will not be active.
  void activeLayout() {
    isActive = true;
  }
}
