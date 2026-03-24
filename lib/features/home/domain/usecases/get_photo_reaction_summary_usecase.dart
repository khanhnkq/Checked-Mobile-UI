import '../../data/models/reaction_models.dart';
import '../repositories/photo_repository.dart';

class GetPhotoReactionSummaryUseCase {
  const GetPhotoReactionSummaryUseCase(this._repository);

  final PhotoRepository _repository;

  Future<PhotoReactionSummary> call(String photoId) {
    return _repository.getReactionSummary(photoId);
  }
}
