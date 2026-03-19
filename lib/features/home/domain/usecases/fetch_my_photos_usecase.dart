import '../../data/models/photo_models.dart';
import '../repositories/photo_repository.dart';

class FetchMyPhotosUseCase {
  const FetchMyPhotosUseCase(this._repository);

  final PhotoRepository _repository;

  Future<PageResponse<PhotoResponse>> call({int page = 0, int size = 20}) {
    return _repository.getMyPhotos(page: page, size: size);
  }
}

