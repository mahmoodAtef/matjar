import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio = Dio() ;

  static init() {
    dio = Dio
      (
        BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json','lang':'en'},
    ));
  }

  static Future<Response> getData(
      {@required String? url, Map<String , dynamic>? query}) async {
   return  await dio.get(url!, queryParameters: query = query).catchError((error){print (error.toString());}) ;
  }

  static Future <Response> postData(
      {@required String? url, dynamic query, required dynamic data}) async
  {
    return await dio.post(url!, queryParameters: query, data: data);
  }
}