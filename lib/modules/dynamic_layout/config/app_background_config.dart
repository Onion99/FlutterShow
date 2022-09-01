import '../../../util/helper.dart';

/// color : '#eee'
/// image : 'https://google.com'
/// height : 0.18
/// layout : 'background'

class BackgroundConfig {
  String? color;
  String? image;
  late double height;
  String? layout;

  BackgroundConfig({this.color, this.image, this.height = 1, this.layout});

  BackgroundConfig.fromJson(dynamic json) {
    color = json['color'];
    image = json['image'];
    height = Helper.formatDouble(json['height']) ?? 0.0;
    layout = json['layout'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['color'] = color;
    map['image'] = image;
    map['height'] = height;
    map['layout'] = layout;
    return map;
  }
}
