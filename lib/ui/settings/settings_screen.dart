


import 'package:flutter/material.dart';
import 'package:flutter_show/generated/l10n.dart';

class SettingScreen extends StatefulWidget {



  @override
  SettingScreenState createState() {
    return SettingScreenState();
  }

  const SettingScreen();
}

class SettingScreenState extends State<SettingScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate(<Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      S.of(context).generalSetting,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            )
          ]))
        ],
      ),
    );
  }

}