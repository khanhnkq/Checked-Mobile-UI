import '../../domain/repositories/photo_repository.dart';
import '../models/photo_models.dart';
import '../models/reaction_models.dart';
import '../services/photo_service.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  PhotoRepositoryImpl({PhotoService? photoService})
    : _photoService = photoService ?? PhotoService();

  final PhotoService _photoService;

  @override
  Future<SliceResponse<PhotoResponse>> getFeed({
    int page = 0,
    int size = 20,
    String? friendId,
  }) {
    return _photoService.getFeed(page: page, size: size, friendId: friendId);
  }

  @override
  Future<PageResponse<PhotoResponse>> getMyPhotos({
    int page = 0,
    int size = 20,
  }) {
    return _photoService.getMyPhotos(page: page, size: size);
  }

  @override
  Future<PhotoReactionSummary> getReactionSummary(String photoId) {
    return _photoService.getReactionSummary(photoId);
  }

  @override
  Future<PhotoReaction> upsertMyReaction(String photoId, ReactionType type) {
    return _photoService.upsertMyReaction(photoId, type);
  }

  @override
  Future<void> deleteMyReaction(String photoId) {
    return _photoService.deleteMyReaction(photoId);
  }
}
