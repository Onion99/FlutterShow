


import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show/common/theme/colors.dart';
import 'package:flutter_show/common/tools/tools.dart';
import 'package:flutter_show/generated/l10n.dart';
import 'package:flutter_show/notifier/app_model.dart';
import 'package:flutter_show/routes/page_navigate.dart';
import 'package:flutter_show/ui/post/post_screen.dart';
import 'package:flutter_show/widget/common/webview.dart';
import 'package:flutter_show/widget/image/flux_image.dart';
import 'package:provider/provider.dart';
import '../../common/constants.dart';

class SettingScreen extends StatefulWidget {

  @override
  SettingScreenState createState() {
    return SettingScreenState();
  }

  const SettingScreen();
}

class SettingScreenState extends State<SettingScreen>{

  final bannerHigh = 150.0;

  @override
  Widget build(BuildContext context) {
    var background = ProfileBackground;
    var settings = ["about","privacy","darkTheme","language","","","","","","","","","","","",""];

    final appBar = SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: (context.read<AppModel>().appConfig?.drawer?.enable ?? true) ? IconButton(
        icon: renderDrawerIcon(),
        onPressed: () => {},
      ) : null,
      expandedHeight: bannerHigh,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          S.of(context).settings,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        background: FluxImage(
          imageUrl: background,
          fit: BoxFit.cover,
        ),
      ),
      actions: ModalRoute.of(context)?.canPop ?? false ? [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ] : null,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          appBar,
          SliverList(delegate: SliverChildListDelegate(<Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      Random.secure().nextDouble().toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            ),
            /// render list of dynamic menu
            /// this could be manage from the Fluxbuilder
            ...List.generate(
              settings.length,
                  (index) {
                var item = settings[index];
                var isTitle = item.contains('title');
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:  0.0,
                  ),
                  child: renderItem(item),
                );
              },
            ),
          ]))
        ],
      ),
    );
  }

  /// ------------------------------------------------------------------------
  /// 抽屉Icon
  /// ------------------------------------------------------------------------
  Widget renderDrawerIcon() {
    var icon = Icons.blur_on;
    return Icon(icon, color: Colors.white70);
  }

  Widget renderItem(value) {
    IconData icon;
    String title;
    Widget? trailing;
    Function() onTap;

    switch (value) {
      case 'language':{
          return Selector<AppModel, String?>(
            selector: (context, model) => model.langCode,
            builder: (context, langCode, _) {
              return _SettingItem(
                icon: CupertinoIcons.globe,
                title: S.of(context).language,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      langCode!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: kGrey600,
                    )
                  ],
                ),
                onTap: () {
                  // Navigator.of(context).pushNamed(RouteList.language);
                },
              );
            },
          );
       }
      case 'darkTheme':{
          return Selector<AppModel, bool>(
            selector: (context, model) => model.darkTheme,
            builder: (context, darkTheme, _) {
              return _SettingItem(
                icon: darkTheme ? CupertinoIcons.moon : CupertinoIcons.sun_min,
                title: S.of(context).appearance,
                trailing: Text(
                  darkTheme
                      ? S.of(context).darkTheme
                      : S.of(context).lightTheme,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onTap: () {
                  context.read<AppModel>().updateTheme(!darkTheme);
                },
              );
            },
          );
      }
      case 'privacy':{
          icon = CupertinoIcons.doc_text;
          title = S.of(context).agreeWithPrivacy;
          onTap = () {
            final pageId = 25569;
            String? pageUrl = "https://inspireui.com/privacy-policy/";
            if (pageId != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostScreen(
                      pageId: pageId,
                      pageTitle: S.of(context).agreeWithPrivacy,
                    ),
                  ));
              return;
            }
            if (pageUrl.isNotEmpty) {
              ///Display multiple languages WebView
              var locale = Provider.of<AppModel>(context, listen: false).langCode;
              pageUrl += '?lang=$locale';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebView(
                    url: pageUrl,
                    title: S.of(context).agreeWithPrivacy,
                  ),
                ),
              );
            }
          };
          break;
      }
      case 'about':{
          icon = CupertinoIcons.info;
          title = S.of(context).aboutUs;
          onTap = () {
            final aboutUrl = SettingConstants.aboutUsUrl;

            if (kIsWeb) return Tools.launchURL(aboutUrl);
            return PageNavigate.push(
              MaterialPageRoute(
                builder: (context) => WebView(
                  url: aboutUrl,
                  title: title,
                ),
              ),
            );
          };
          break;
      }
      default:{
          trailing = const Icon(Icons.arrow_forward_ios, size: 18, color: kGrey600);
          icon = Icons.error;
          title = S.of(context).dataEmpty;
          onTap = () {};
      }
    }

    return _SettingItem(
      icon: icon,
      title: title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}


class _SettingItem extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final String? title;
  final Widget? titleWidget;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingItem({
    Key? key,
    this.icon,
    this.iconWidget,
    this.title,
    this.titleWidget,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 2.0),
          elevation: 0,
          child: ListTile(
            leading: icon != null
                ? Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
              size: 24,
            )
                : iconWidget,
            title: title != null
                ? Text(
              title!,
              style: const TextStyle(fontSize: 16),
            )
                : titleWidget,
            trailing: trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: kGrey600,
                ),
            onTap: onTap,
          ),
        ),
        const Divider(
          color: Colors.black12,
          height: 1.0,
          indent: 75,
          //endIndent: 20,
        ),
      ],
    );
  }
}