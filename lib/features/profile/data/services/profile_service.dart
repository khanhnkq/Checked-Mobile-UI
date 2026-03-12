import 'package:dio/dio.dart';
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
      print('GET ME ERROR: ${e.response?.data}');
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
      print('UPDATE PROFILE ERROR: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Cập nhật hồ sơ thất bại');
    }
    return null;
  }
}
