
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_show/common/constants.dart';
import 'package:flutter_show/generated/l10n.dart';
import 'package:flutter_show/menu/side_menu.dart';
import 'package:flutter_show/menu/sidebar.dart';
import 'package:flutter_show/modules/dynamic_layout/config/app_config.dart';
import 'package:flutter_show/modules/dynamic_layout/config/app_setting.dart';
import 'package:flutter_show/notifier/app_model.dart';
import 'package:flutter_show/ui/base/base_screen.dart';
import 'package:flutter_show/util/logs.dart';
import 'package:flutter_show/widget/main_layout/layout_left_menu.dart';
import 'package:provider/provider.dart';
import '../routes/route.dart';
import '../routes/route_observer.dart';
import '../util/helper.dart';
import '../widget/overlay/overlay_control_delegate.dart';
import '../widget/tabbar/tabbar_custom.dart';
import 'maintab_delegate.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key? key}) : super(key: key);

  @override
  MainTabsState createState() => MainTabsState();
}

class MainTabsState extends BaseScreen<MainTabs> with TickerProviderStateMixin,WidgetsBindingObserver {

  final List<Widget> _tabView = [];
  Map saveIndexTab = {};
  Map<String, String?> childTabName = {};
  var isInitialized = false;

  AppSetting get appSetting => Provider.of<AppModel>(context, listen: false).appConfig!.settings;
  final navigators = <int, GlobalKey<NavigatorState>>{};

  List<TabBarMenuConfig> get tabData => Provider.of<AppModel>(context, listen: false).appConfig!.tabBar;


  bool get isDesktopDisplay => Layout.isDisplayDesktop(context);
  /// -------- 是否展示底部Tab栏 ------------///
  bool isShowCustomDrawer = true;
  bool get shouldHideTabBar => isDesktopDisplay || (isShowCustomDrawer && Layout.isDisplayDesktop(context));




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
    if (isInitialized) {
      tabController.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    _initTabDelegate();
    _initTabData(context);
  }


  @override
  Widget build(BuildContext context) {
    printLog('[TabBar] ============== tabbar.dart ==============');
    var appConfig = Provider.of<AppModel>(context, listen: false).appConfig;

    // empty page
    if (_tabView.isEmpty || appConfig == null) {
      return Container(color: Colors.white);
    }

    final media = MediaQuery.of(context);
    printLog('[ScreenSize]: ${media.size.width} x ${media.size.height}');


    final isTabBarEnabled = appSetting.tabBarConfig.enable;
    final showFloating = appSetting.tabBarConfig.showFloating;
    final isClip = appSetting.tabBarConfig.showFloatingClip;
    final floatingActionButtonLocation = appSetting.tabBarConfig.tabBarFloating.location ?? FloatingActionButtonLocation.centerDocked;


    return SideMenu(
      backgroundColor: showFloating ? null : Theme.of(context).backgroundColor,
      bottomNavigationBar: isTabBarEnabled ? (showFloating ? BottomAppBar(shape: isClip ? const CircularNotchedRectangle() : null,
        child: tabBarMenu(),) : tabBarMenu()) : null,
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
            content: MediaQuery(data: Layout.isDisplayDesktop(context) ? media.copyWith(
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


extension TabBarMenuExtention on MainTabsState {

  /// init Tab Delegate to use for SmartChat & Ads feature
  void _initTabDelegate() {
    var tabDelegate = MainTabControlDelegate.getInstance();
    tabDelegate.changeTab = _onChangeTab;
    tabDelegate.tabKey = () => navigators[tabController.index];
    tabDelegate.currentTabName = _getCurrentTabName;
    tabDelegate.tabAnimateTo = (int index) {
      if (index < tabController.length) {
        tabController.animateTo(index);
      }
    };
    WidgetsBinding.instance.addObserver(this);
  }

  /// on change tabBar name
  void _onChangeTab(String? nameTab, {bool allowPush = true}) {
    if (saveIndexTab[nameTab] != null) {
      tabController.animateTo(saveIndexTab[nameTab]);
      _emitChildTabName();
    } else if (allowPush) {
      //FluxNavigate.pushNamed(nameTab.toString(), forceRootNavigator: true);
    }
  }

  void _emitChildTabName() {
    final tabName = _getCurrentTabName();
    OverlayControlDelegate().emitTab?.call(childTabName[tabName]);
  }

  String _getCurrentTabName() {
    if (saveIndexTab.isEmpty) {
      return '';
    }
    return saveIndexTab.entries
        .firstWhereOrNull((element) => element.value == tabController.index)
        ?.key ?? '';
  }

  /// init the tabView data and tabController
  void _initTabData(context) async {
    var appModel = Provider.of<AppModel>(context, listen: false);
    var tabData = appModel.appConfig!.tabBar;
    var enableOnTop = appModel.appConfig?.settings.tabBarConfig.enableOnTop ??
        false;
    for (var i = 0; i < tabData.length; i++) {
      var dataOfTab = tabData[i];
      saveIndexTab[dataOfTab.layout] = i;
      navigators[i] = GlobalKey<NavigatorState>();
      final initialRoute = dataOfTab.layout;
      if (enableOnTop) {
        _tabView.add(
          MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: EdgeInsets.zero,
              viewPadding: EdgeInsets.zero,
            ),
            child: tabViewItem(
              key: navigators[i],
              initialRoute: initialRoute,
              args: dataOfTab,
            ),
          ),
        );
      } else {
        _tabView.add(
          tabViewItem(
            key: navigators[i],
            initialRoute: initialRoute,
            args: dataOfTab,
          ),
        );
      }
    }
    // ignore: invalid_use_of_protected_member
    setState(() {
      tabController = TabController(length: tabData.length, vsync: this);
    });

    if (MainTabControlDelegate.getInstance().index != null) {
      tabController.animateTo(MainTabControlDelegate.getInstance().index!);
    } else {
      MainTabControlDelegate.getInstance().index = 0;
    }
    isInitialized = true;
  }


  Navigator tabViewItem({key, initialRoute, args}) {
    return Navigator(
      key: key,
      initialRoute: initialRoute,
      observers: [
        MyRouteObserver(
          action: (screenName) {
            childTabName[initialRoute!] = screenName;
            OverlayControlDelegate().emitTab?.call(screenName);
          },
        ),
      ],
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == initialRoute) {
          return Routes.getRouteGenerate(RouteSettings(
            name: initialRoute,
            arguments: args,
          ));
        }
        return Routes.getRouteGenerate(settings);
      },
    );
  }

  /// return the tabBar widget
  Widget tabBarMenu() {
    return TabBarCustom(
      onTap: (value) {},
      tabData: tabData,
      tabController: tabController,
      config: appSetting,
      shouldHideTabBar: shouldHideTabBar,
      totalCart: 5,
    );
  }
}