import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  int _cameraIndex = 0;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        await _setupController();
      }
    } catch (e) {
      debugPrint('Error getting cameras: $e');
    }
  }

  Future<void> _setupController() async {
    if (_cameras == null || _cameras!.isEmpty) return;

    _isInitialized = false;
    notifyListeners();

    // Hủy controller cũ nếu có trước khi tạo cái mới
    if (_controller != null) {
      await _controller!.dispose();
    }

    _controller = CameraController(
      _cameras![_cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      _isInitialized = false;
    }
    notifyListeners();
  }

  Future<void> flipCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    _cameraIndex = (_cameraIndex + 1) % _cameras!.length;
    await _setupController();
  }

  Future<XFile?> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return null;
    
    try {
      final image = await controller.takePicture();
      return image;
    } catch (e) {
      debugPrint('Error taking picture: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
