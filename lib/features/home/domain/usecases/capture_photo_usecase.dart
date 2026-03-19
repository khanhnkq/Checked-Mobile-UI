import 'package:camera/camera.dart';

import '../repositories/camera_repository.dart';

class CapturePhotoUseCase {
  const CapturePhotoUseCase(this._repository);

  final CameraRepository _repository;

  Future<XFile?> call(CameraController controller) {
    return _repository.takePicture(controller);
  }
}

