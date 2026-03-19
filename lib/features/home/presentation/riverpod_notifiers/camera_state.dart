import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    CameraController? controller,
    @Default([]) List<CameraDescription> cameras,
    @Default(false) bool isInitialized,
    @Default(0) int cameraIndex,
    @Default(false) bool isSending,
    String? sendErrorMessage,
  }) = _CameraState;

  factory CameraState.initial() => const CameraState();
}

