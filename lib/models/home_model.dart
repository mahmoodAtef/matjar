import 'package:almatjar/main.dart';

class HomeModel {
  late bool status;
  String? message;
  late HomeDataModel data = HomeDataModel();
  HomeModel();
  HomeModel.FromJson(Map<String?, dynamic> json) {
    status = json['status'];
    message = json['message'];

    data = HomeDataModel.FromJson(json['data']);
  }
}

class HomeDataModel {
  late List<dynamic> banners =[];
  late List<dynamic> products =[];
  HomeDataModel();
  HomeDataModel.FromJson(Map<String, dynamic> json) {
   banners  = json['banners'];
   products = json['products'];
  }
}

class BannerModel {
  late int id;
  late String  image;
  Object? category;
  ProductModel? product;
  BannerModel.FromJson(Map<String , dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductModel {
  late int id;
  late double price;
  late double oldPrice;
  late int discount;
  late String  image;
  late String name;
  late String  description;
  late List<String> images;
  late bool in_favourite;
  late bool in_cart;
  ProductModel.Fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    in_favourite = json['in_favourite'];
    in_cart = json['in_cart'];
  }
}


