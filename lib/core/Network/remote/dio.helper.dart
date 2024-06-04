import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://flutter.prominaagency.com/api/',
        // baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,

      ),
    );
  }
  static Future <Response> getData({
    required String url,
     Map<String,dynamic>? query,
    String lang='en',
    String? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return await dio.get(
      url,
      queryParameters:query ,
    );
  }



static Future <Response> postData({
  required String url,
   Map<String,dynamic>? query,
  required Map<String,dynamic> data,
  String lang='en',
  String? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return  dio.post(

      url,
    queryParameters: query,
      data: data,
    );
  }

  static Future<Response> postDataa({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'multipart/form-data', // Adjust content type for file uploads
      'lang': lang,
      'Authorization': token,
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }



  static Future <Response> putData({
  required String url,
   Map<String,dynamic>? query,
  required Map<String,dynamic> data,
  String lang='en',
  String? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return  dio.put(
      url,
    queryParameters: query,
      data: data,
    );
  }

}