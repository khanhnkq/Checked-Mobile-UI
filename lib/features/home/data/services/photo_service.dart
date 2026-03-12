import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/photo_models.dart';

class PhotoService {
  final Dio _dio = DioClient().dio;

  Future<PhotoResponse?> uploadPhoto({
    required String filePath,
    String? caption,
    double? amount,
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
      print('UPLOAD PHOTO ERROR: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Gửi ảnh thất bại');
    }
    return null;
  }

  Future<List<PhotoResponse>> getFeed() async {
    try {
      final response = await _dio.get('/api/v1/photos/feed');
      return _parsePhotoList(response.data);
    } on DioException catch (e) {
      print('GET FEED ERROR: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Không thể tải bảng tin');
    }
  }

  Future<List<PhotoResponse>> getMyPhotos() async {
    try {
      final response = await _dio.get('/api/v1/photos/my-photos');
      return _parsePhotoList(response.data);
    } on DioException catch (e) {
      print('GET MY PHOTOS ERROR: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Không thể tải ảnh của tôi');
    }
  }

  /// Hàm helper để parse dữ liệu linh hoạt từ List hoặc Map (wrap dữ liệu)
  List<PhotoResponse> _parsePhotoList(dynamic data) {
    if (data == null) return [];
    
    List<dynamic> list = [];
    
    if (data is List) {
      list = data;
    } else if (data is Map) {
      // Tìm danh sách trong các key phổ biến của Spring Data (content, data, results)
      list = data['content'] ?? data['data'] ?? data['results'] ?? [];
    }
    
    return list.map((json) => PhotoResponse.fromJson(json)).toList();
  }
}
