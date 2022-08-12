
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class FluxImage extends StatelessWidget{


  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final String package;


  const FluxImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.fit,
    this.color = null,
    this.package = ""
  });

  @override
  Widget build(BuildContext context) {
    var imageProxy = '';
    var isSvgImage = imageUrl.split('.').last == 'svg';


    if (imageUrl.isEmpty) return const SizedBox();


    if (!imageUrl.contains('http')) {
      if (isSvgImage)
        return SvgPicture.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          package: package,
        );

      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        package: package,
      );
    }


    return ExtendedImage.network(
      '$imageProxy$imageUrl',
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.loading:
          case LoadState.failed:
          default:
            return const SizedBox();
        }
      },
    );
  }
}