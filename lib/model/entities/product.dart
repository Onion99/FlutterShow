import '../../util/logs.dart';

class Product{
  String price = "";
  String imageFeature = "";
  String name  = "";
  String id    = "";


  Product({
    String id = "",
    String imageFeature = "",
    String name = "",
    String price = "",
  });


  Product.empty(this.id) {
    name = '';
    price = '0.0';
    imageFeature = '';
  }

  Map<String,dynamic> toJson(){
    return {
      'id'             :this.id,
      'price'          :this.price,
      'name'           :this.name,
      'imageFeature'   :this.imageFeature
    };
  }

  Product.fromLocalJson(Map<String, dynamic> json) {
    try{
      id           = json['id'].toString();
      name         = json['name'];
      price        = json['price'];
      imageFeature = json['imageFeature'];
    }catch (e, trace) {
      printLog(e.toString());
      printLog(trace.toString());
    }
  }
}