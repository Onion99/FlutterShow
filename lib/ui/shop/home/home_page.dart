import 'package:flutter/material.dart';

import '../../../common/config/ui_config.dart';
import '../../../common/global/app_theme.dart';

class Homepage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<Homepage>{

  int currentPage = 1;
  late ThemeData themeData;
  late CustomTheme customTheme;


  final List<String> _pageTitle = [
    "Material UI",
    "Cupertino UI",
    "Material 用例",
    "Custom 用例",
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    themeData = Theme.of(context);
    customTheme = AppTheme.getCustomThemeFromMode();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text( "FlutterShow",textAlign: TextAlign.center,style: AppTheme.getTextStyle(themeData.textTheme.headline6,fontWeight: 600),)
      ),
      body: Text("content"),
      drawer: Drawer(
        child: Container(
          color: customTheme.bgLayer1,
          child: Column(
            // 填满宽度
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // 最小使用
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // App 版本Show
              SafeArea(
                  child:Container(
                    padding: Spacing.only(left: 16, bottom: 24, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage("./assets/images/icon.jpg"),
                          height: 102,
                          width: 102,
                        ),
                        Space.height(16),
                        Container(
                          padding: Spacing.fromLTRB(12, 4, 12, 4),
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.primary.withAlpha(40),
                              borderRadius: Shape.circular(16)),
                          child: Text("v. 1.0.0",
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.caption,
                                  color: themeData.colorScheme.primary,
                                  fontWeight: 600,
                                  letterSpacing: 0.2)),
                        ),
                      ],
                    ),
                  )
              ),
              Divider(),
              Container(
                color: customTheme.bgLayer1,
                child: ListTile(
                  onTap: () {
                    showDialog(context: context, builder: (BuildContext context) => const AlertDialog(title: Text('Building!')));
                  },
                  title: Text(
                    "主题样式",
                    style: AppTheme.getTextStyle(themeData.textTheme.subtitle2, fontWeight: 600),
                  ),
                  // 右对齐图片
                  trailing: Icon(Icons.chevron_right, color: themeData.colorScheme.onBackground),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

}