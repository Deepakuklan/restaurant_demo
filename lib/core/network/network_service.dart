import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'api_client.dart';
import 'error_handler.dart';

class NetworkService {
  final ApiClient _apiClient = ApiClient();

  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _apiClient.dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final data = fromJson != null ? fromJson(response.data) : response.data as T;
        return Right(data);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _apiClient.dio.post(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = fromJson != null ? fromJson(response.data) : response.data as T;
        return Right(result);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure('Bad response: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return NetworkFailure('Request cancelled');
      default:
        return NetworkFailure('Network error: ${e.message}');
    }
  }
}
