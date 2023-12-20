import 'package:image_picker/image_picker.dart';

class ProductsModel {
  String? title;
  double? price;
  String? photo;
  int? id;
  XFile? file;

  ProductsModel({this.title, this.price, this.photo, this.id});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    photo = json['photo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['id'] = this.id;
    return data;
  }
}
