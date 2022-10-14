import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show/common/config/defalut_env.dart';
import 'package:flutter_show/common/models/general_setting_item.dart';
import 'package:flutter_show/generated/l10n.dart';
import 'package:flutter_show/modules/dynamic_layout/config/app_config.dart';
import 'package:flutter_show/util/colors.dart';
import 'package:flutter_show/util/helper.dart';
import 'package:flutter_show/util/logs.dart';
import 'package:flutter_show/widget/common/webview.dart';
import 'package:flutter_show/widget/image/flux_image.dart';



class SideBarMenu extends StatefulWidget {
  const SideBarMenu();

  @override
  MenuBarState createState() => MenuBarState();
}

class MenuBarState extends State<SideBarMenu> {
  bool get isEcommercePlatform => false;

  DrawerMenuConfig get drawer => DrawerMenuConfig.fromJson(DefaultConfig.defaultDrawer);

  void pushNavigation() {}

  @override
  Widget build(BuildContext context) {
    printLog('[AppState] Load Menu');

    return SafeArea(
      top: drawer.safeArea,
      right: false,
      bottom: false,
      left: false,
      child: Padding(
        key: drawer.key != null ? Key(drawer.key as String) : UniqueKey(),
        padding: EdgeInsets.only(bottom: false ? 46 : 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (drawer.logo != null) ...[
                Container(
                  color: drawer.logoConfig.backgroundColor != null ? HexColor(drawer.logoConfig.backgroundColor) : null,
                  padding: EdgeInsets.only(
                    bottom: drawer.logoConfig.marginBottom.toDouble(),
                    top: drawer.logoConfig.marginTop.toDouble(),
                    left: drawer.logoConfig.marginLeft.toDouble(),
                    right: drawer.logoConfig.marginRight.toDouble(),
                  ),
                  child: FluxImage(
                    width: drawer.logoConfig.useMaxWidth
                        ? MediaQuery.of(context).size.width
                        : drawer.logoConfig.width?.toDouble(),
                    fit: Helper.boxFit(drawer.logoConfig.boxFit),
                    height: drawer.logoConfig.height.toDouble(),
                    imageUrl: drawer.logo as String,
                  ),
                ),
                const Divider(),
              ],
              ...List.generate(
                drawer.items?.length ?? 0,
                (index) {
                  return drawerItem(
                    drawer.items![index],
                    drawer.subDrawerItem ?? {},
                    textColor: drawer.textColor != null
                        ? HexColor(drawer.textColor)
                        : null,
                    iconColor: drawer.iconColor != null
                        ? HexColor(drawer.iconColor)
                        : null,
                  );
                },
              ),
              Layout.isDisplayDesktop(context)
                  ? const SizedBox(height: 300)
                  : const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerItem(DrawerItemsConfig drawerItemConfig, Map<String, GeneralSettingItem> subDrawerItem, {Color? iconColor, Color? textColor,}) {
    // final isTablet = Tools.isTablet(MediaQuery.of(context));

    if (drawerItemConfig.show == false) return const SizedBox();
    var value = drawerItemConfig.type;
    var textStyle = TextStyle(
      color: textColor ?? Theme.of(context).textTheme.bodyText1?.color,
    );

    switch (value) {
      case 'home':
        {
          return ListTile(
            leading: Icon(
              isEcommercePlatform ? Icons.home : Icons.shopping_basket,
              size: 20,
              color: iconColor,
            ),
            title: Text(
              isEcommercePlatform ? S.of(context).home : S.of(context).shop,
              style: textStyle,
            ),
            onTap: () {
              pushNavigation();
            },
          );
        }
      case 'categories':
        {
          return ListTile(
            leading: Icon(
              Icons.category,
              size: 20,
              color: iconColor,
            ),
            title: Text(
              S.of(context).categories,
              style: textStyle,
            ),
            onTap: () => pushNavigation(),
          );
        }
      case 'cart':
        {
          if (true) {
            return const SizedBox();
          }
          return ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: 20,
              color: iconColor,
            ),
            title: Text(
              S.of(context).cart,
              style: textStyle,
            ),
            onTap: () => pushNavigation(),
          );
        }
      case 'profile':
        {
          return ListTile(
            leading: Icon(
              Icons.person,
              size: 20,
              color: iconColor,
            ),
            title: Text(
              S.of(context).settings,
              style: textStyle,
            ),
            onTap: () => pushNavigation(),
          );
        }
      case 'web':
        {
          return ListTile(
            leading: Icon(
              Icons.web,
              size: 20,
              color: iconColor,
            ),
            title: Text(
              S.of(context).webView,
              style: textStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebView(
                    url: 'https://inspireui.com',
                    title: S.of(context).webView,
                  ),
                ),
              );
            },
          );
        }
      case 'blog':
        {
          return ListTile(
            leading: Icon(
              CupertinoIcons.news_solid,
              size: 20,
              color: iconColor,
            ),
            title: Text(
              S.of(context).blog,
              style: textStyle,
            ),
            onTap: () => pushNavigation(),
          );
        }
      default:
        return const SizedBox();
    }
  }


  void navigateToBackDrop() {
  }
}
