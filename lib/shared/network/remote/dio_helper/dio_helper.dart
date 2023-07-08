
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioHelper{

  static late Dio? dio;

  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl:'https://hospital-ydoz.onrender.com/',

          receiveDataWhenStatusError: true,
        ),
    );
    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  static Future<Response> getData ({
    required String url,
    Map<String,dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
        'Content-Type':'application/json',
        'Authorization': 'Bearer $token',
      };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String? token,
})async{
    dio!.options.headers = {
        'Content-Type':'application/json',
        'Authorization': 'Bearer $token',
      };
    return dio!.post(
      url,

      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> putData({
  required String url,
    Map<String,dynamic>?query,
    String? token,
    required Map<String,dynamic>data,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token',
    };
    return dio!.put(url,queryParameters: query,data:data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String,dynamic>?query,
    String? token,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token',
    };
    return dio!.delete(url);
  }
}
//news api https://newsapi.org/
//6d9c95acc4024fc89edf5b1ab84d8f68



class DioHelper2{

  static late Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(

        receiveDataWhenStatusError: true,
      ),
    );
    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String? token,
  })async{
    dio!.options.headers = {
      'Content-Type':'application/json',
      'Authorization': 'Bearer $token',
    };
    return dio!.post(
      url,

      queryParameters: query,
      data: data,
    );
  }


}
//news api https://newsapi.org/
//6d9c95acc4024fc89edf5b1ab84d8f68