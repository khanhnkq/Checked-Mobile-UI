import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../data/models/photo_models.dart';
import '../../data/repositories/camera_repository_impl.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../domain/usecases/capture_photo_usecase.dart';
import '../../domain/usecases/initialize_camera_usecase.dart';
import '../../domain/usecases/send_captured_photo_usecase.dart';
import 'camera_state.dart';

class CameraNotifier extends StateNotifier<CameraState> {
  final CameraRepository _repository;
  late final InitializeCameraUseCase _initializeCameraUseCase;
  late final CapturePhotoUseCase _capturePhotoUseCase;
  late final SendCapturedPhotoUseCase _sendCapturedPhotoUseCase;

  bool _isDisposed = false;

  CameraNotifier({CameraRepository? repository})
      : _repository = repository ?? CameraRepositoryImpl(),
        super(CameraState.initial()) {
    _initializeCameraUseCase = InitializeCameraUseCase(_repository);
    _capturePhotoUseCase = CapturePhotoUseCase(_repository);
    _sendCapturedPhotoUseCase = SendCapturedPhotoUseCase(_repository);
  }

  Future<void> initialize() async {
    if (_isDisposed) {
      return;
    }

    try {
      final cameras = await _initializeCameraUseCase.call();
      state = state.copyWith(cameras: cameras);
      if (cameras.isNotEmpty) {
        await _setupController();
      }
    } catch (e) {
      appLogger.e('Error getting cameras', error: e);
    }
  }

  Future<void> _setupController() async {
    if (state.cameras.isEmpty || _isDisposed) {
      return;
    }

    state = state.copyWith(isInitialized: false);

    final oldController = state.controller;
    await oldController?.dispose();

    if (_isDisposed) {
      return;
    }

    final newController = _repository.createController(state.cameras[state.cameraIndex]);

    try {
      await newController.initialize();
      if (!_isDisposed) {
        state = state.copyWith(
          controller: newController,
          isInitialized: true,
        );
      } else {
        await newController.dispose();
      }
    } catch (e) {
      appLogger.e('Camera initialization error', error: e);
      state = state.copyWith(isInitialized: false);
    }
  }

  Future<void> flipCamera() async {
    if (state.cameras.length < 2 || _isDisposed) {
      return;
    }

    final newIndex = (state.cameraIndex + 1) % state.cameras.length;
    state = state.copyWith(cameraIndex: newIndex);
    await _setupController();
  }

  Future<XFile?> takePicture() async {
    final cameraController = state.controller;
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
    state = state.copyWith(
      isSending: true,
      sendErrorMessage: null,
    );

    try {
      return await _sendCapturedPhotoUseCase.call(
        filePath: filePath,
        amount: amount,
        categoryId: categoryId,
        recipientScope: recipientScope,
        recipientIds: recipientIds,
      );
    } catch (e) {
      state = state.copyWith(
        sendErrorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return null;
    } finally {
      state = state.copyWith(isSending: false);
    }
  }

  void reset() {
    state.controller?.dispose();
    state = state.copyWith(
      controller: null,
      isInitialized: false,
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    state.controller?.dispose();
    super.dispose();
  }
}

