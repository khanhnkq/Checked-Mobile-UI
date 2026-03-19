import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../core/logging/app_logger.dart';
import '../../data/models/photo_models.dart';
import '../../data/repositories/camera_repository_impl.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../domain/usecases/capture_photo_usecase.dart';
import '../../domain/usecases/initialize_camera_usecase.dart';
import '../../domain/usecases/send_captured_photo_usecase.dart';

class CameraViewModel extends ChangeNotifier {
  CameraViewModel({CameraRepository? repository})
      : _repository = repository ?? CameraRepositoryImpl() {
    _initializeCameraUseCase = InitializeCameraUseCase(_repository);
    _capturePhotoUseCase = CapturePhotoUseCase(_repository);
    _sendCapturedPhotoUseCase = SendCapturedPhotoUseCase(_repository);
  }

  final CameraRepository _repository;
  late final InitializeCameraUseCase _initializeCameraUseCase;
  late final CapturePhotoUseCase _capturePhotoUseCase;
  late final SendCapturedPhotoUseCase _sendCapturedPhotoUseCase;

  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  int _cameraIndex = 0;
  bool _isDisposed = false;

  bool _isSending = false;
  String? _sendErrorMessage;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isSending => _isSending;
  String? get sendErrorMessage => _sendErrorMessage;

  Future<void> initialize() async {
    if (_isDisposed) {
      return;
    }

    try {
      _cameras = await _initializeCameraUseCase.call();
      if (_cameras.isNotEmpty) {
        await _setupController();
      }
    } catch (e) {
      appLogger.e('Error getting cameras', error: e);
    }
  }

  Future<void> _setupController() async {
    if (_cameras.isEmpty || _isDisposed) {
      return;
    }

    _isInitialized = false;
    notifyListeners();

    final oldController = _controller;
    _controller = null;
    await oldController?.dispose();

    if (_isDisposed) {
      return;
    }

    _controller = _repository.createController(_cameras[_cameraIndex]);

    try {
      await _controller!.initialize();
      if (!_isDisposed) {
        _isInitialized = true;
      } else {
        await _controller?.dispose();
        _controller = null;
      }
    } catch (e) {
      appLogger.e('Camera initialization error', error: e);
      _isInitialized = false;
    }

    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> flipCamera() async {
    if (_cameras.length < 2 || _isDisposed) {
      return;
    }

    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    await _setupController();
  }

  Future<XFile?> takePicture() async {
    final cameraController = _controller;
    if (cameraController == null ||
        !cameraController.value.isInitialized ||
        _isDisposed) {
      return null;
    }

    try {
      return _capturePhotoUseCase.call(cameraController);
    } catch (e) {
      appLogger.e('Error taking picture', error: e);
      return null;
    }
  }

  Future<PhotoResponse?> sendCapturedPhoto({
    required String filePath,
    double? amount,
    String? categoryId,
    String recipientScope = 'ALL_FRIENDS',
    List<String>? recipientIds,
  }) async {
    _isSending = true;
    _sendErrorMessage = null;
    notifyListeners();

    try {
      return await _sendCapturedPhotoUseCase.call(
        filePath: filePath,
        amount: amount,
        categoryId: categoryId,
        recipientScope: recipientScope,
        recipientIds: recipientIds,
      );
    } catch (e) {
      _sendErrorMessage = e.toString().replaceAll('Exception: ', '');
      return null;
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  void reset() {
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }
}

