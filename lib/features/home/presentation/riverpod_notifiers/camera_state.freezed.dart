// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CameraState {
  CameraController? get controller => throw _privateConstructorUsedError;
  List<CameraDescription> get cameras => throw _privateConstructorUsedError;
  bool get isInitialized => throw _privateConstructorUsedError;
  int get cameraIndex => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  String? get sendErrorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CameraStateCopyWith<CameraState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraStateCopyWith<$Res> {
  factory $CameraStateCopyWith(
    CameraState value,
    $Res Function(CameraState) then,
  ) = _$CameraStateCopyWithImpl<$Res, CameraState>;
  @useResult
  $Res call({
    CameraController? controller,
    List<CameraDescription> cameras,
    bool isInitialized,
    int cameraIndex,
    bool isSending,
    String? sendErrorMessage,
  });
}

/// @nodoc
class _$CameraStateCopyWithImpl<$Res, $Val extends CameraState>
    implements $CameraStateCopyWith<$Res> {
  _$CameraStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? cameras = null,
    Object? isInitialized = null,
    Object? cameraIndex = null,
    Object? isSending = null,
    Object? sendErrorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            controller: freezed == controller
                ? _value.controller
                : controller // ignore: cast_nullable_to_non_nullable
                      as CameraController?,
            cameras: null == cameras
                ? _value.cameras
                : cameras // ignore: cast_nullable_to_non_nullable
                      as List<CameraDescription>,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            cameraIndex: null == cameraIndex
                ? _value.cameraIndex
                : cameraIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            sendErrorMessage: freezed == sendErrorMessage
                ? _value.sendErrorMessage
                : sendErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CameraStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraStateImplCopyWith(
    _$CameraStateImpl value,
    $Res Function(_$CameraStateImpl) then,
  ) = __$$CameraStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CameraController? controller,
    List<CameraDescription> cameras,
    bool isInitialized,
    int cameraIndex,
    bool isSending,
    String? sendErrorMessage,
  });
}

/// @nodoc
class __$$CameraStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraStateImpl>
    implements _$$CameraStateImplCopyWith<$Res> {
  __$$CameraStateImplCopyWithImpl(
    _$CameraStateImpl _value,
    $Res Function(_$CameraStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? cameras = null,
    Object? isInitialized = null,
    Object? cameraIndex = null,
    Object? isSending = null,
    Object? sendErrorMessage = freezed,
  }) {
    return _then(
      _$CameraStateImpl(
        controller: freezed == controller
            ? _value.controller
            : controller // ignore: cast_nullable_to_non_nullable
                  as CameraController?,
        cameras: null == cameras
            ? _value._cameras
            : cameras // ignore: cast_nullable_to_non_nullable
                  as List<CameraDescription>,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        cameraIndex: null == cameraIndex
            ? _value.cameraIndex
            : cameraIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        sendErrorMessage: freezed == sendErrorMessage
            ? _value.sendErrorMessage
            : sendErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CameraStateImpl implements _CameraState {
  const _$CameraStateImpl({
    this.controller,
    final List<CameraDescription> cameras = const [],
    this.isInitialized = false,
    this.cameraIndex = 0,
    this.isSending = false,
    this.sendErrorMessage,
  }) : _cameras = cameras;

  @override
  final CameraController? controller;
  final List<CameraDescription> _cameras;
  @override
  @JsonKey()
  List<CameraDescription> get cameras {
    if (_cameras is EqualUnmodifiableListView) return _cameras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cameras);
  }

  @override
  @JsonKey()
  final bool isInitialized;
  @override
  @JsonKey()
  final int cameraIndex;
  @override
  @JsonKey()
  final bool isSending;
  @override
  final String? sendErrorMessage;

  @override
  String toString() {
    return 'CameraState(controller: $controller, cameras: $cameras, isInitialized: $isInitialized, cameraIndex: $cameraIndex, isSending: $isSending, sendErrorMessage: $sendErrorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStateImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            const DeepCollectionEquality().equals(other._cameras, _cameras) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.cameraIndex, cameraIndex) ||
                other.cameraIndex == cameraIndex) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.sendErrorMessage, sendErrorMessage) ||
                other.sendErrorMessage == sendErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    controller,
    const DeepCollectionEquality().hash(_cameras),
    isInitialized,
    cameraIndex,
    isSending,
    sendErrorMessage,
  );

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStateImplCopyWith<_$CameraStateImpl> get copyWith =>
      __$$CameraStateImplCopyWithImpl<_$CameraStateImpl>(this, _$identity);
}

abstract class _CameraState implements CameraState {
  const factory _CameraState({
    final CameraController? controller,
    final List<CameraDescription> cameras,
    final bool isInitialized,
    final int cameraIndex,
    final bool isSending,
    final String? sendErrorMessage,
  }) = _$CameraStateImpl;

  @override
  CameraController? get controller;
  @override
  List<CameraDescription> get cameras;
  @override
  bool get isInitialized;
  @override
  int get cameraIndex;
  @override
  bool get isSending;
  @override
  String? get sendErrorMessage;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraStateImplCopyWith<_$CameraStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
