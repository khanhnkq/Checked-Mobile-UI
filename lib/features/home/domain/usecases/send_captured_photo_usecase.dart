import '../../data/models/photo_models.dart';
import '../repositories/camera_repository.dart';

class SendCapturedPhotoUseCase {
  const SendCapturedPhotoUseCase(this._repository);

  final CameraRepository _repository;

  Future<PhotoResponse?> call({
    required String filePath,
    double? amount,
    String? categoryId,
    String recipientScope = 'ALL_FRIENDS',
    List<String>? recipientIds,
  }) {
    return _repository.uploadCapturedPhoto(
      filePath: filePath,
      amount: amount,
      categoryId: categoryId,
      recipientScope: recipientScope,
      recipientIds: recipientIds,
    );
  }
}

