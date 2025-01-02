import 'package:dio/dio.dart';
import '../storge/storage_service.dart';


class DioClient {
  final Dio _dio = Dio();
  final StorageService _storageService;

  static const String baseUrl = 'http://192.168.1.221:8000/api';

  DioClient(this._storageService) {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_errorInterceptor());
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storageService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    );
  }

  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token is expired or invalid
          await _storageService.deleteToken();
          //Get.offAllNamed('/login');
          return handler.next(error);
        }
        return handler.next(error);
      },
    );
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
     } on DioException catch (e) {
       throw _handleError(e);
     }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
         return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          return Exception('Session expired. Please login again.');
        }
         return Exception(error.response?.data['message'] ?? 'Server error');
      default:
         return Exception('Something went wrong');
    }
  }
}