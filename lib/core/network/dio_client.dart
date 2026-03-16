import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../storage/secure_storage_service.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _resolveBaseUrl(),
      // Tăng thời gian chờ lên 30s vì bước gửi mail OTP có thể chậm
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*', // Chấp nhận mọi loại phản hồi (cả text và json)
      },
    ),
  );

  final SecureStorageService _storageService = SecureStorageService();

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final publicEndpoints = [
            '/api/v1/auth/login',
            '/api/v1/auth/register',
            '/api/v1/auth/verify',
          ];

          bool isPublic = publicEndpoints.any((path) => options.path.contains(path));

          if (isPublic) {
            options.headers.remove('Authorization');
          } else {
            final token = await _storageService.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          debugPrint('--- DIO ERROR ---');
          debugPrint('URL: ${e.requestOptions.uri}');
          debugPrint('Type: ${e.type}'); // In thêm loại lỗi (timeout, connection...)
          debugPrint('Status: ${e.response?.statusCode}');
          debugPrint('Response Data: ${e.response?.data}');
          debugPrint('Error Message: ${e.message}');
          debugPrint('-----------------');
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  static String _resolveBaseUrl() {
    try {
      return dotenv.maybeGet('API_BASE_URL') ?? 'http://192.168.1.33:8080';
    } catch (_) {
      return 'http://192.168.1.33:8080';
    }
  }
}
