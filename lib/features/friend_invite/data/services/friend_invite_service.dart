import 'package:dio/dio.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../models/friend_invite_models.dart';

class FriendInviteApiException implements Exception {
  const FriendInviteApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class FriendInviteService {
  FriendInviteService({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;

  Future<FriendInviteLinkResponse> createInviteLink({int? ttlMinutes}) async {
    try {
      final response = await _dio.post(
        '/api/v1/friend-invite-links',
        data: FriendInviteLinkCreateRequest(ttlMinutes: ttlMinutes).toJson(),
      );
      return FriendInviteLinkResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      appLogger.e('CREATE INVITE LINK ERROR', error: e.response?.data ?? e);
      throw _toApiException(e, fallbackMessage: 'Không thể tạo link mời');
    }
  }

  Future<FriendInviteLinkResponse> getCurrentInviteLink() async {
    try {
      final response = await _dio.get('/api/v1/friend-invite-links/current');
      return FriendInviteLinkResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      appLogger.e(
        'GET CURRENT INVITE LINK ERROR',
        error: e.response?.data ?? e,
      );
      throw _toApiException(
        e,
        fallbackMessage: 'Không thể tải link mời hiện tại',
      );
    }
  }

  Future<void> revokeCurrentInviteLink() async {
    try {
      await _dio.delete('/api/v1/friend-invite-links/current');
    } on DioException catch (e) {
      appLogger.e('REVOKE INVITE LINK ERROR', error: e.response?.data ?? e);
      throw _toApiException(e, fallbackMessage: 'Không thể thu hồi link mời');
    }
  }

  Future<FriendInviteAcceptResponse> acceptInvite({
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/friend-invite-links/accept',
        data: FriendInviteAcceptRequest(token: token).toJson(),
      );
      return FriendInviteAcceptResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      appLogger.e('ACCEPT INVITE LINK ERROR', error: e.response?.data ?? e);
      throw _toApiException(e, fallbackMessage: 'Không thể chấp nhận lời mời');
    }
  }

  FriendInviteApiException _toApiException(
    DioException e, {
    required String fallbackMessage,
  }) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;
    String message = fallbackMessage;

    if (data is Map<String, dynamic> && data['message'] is String) {
      message = data['message'] as String;
    }

    return FriendInviteApiException(message: message, statusCode: statusCode);
  }
}
