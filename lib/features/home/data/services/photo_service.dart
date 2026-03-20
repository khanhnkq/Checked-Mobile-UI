import 'package:dio/dio.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../models/photo_models.dart';

class PhotoService {
  PhotoService({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;

  Future<PhotoResponse?> uploadPhoto({
    required String filePath,
    String? caption,
    double? amount,
    String? categoryId,
    String recipientScope = 'ALL_FRIENDS',
    List<String>? recipientIds,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
        if (caption != null) 'caption': caption,
        if (amount != null) 'amount': amount,
        if (categoryId != null) 'categoryId': categoryId,
        'recipientScope': recipientScope,
        if (recipientIds != null && recipientIds.isNotEmpty)
          'recipientIds': recipientIds.join(','),
        'takenAt': DateTime.now().toIso8601String(),
      });

      final response = await _dio.post(
        '/api/v1/photos',
        data: formData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return PhotoResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      appLogger.e('UPLOAD PHOTO ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Gửi ảnh thất bại');
    }
    return null;
  }

  Future<SliceResponse<PhotoResponse>> getFeed({int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/api/v1/photos/feed',
        queryParameters: {'page': page, 'size': size},
      );
      return SliceResponse<PhotoResponse>.fromJson(
        response.data,
        (json) => PhotoResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      appLogger.e('GET FEED ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Không thể tải bảng tin');
    }
  }

  Future<PageResponse<PhotoResponse>> getMyPhotos({int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/api/v1/photos/my-photos',
        queryParameters: {'page': page, 'size': size},
      );
      return PageResponse<PhotoResponse>.fromJson(
        response.data,
        (json) => PhotoResponse.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      appLogger.e('GET MY PHOTOS ERROR', error: e.response?.data ?? e);
      throw Exception(e.response?.data['message'] ?? 'Không thể tải ảnh của tôi');
    }
  }
}
