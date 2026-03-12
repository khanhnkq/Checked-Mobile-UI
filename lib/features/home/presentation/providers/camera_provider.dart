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
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      await _setupController();
    }
  }

  Future<void> _setupController() async {
    if (_cameras == null || _cameras!.isEmpty) return;

    _isInitialized = false;
    notifyListeners();

    _controller = CameraController(
      _cameras![_cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      _isInitialized = true;
    } catch (e) {
      print('Camera initialization error: $e');
    }
    notifyListeners();
  }

  Future<void> flipCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    _cameraIndex = (_cameraIndex + 1) % _cameras!.length;
    await _controller?.dispose();
    await _setupController();
  }

  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return null;
    
    try {
      final image = await _controller!.takePicture();
      return image;
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
