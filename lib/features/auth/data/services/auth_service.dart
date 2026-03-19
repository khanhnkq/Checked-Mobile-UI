import 'package:dio/dio.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../models/login_models.dart';
import '../models/register_models.dart';
import '../models/otp_models.dart';

class AuthService {
  final Dio _dio = DioClient().dio;
  final SecureStorageService _storageService = SecureStorageService();

  Future<AuthResponse?> login(String identifier, String password) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/login',
        data: LoginRequest(identifier: identifier, password: password).toJson(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data);
        await _storageService.saveToken(authResponse.token);
        await _storageService.saveEmail(authResponse.email);
        return authResponse;
      }
    } on DioException catch (e) {
      appLogger.e('LOGIN ERROR', error: e.response?.data ?? e);
      if (e.response?.statusCode == 403) {
        throw Exception('USER_NOT_VERIFIED');
      }
      final errorMsg = e.response?.data['message'] ?? 'Đăng nhập thất bại';
      throw Exception(errorMsg);
    }
    return null;
  }

  Future<RegisterResponse?> register(String email, String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/register',
        data: RegisterRequest(
          email: email,
          username: username,
          password: password,
        ).toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final registerResponse = RegisterResponse.fromJson(response.data);
        await _storageService.saveEmail(registerResponse.email);
        return registerResponse;
      }
    } on DioException catch (e) {
      appLogger.e('REGISTER ERROR', error: e.response?.data ?? e);
      final errorMsg = e.response?.data['message'] ?? 'Đăng ký thất bại';
      throw Exception(errorMsg);
    }
    return null;
  }

  Future<AuthResponse?> verifyOtp(String email, String otp) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/verify',
        data: VerifyOtpRequest(email: email, otp: otp).toJson(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data);
        await _storageService.saveToken(authResponse.token);
        return authResponse;
      }
    } on DioException catch (e) {
      appLogger.e('VERIFY OTP ERROR', error: e.response?.data ?? e);
      final errorMsg = e.response?.data['message'] ?? 'Xác thực OTP thất bại';
      throw Exception(errorMsg);
    }
    return null;
  }
}
