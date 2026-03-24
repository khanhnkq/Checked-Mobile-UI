import '../repositories/photo_repository.dart';

class DeletePhotoReactionUseCase {
  const DeletePhotoReactionUseCase(this._repository);

  final PhotoRepository _repository;

  Future<void> call(String photoId) {
    return _repository.deleteMyReaction(photoId);
  }
}
