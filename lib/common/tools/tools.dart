
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools{
  static Future<void> launchURL(String? url, {LaunchMode mode = LaunchMode.platformDefault,}) async {
    final uri = Uri.parse(url ?? '');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }


  static FontWeight getFontWeight(
      dynamic fontWeight, {
        FontWeight? defaultValue,
      }) {
    var fontWeightVal = '$fontWeight';
    switch (fontWeightVal) {
      case '100':
        return FontWeight.w100;
      case '200':
        return FontWeight.w200;
      case '300':
        return FontWeight.w300;
      case '400':
        return FontWeight.w400;
      case '500':
        return FontWeight.w500;
      case '600':
        return FontWeight.w600;
      case '700':
        return FontWeight.w700;
      case '800':
        return FontWeight.w800;
      case '900':
        return FontWeight.w900;
      default:
        return defaultValue ?? FontWeight.w400;
    }
  }

  static AlignmentGeometry getAlignment(String? alignment, {AlignmentGeometry? defaultValue,}) {
    switch (alignment) {
      case 'left':
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'right':
      case 'centerRight':
        return Alignment.centerRight;
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomRight':
        return Alignment.bottomRight;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'topCenter':
        return Alignment.topCenter;
      case 'center':
      default:
        return defaultValue ?? Alignment.center;
    }
  }
}