import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:almatjar/cubit/states.dart';
import 'package:almatjar/models/categories.dart';
import 'package:almatjar/models/favourites_model.dart';
import 'package:almatjar/models/home_model.dart';
import 'package:almatjar/network/local/shared_prefrences.dart';
import 'package:almatjar/network/remote/dio.dart';
import 'package:almatjar/screens/home_screen.dart';
import '../pages/account_page.dart';
import '../pages/cart_page.dart';
import '../pages/categories_page.dart';
import '../pages/favourites_page.dart';
import '../pages/home_page.dart';
import '../models/login_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopLoginInistialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int current = 2;
  List<Widget> bottomItems =
  [
    Icon(
        Icons.account_circle, size: 25),
    Icon(
        Icons.category, size: 25),
    Icon(
        Icons.home, size: 25),
    Icon(
      Icons.favorite,
      size: 25,
    ),
    Icon(
      Icons.shopping_cart,
      size: 25,
    ),
  ];
  List<Widget> Pages = [
    AccountPage(),
    CategoriesPage(),
    HomePage(),
    FavoritesPage(),
    CartPage()
  ];
  void Change(int index) {
    current = index;
    emit(ShopBottomNavState());
  }

  late LoginModel loginModel;
  void userLogin({@required String? email, @required String? password, required context}) async {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: 'https://student.valuxapps.com/api/login', data: {
      'email': email,
      'password': password,
    }).then((value) async {
      // print (value.data['message']);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.message.toString());
      if (loginModel.status) {
        CacheHelper.saveData(key: "login", value: true).then((value) => {});
        CacheHelper.saveData(key: 'token', value: loginModel.data.token).then((value) => {});
        emit(ShopLoginSuccessfulState());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>MainScreen()));
        Fluttertoast.showToast(
            msg: "${loginModel.message.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "${loginModel.message.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(ShopLoginfailedState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
      Fluttertoast.showToast(
          msg: "${error.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void changeVisiblity(bool visible) {
    emit(ShopLoginPasswordState());
    visible = !visible;
  }

  Map<int, bool> favorites = {};
  late HomeModel homeModel = HomeModel();
  Future<HomeModel> getHomeData() async {
    emit(ShopHomeLoadingState());
    await DioHelper.getData(
      url: 'home',
    ).then((value) {
      homeModel = HomeModel.FromJson(value.data);
      emit(ShopHomeSuccessfulState());
    }).catchError((error) {
      emit(ShopHomefailedState());
      print(error.toString());
    });
    homeModel.data.products.forEach((element) {
      favorites.addAll({element['id']: element['in_favorites']});
    });
    return homeModel;
  }

  late CategoriesModel categoriesModel = CategoriesModel();
  Future<CategoriesModel> getCategoriesData() async {
    emit(ShopCategoriesLoadingState());
    await DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessfulState());
    }).catchError((error) {
      emit(ShopCategoriesfailedState());
      print(error.toString());
    });
    return categoriesModel;
  }

  late LoginModel userModel = LoginModel();
  Future<LoginModel> getUserDate() async {
    String ? token = await CacheHelper.getData(key: 'token');
    DioHelper.dio.options.headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'lang': 'en'
    };
    emit(ShopGetUserLoadingState());
    DioHelper.getData(
      url: 'profile',
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopGetUSerSuccessfulState());
      print("user name :" + '${userModel.data.name}');
    }).catchError((error) {
      emit(ShopGetUserFailedState());
      print('error' + error.toString());
    });
    return userModel;
  }

  Future<bool> changeFav({required int productId}) async {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavouritesState());
    String token = await CacheHelper.getData(key: 'token');
    DioHelper.dio.options.headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    DioHelper.postData(
      url: 'favorites',
      data: {'product_id': productId},
    ).then((value) {
      emit(ChangeFavouritesState());
      print(productId);
      print(value.data.toString());
      if (value.data['status'] == false) {
        favorites[productId] = !favorites[productId]!;
        emit(ChangeFavouritesState());
      }
      else {
        getFavData();
      }
    }).catchError((error) {
      emit(
        ChangeFavouritesStateError(),
      );
    });

    return true;
  }

   FavoritesModel favoritesModel = FavoritesModel();
  Future<FavoritesModel> getFavData() async {
    emit(ShopFavoritesLoadingState());
    String ? token = await CacheHelper.getData(key: 'token');
    DioHelper.dio.options.headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    await DioHelper.getData(
      url: 'favorites',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      favoritesModel.message ;
      emit(ShopFavoritesSuccessfulState());
    }).catchError((error) {
      emit(ShopFavoritesFailedState());
      print(error.toString());
    });

    return favoritesModel;
  }
}
