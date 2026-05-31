//(بيصنع ويظبط إعدادات الـ Dio والـ Timeouts مرة واحدة). singleton pattern
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';

class DioClient {
  // 1. كونستركتور بريفات  private named constructor called (_internal)
  DioClient._internal();

  static Dio? _dio;

  // 2. دالة بترجع نسخة الـ Dio، لو مش موجودة بتصنعها، لو موجودة بترجع نفس النسخة
  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 20);

    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..options.baseUrl = ApiConstants.baseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };

      // بنضيف الـ Logger علشان نشوف الـ APIs في الـ Terminal وإحنا بنعمل debug
      addDioInterceptor();
      return _dio!;
    } else {
      return _dio!;
    }
  }

  //(interceptor)
  static void addDioInterceptor() {
    //1st interceptor fot token
    _dio!.interceptors.add(
      InterceptorsWrapper(
        // for checking the request before it goes to the server, we can add the token here.
        onRequest: (options, handler) async {
          // final token = await PrefHelper.getToken();
          // if (token != null && token.isNotEmpty && token != 'guest') {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }

          return handler.next(options); // سيب الـ request يكمل طريقه للسيرفر
        },
        onResponse: (response, handler) {
          return handler.next(response); // سيب الـ response يرجع للشاشة عادي
        },
        onError: (DioException e, handler) {
          return handler.next(e); // مرر الإيرور لملف الـ Exceptions اللي عملناه
        },
      ),
    );

    //2nd interceptor:
    //kDebugMode is a variable in flutter, print logs in terminals if it is in debug mode only, and disappear in production mode.
    if (kDebugMode) {
      _dio!.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
        ),
      );
    }
  }
}
