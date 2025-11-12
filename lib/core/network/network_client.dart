import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:workiom_task/core/config/app_api.dart';
import 'package:workiom_task/core/storage/token_storage.dart';

//? Network client using Dio for API calls
class NetworkClient {
  late final Dio _dio;
  final TokenStorage _tokenStorage;

  NetworkClient(this._tokenStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppApi.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    //* Add pretty logger for debugging
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    //* Add auth token interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  //* GET request
  Future<Either<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  //* POST request
  Future<Either<String, dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  //* PUT request
  Future<Either<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  //* DELETE request
  Future<Either<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  //* Handle Dio errors
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  //* Handle response errors
  String _handleResponseError(Response? response) {
    if (response == null) return 'Unknown error occurred.';

    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        //* Try to extract error message from response
        if (data.containsKey('error')) {
          final error = data['error'];
          if (error is Map<String, dynamic> && error.containsKey('message')) {
            return error['message'].toString();
          }
          return error.toString();
        }
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
      }
    } catch (e) {
      //! If parsing fails, return generic error
    }

    //* Return status code based error
    switch (response.statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access forbidden.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Error ${response.statusCode}: ${response.statusMessage ?? "Unknown error"}';
    }
  }
}

