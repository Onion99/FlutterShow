
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_show/common/constants/general.dart';
import 'package:flutter_show/generated/l10n.dart';
import 'package:flutter_show/menu/side_menu.dart';
import 'package:flutter_show/menu/sidebar.dart';
import 'package:flutter_show/modules/dynamic_layout/config/app_setting.dart';
import 'package:flutter_show/notifier/app_model.dart';
import 'package:flutter_show/util/logs.dart';
import 'package:flutter_show/widget/main_layout/layout_left_menu.dart';
import 'package:flutter_show/widget/tabbar/tabbar_custom.dart';
import 'package:provider/provider.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key? key}) : super(key: key);

  @override
  MainTabsState createState() => MainTabsState();
}

class MainTabsState extends State<MainTabs> with WidgetsBindingObserver {

  final List<Widget> _tabView = [];
  AppSetting get appSetting => Provider.of<AppModel>(context, listen: false).appConfig!.settings;
  final navigators = <int, GlobalKey<NavigatorState>>{};


  /// TabBar variable
  late TabController tabController;



  /// ------------------------------------------------------------------------
  /// 生命周期-监听
  /// ------------------------------------------------------------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Handle the DeepLink notification
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground

    }
    super.didChangeAppLifecycleState(state);
  }

  /// ------------------------------------------------------------------------
  /// 生命周期-结束
  /// ------------------------------------------------------------------------
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    printLog('[TabBar] ============== tabbar.dart ==============');
    var appConfig = Provider.of<AppModel>(context, listen: false).appConfig;
    // empty page
    if (_tabView.isEmpty || appConfig == null) {
      return Container(
        color: Colors.white,
      );
    }

    final media = MediaQuery.of(context);
    printLog('[ScreenSize]: ${media.size.width} x ${media.size.height}');


    final isTabBarEnabled = appSetting.tabBarConfig.enable;
    final showFloating = appSetting.tabBarConfig.showFloating;
    final isClip = appSetting.tabBarConfig.showFloatingClip;
    final floatingActionButtonLocation = appSetting.tabBarConfig.tabBarFloating.location ?? FloatingActionButtonLocation.centerDocked;


    return SideMenu(
      backgroundColor: showFloating ? null : Theme.of(context).backgroundColor,
      bottomNavigationBar: null,
      tabBarOnTop: appConfig.settings.tabBarConfig.enableOnTop,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: null,
      zoomConfig: appConfig.drawer?.zoomConfig,
      sideMenuBackground: appConfig.drawer?.backgroundColor,
      sideMenuBackgroundImage: appConfig.drawer?.backgroundImage,
      colorFilter: appConfig.drawer?.colorFilter,
      filter: appConfig.drawer?.filter,
      drawer: (appConfig.drawer?.enable ?? true) ? const SideBarMenu() : null,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: Theme.of(context).colorScheme.secondary,
          barBackgroundColor: Theme.of(context).backgroundColor,
          textTheme: CupertinoTextThemeData(
            navActionTextStyle: Theme.of(context).primaryTextTheme.button,
            navTitleTextStyle: Theme.of(context).textTheme.headline5,
            navLargeTitleTextStyle:
            Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        child: WillPopScope(
          onWillPop: _handleWillPopScopeRoot,
          child: LayoutLeftMenu(
            menu:
            (appConfig.drawer?.enable ?? true) ? const SideBarMenu() : null,
            content: MediaQuery(
              data: false ? media.copyWith(
                  size: Size(
                    media.size.width,
                    media.size.height,
                  ))
                  : media,
              child: ChangeNotifierProvider.value(
                value: tabController,
                child: Consumer<TabController>(
                    builder: (context, controller, child) {
                      /// use for responsive web/mobile
                      return Stack(
                        fit: StackFit.expand,
                        children: List.generate(
                          _tabView.length,
                              (index) {
                            final active = controller.index == index;
                            return Offstage(
                              offstage: !active,
                              child: TickerMode(
                                enabled: active,
                                child: _tabView[index],
                              ),
                            );
                          },
                        ).toList(),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // /// return the tabBar widget
  // Widget tabBarMenu() {
  //   return TabBarCustom(
  //     tabData: tabData,
  //     tabController: tabController,
  //     config: appSetting,
  //     shouldHideTabBar: false,
  //     totalCart: 1,
  //     onTap: (int ) {  },
  //   );
  // }

  /// Check pop navigator on the Current tab, and show Confirm Exit App
  Future<bool> _handleWillPopScopeRoot() async {
    final currentNavigator = navigators[tabController.index]!;
    if (currentNavigator.currentState!.canPop()) {
      currentNavigator.currentState!.pop();
      return Future.value(false);
    }

    /// Check pop root navigator
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return Future.value(false);
    }

    if (tabController.index != 0) {
      tabController.animateTo(0);
      return Future.value(false);
    } else {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).areYouSure),
          content: Text(S.of(context).doYouWantToExitApp),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.of(context).no),
            ),
            TextButton(
              onPressed: () {
                if (isIos) {
                  Navigator.of(context).pop(true);
                } else {
                  SystemNavigator.pop();
                }
              },
              child: Text(S.of(context).yes),
            ),
          ],
        ),
      );
    }
  }
}