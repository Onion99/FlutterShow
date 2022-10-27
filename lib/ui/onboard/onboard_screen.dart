import 'package:flutter/material.dart';
import 'package:flutter_show/common/config/defalut_env.dart';
import 'package:flutter_show/common/constants.dart';
import 'package:flutter_show/widget/image/flux_image.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../notifier/app_model.dart';
import '../mixin/change_language_mixin.dart';

/// ------------------------------------------------------------------------
/// 开屏启动页
/// ------------------------------------------------------------------------

class OnBoardScreen extends StatefulWidget {

  const OnBoardScreen();

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();

}

class _OnBoardScreenState extends State<OnBoardScreen> with ChangeLanguage {

  void _onTapSignIn() async {
  }

  List<Slide> getSlides(List<dynamic> data) {
    final slides = <Slide>[];

    Widget renderLoginWidget(String imagePath) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FluxImage(imageUrl: imagePath, fit: BoxFit.fitWidth,),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _onTapSignIn,
                  child: Text(
                    S.of(context).signIn,
                    style: const TextStyle(
                      color: Color(0xFF26A69A),
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Text(
                  '    |    ',
                  style: TextStyle(color: Color(0xFF26A69A), fontSize: 20.0),
                ),
                GestureDetector(
                  onTap: () async {

                  },
                  child: Text(
                    S.of(context).signUp,
                    style: const TextStyle(
                      color: Color(0xFF26A69A),
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    for (var i = 0; i < data.length; i++) {
      var slide = Slide(
        title: data[i]['title'],
        description: data[i]['desc'],
        marginTitle: const EdgeInsets.only(
          top: 125.0,
          bottom: 50.0,
        ),
        maxLineTextDescription: 2,
        styleTitle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Color(0xFF263238),
        ),
        backgroundColor: Colors.white,
        marginDescription: const EdgeInsets.fromLTRB(20.0, 75.0, 20.0, 0),
        styleDescription: const TextStyle(
          fontSize: 15.0,
          color: Color(0xFF546E7A),
        ),
        foregroundImageFit: BoxFit.fitWidth,
      );

      final isLastItem = i == data.length - 1;
      if (isLastItem) {
        slide.centerWidget = renderLoginWidget(data[i]['image']);
      } else {
        slide.centerWidget = FluxImage(
          imageUrl: data[i]['image'],
          fit: BoxFit.fitWidth,
        );
      }
      slides.add(slide);
    }
    return slides;
  }


  void onTapDone() async {
    await Navigator.pushReplacementNamed(context, RouteList.dashboard);
  }


  @override
  Widget build(BuildContext context) {
    final data = DefaultConfig.onBoardingData;
    final isRequiredLogin = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Consumer<AppModel>(builder: (context, _, __) {
            return Container(
              key: UniqueKey(),
              child: IntroSlider(
                slides: getSlides(data),
                renderSkipBtn: Text(
                  S.of(context).skip,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                renderDoneBtn: Text(
                  isRequiredLogin ? '' : S.of(context).done,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                renderPrevBtn: Text(
                  S.of(context).prev,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                renderNextBtn: Text(
                  S.of(context).next,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                showDoneBtn: !isRequiredLogin,
                onDonePress: onTapDone,
              ),
            );
          }),
          iconLanguage()
        ],
      ),
    );
  }
}



