import 'package:camera/camera.dart';

import '../../domain/repositories/camera_repository.dart';
import '../models/photo_models.dart';
import '../services/device_camera_service.dart';
import '../services/photo_service.dart';

class CameraRepositoryImpl implements CameraRepository {
  CameraRepositoryImpl({
    DeviceCameraService? deviceCameraService,
    PhotoService? photoService,
  })  : _deviceCameraService = deviceCameraService ?? DeviceCameraService(),
        _photoService = photoService ?? PhotoService();

  final DeviceCameraService _deviceCameraService;
  final PhotoService _photoService;

  @override
  Future<List<CameraDescription>> getAvailableCameras() {
    return _deviceCameraService.getAvailableCameras();
  }

  @override
  CameraController createController(CameraDescription camera) {
    return _deviceCameraService.createController(camera);
  }

  @override
  Future<XFile?> takePicture(CameraController controller) async {
    if (!controller.value.isInitialized) {
      return null;
    }
    return controller.takePicture();
  }

  @override
  Future<PhotoResponse?> uploadCapturedPhoto({
    required String filePath,
    double? amount,
    String? categoryId,
    String recipientScope = 'ALL_FRIENDS',
    List<String>? recipientIds,
  }) {
    return _photoService.uploadPhoto(
      filePath: filePath,
      amount: amount,
      categoryId: categoryId,
      recipientScope: recipientScope,
      recipientIds: recipientIds,
    );
  }
}

