import '../../data/models/photo_models.dart';
import '../../data/models/reaction_models.dart';

abstract class PhotoRepository {
  Future<SliceResponse<PhotoResponse>> getFeed({
    int page = 0,
    int size = 20,
    String? friendId,
  });
  Future<PageResponse<PhotoResponse>> getMyPhotos({
    int page = 0,
    int size = 20,
  });
  Future<PhotoReactionSummary> getReactionSummary(String photoId);
  Future<PhotoReaction> upsertMyReaction(String photoId, ReactionType type);
  Future<void> deleteMyReaction(String photoId);
}
