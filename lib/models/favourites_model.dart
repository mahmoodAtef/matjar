class FavoritesModel {
 late bool  status;
 late Null message;
 late Data  data = Data();

  FavoritesModel();

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ?  Data.fromJson(json['data']) : null)!;
  }

}

class Data {
  late int currentPage;
  late List<FavData> data = [];
  late  String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late Null nextPageUrl;
  late String path;
  late int perPage;
  late  Null prevPageUrl;
  late  int to;
  late  int total;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data.add( FavData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class FavData {
  late int id;
  late  Product product = Product();

  FavData({required this.id, required this.product});

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
  }

}

class Product {
  late int  id;
  late  int price;
  late int  oldPrice;
  late int  discount;
  late String  image;
  late String  name;
  late String  description;

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }}
