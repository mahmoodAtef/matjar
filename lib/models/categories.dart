import 'package:flutter/cupertino.dart';

class CategoriesModel {
  late bool status ;
  late String ? message ;
late CategoriesDataModel categoriesDataModel = CategoriesDataModel() ;
CategoriesModel ();
CategoriesModel.fromJson(json){
  status = json['status'];
  message = json['message'];
  categoriesDataModel= CategoriesDataModel.fromJson(json['data']);
}
}

class CategoriesDataModel{
  late int current_page;
   late List  categoriesData =[];
CategoriesDataModel();
   CategoriesDataModel.fromJson (json)
   {
current_page = json['current_page'];
categoriesData = json['data'];
   }
}

class DataModel {
  late int id ;
  late String name ;
  late String image ;
DataModel.fromJson (json){
  id = json['id'];
  name = json['name'];
  image = json['image'];
}
}