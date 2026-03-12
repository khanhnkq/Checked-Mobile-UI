import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(

      baseUrl: 'http://192.168.1.60:8080',
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
          print('--- DIO ERROR ---');
          print('URL: ${e.requestOptions.uri}');
          print('Type: ${e.type}'); // In thêm loại lỗi (timeout, connection...)
          print('Status: ${e.response?.statusCode}');
          print('Response Data: ${e.response?.data}');
          print('Error Message: ${e.message}');
          print('-----------------');
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
