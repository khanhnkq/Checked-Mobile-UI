// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  bool get isInitializing => throw _privateConstructorUsedError;
  String? get pendingEmail => throw _privateConstructorUsedError;
  AuthResponse? get authResponse => throw _privateConstructorUsedError;
  UserResponse? get userProfile => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    AuthStatus status,
    bool isInitializing,
    String? pendingEmail,
    AuthResponse? authResponse,
    UserResponse? userProfile,
    String? errorMessage,
  });

  $AuthResponseCopyWith<$Res>? get authResponse;
  $UserResponseCopyWith<$Res>? get userProfile;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isInitializing = null,
    Object? pendingEmail = freezed,
    Object? authResponse = freezed,
    Object? userProfile = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AuthStatus,
            isInitializing: null == isInitializing
                ? _value.isInitializing
                : isInitializing // ignore: cast_nullable_to_non_nullable
                      as bool,
            pendingEmail: freezed == pendingEmail
                ? _value.pendingEmail
                : pendingEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            authResponse: freezed == authResponse
                ? _value.authResponse
                : authResponse // ignore: cast_nullable_to_non_nullable
                      as AuthResponse?,
            userProfile: freezed == userProfile
                ? _value.userProfile
                : userProfile // ignore: cast_nullable_to_non_nullable
                      as UserResponse?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthResponseCopyWith<$Res>? get authResponse {
    if (_value.authResponse == null) {
      return null;
    }

    return $AuthResponseCopyWith<$Res>(_value.authResponse!, (value) {
      return _then(_value.copyWith(authResponse: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserResponseCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserResponseCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthStatus status,
    bool isInitializing,
    String? pendingEmail,
    AuthResponse? authResponse,
    UserResponse? userProfile,
    String? errorMessage,
  });

  @override
  $AuthResponseCopyWith<$Res>? get authResponse;
  @override
  $UserResponseCopyWith<$Res>? get userProfile;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isInitializing = null,
    Object? pendingEmail = freezed,
    Object? authResponse = freezed,
    Object? userProfile = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$AuthStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
        isInitializing: null == isInitializing
            ? _value.isInitializing
            : isInitializing // ignore: cast_nullable_to_non_nullable
                  as bool,
        pendingEmail: freezed == pendingEmail
            ? _value.pendingEmail
            : pendingEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        authResponse: freezed == authResponse
            ? _value.authResponse
            : authResponse // ignore: cast_nullable_to_non_nullable
                  as AuthResponse?,
        userProfile: freezed == userProfile
            ? _value.userProfile
            : userProfile // ignore: cast_nullable_to_non_nullable
                  as UserResponse?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl extends _AuthState {
  const _$AuthStateImpl({
    required this.status,
    required this.isInitializing,
    this.pendingEmail,
    this.authResponse,
    this.userProfile,
    this.errorMessage,
  }) : super._();

  @override
  final AuthStatus status;
  @override
  final bool isInitializing;
  @override
  final String? pendingEmail;
  @override
  final AuthResponse? authResponse;
  @override
  final UserResponse? userProfile;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState(status: $status, isInitializing: $isInitializing, pendingEmail: $pendingEmail, authResponse: $authResponse, userProfile: $userProfile, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isInitializing, isInitializing) ||
                other.isInitializing == isInitializing) &&
            (identical(other.pendingEmail, pendingEmail) ||
                other.pendingEmail == pendingEmail) &&
            (identical(other.authResponse, authResponse) ||
                other.authResponse == authResponse) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    isInitializing,
    pendingEmail,
    authResponse,
    userProfile,
    errorMessage,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState extends AuthState {
  const factory _AuthState({
    required final AuthStatus status,
    required final bool isInitializing,
    final String? pendingEmail,
    final AuthResponse? authResponse,
    final UserResponse? userProfile,
    final String? errorMessage,
  }) = _$AuthStateImpl;
  const _AuthState._() : super._();

  @override
  AuthStatus get status;
  @override
  bool get isInitializing;
  @override
  String? get pendingEmail;
  @override
  AuthResponse? get authResponse;
  @override
  UserResponse? get userProfile;
  @override
  String? get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
