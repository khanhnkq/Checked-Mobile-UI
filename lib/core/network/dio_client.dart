import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import '../logging/app_logger.dart';
import '../storage/secure_storage_service.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;
  final SecureStorageService _storageService = SecureStorageService();
  
  // Callback để AuthProvider lắng nghe lỗi 401
  VoidCallback? onUnauthorized;

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _resolveBaseUrl(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final publicEndpoints = [
            '/api/v1/auth/login',
            '/api/v1/auth/register',
            '/api/v1/auth/verify',
          ];

          bool isPublic = publicEndpoints.any((path) => options.path.contains(path));

          if (!isPublic) {
            final token = await _storageService.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            appLogger.w('401 Unauthorized -> trigger logout callback');
            onUnauthorized?.call();
          }
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
