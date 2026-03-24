import 'package:dio/dio.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../../../profile/data/models/profile_models.dart';

class FriendshipService {
  FriendshipService({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;

  Future<List<UserResponse>> getFriendships() async {
    try {
      final response = await _dio.get('/api/v1/friendships');
      final data = response.data;
      if (data is! List) {
        throw Exception('Invalid friendship response');
      }

      return data
          .whereType<Map<String, dynamic>>()
          .map(UserResponse.fromJson)
          .toList();
    } on DioException catch (e) {
      appLogger.e('GET FRIENDSHIPS ERROR', error: e.response?.data ?? e);
      final data = e.response?.data;
      final message = data is Map<String, dynamic> && data['message'] is String
          ? data['message'] as String
          : 'Không thể tải danh sách bạn bè';
      throw Exception(message);
    }
  }
}
