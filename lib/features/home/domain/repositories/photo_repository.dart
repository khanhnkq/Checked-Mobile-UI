import '../../data/models/photo_models.dart';

abstract class PhotoRepository {
  Future<SliceResponse<PhotoResponse>> getFeed({int page = 0, int size = 20});
  Future<PageResponse<PhotoResponse>> getMyPhotos({int page = 0, int size = 20});
}

