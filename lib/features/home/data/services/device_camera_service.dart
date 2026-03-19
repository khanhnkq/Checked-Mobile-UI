import 'package:camera/camera.dart';

class DeviceCameraService {
  Future<List<CameraDescription>> getAvailableCameras() {
    return availableCameras();
  }

  CameraController createController(CameraDescription camera) {
    return CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
  }
}

