import 'package:camera/camera.dart';

import '../repositories/camera_repository.dart';

class InitializeCameraUseCase {
  const InitializeCameraUseCase(this._repository);

  final CameraRepository _repository;

  Future<List<CameraDescription>> call() {
    return _repository.getAvailableCameras();
  }
}

