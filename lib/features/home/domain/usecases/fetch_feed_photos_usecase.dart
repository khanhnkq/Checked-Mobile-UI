import '../../data/models/photo_models.dart';
import '../repositories/photo_repository.dart';

class FetchFeedPhotosUseCase {
  const FetchFeedPhotosUseCase(this._repository);

  final PhotoRepository _repository;

  Future<SliceResponse<PhotoResponse>> call({int page = 0, int size = 20}) {
    return _repository.getFeed(page: page, size: size);
  }
}

