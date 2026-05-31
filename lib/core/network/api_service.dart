//todo: general api service to prevent try and catch repetition in all features
import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'error_handler.dart';

class ApiService {
  final Dio _dio = DioClient.getDio();

  // GET METHOD
  //  تظبيط الـ type ليكون صريح بدل dynamic في ال query parameter
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // POST METHOD
  Future<dynamic> post({required String endPoint, dynamic body}) async {
    try {
      final response = await _dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // PUT METHOD
  Future<dynamic> put({required String endPoint, dynamic body}) async {
    try {
      final response = await _dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // DELETE METHOD
  Future<dynamic> delete({
    required String endPoint,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
