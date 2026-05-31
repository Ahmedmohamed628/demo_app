// todo: general class for handling API errors in a consistent way across the app

import 'package:dio/dio.dart';

class ApiError implements Exception {
  final String message;

  ApiError({required this.message});
  // class that holds the error message to be displayed in the UI
}

abstract class ApiErrorHandler {
  const ApiErrorHandler._();

  static ApiError handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiError(
            message:
                'Connection timeout, please check your internet connection',
          );
        case DioExceptionType.receiveTimeout:
          return ApiError(
            message: 'Server took too long to respond, please try again later',
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return ApiError(message: 'Request to the server was cancelled');
        case DioExceptionType.connectionError:
          return ApiError(
            message: 'No internet connection, please check your network',
          );
        default:
          return ApiError(
            message: 'Something went wrong, please try again later',
          );
      }
    } else {
      // exception handling for non-Dio errors (like parsing issues, null errors, etc.)
      return ApiError(message: 'An internal system error occurred');
    }
  }

  static ApiError _handleBadResponse(Response? response) {
    if (response == null) {
      return ApiError(message: 'No response received from the server');
    }

    final statusCode = response.statusCode;
    final data = response.data;
    String? serverMessage;

    if (data is Map<String, dynamic>) {
      serverMessage =
          data['message']?.toString() ??
          data['error']?.toString() ??
          (data['errors'] is Map
              ? data['errors'].values.first.toString()
              : null);
    }

    switch (statusCode) {
      case 400:
        return ApiError(message: serverMessage ?? "Bad request");
      case 401:
        return ApiError(message: "Unauthorized access, please login again");
      case 403:
        return ApiError(
          message: "Forbidden, you don't have permission to access this data",
        );
      case 404:
        return ApiError(message: "Requested data not found");
      case 500:
        return ApiError(
          message: "Internal server error, please contact support",
        );
      default:
        return ApiError(message: serverMessage ?? "Server error: $statusCode");
    }
  }
}
