import 'package:dio/dio.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../models/profile_models.dart';

class ProfileService {
  final Dio _dio = DioClient().dio;

  Future<UserResponse?> getMe() async {
    try {
      final response = await _dio.get('/api/v1/users/me');
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      appLogger.e('GET ME ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Không thể lấy thông tin người dùng');
    }
    return null;
  }

  Future<UserResponse?> updateProfile(ProfileUpdateRequest request) async {
    try {
      final response = await _dio.patch(
        '/api/v1/users/me/profile',
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      appLogger.e('UPDATE PROFILE ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Cập nhật hồ sơ thất bại');
    }
    return null;
  }

  Future<UserResponse?> getPersonalInfo() async {
    try {
      final response = await _dio.get('/api/v1/users/me/settings/personal-info');
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      appLogger.e('GET PERSONAL INFO ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Không thể lấy thông tin cá nhân');
    }
    return null;
  }

  Future<UserResponse?> updatePersonalInfo(ProfileUpdateRequest request) async {
    try {
      final response = await _dio.patch(
        '/api/v1/users/me/settings/personal-info',
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      appLogger.e('UPDATE PERSONAL INFO ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Cập nhật thông tin cá nhân thất bại');
    }
    return null;
  }

  Future<UserResponse?> updateAvatar(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await _dio.patch(
        '/api/v1/users/me/settings/avatar',
        data: formData,
      );

      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      appLogger.e('UPDATE AVATAR ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Cập nhật ảnh đại diện thất bại');
    }
    return null;
  }
}
