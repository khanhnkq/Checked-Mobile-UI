import '../../data/models/reaction_models.dart';
import '../repositories/photo_repository.dart';

class UpsertPhotoReactionUseCase {
  const UpsertPhotoReactionUseCase(this._repository);

  final PhotoRepository _repository;

  Future<PhotoReaction> call(String photoId, ReactionType type) {
    return _repository.upsertMyReaction(photoId, type);
  }
}
