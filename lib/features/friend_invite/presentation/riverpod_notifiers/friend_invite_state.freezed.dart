// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_invite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FriendInviteState {
  FriendInviteLinkResponse? get currentLink =>
      throw _privateConstructorUsedError;
  FriendInviteCurrentStatus get currentStatus =>
      throw _privateConstructorUsedError;
  FriendInviteActionStatus get createStatus =>
      throw _privateConstructorUsedError;
  FriendInviteActionStatus get revokeStatus =>
      throw _privateConstructorUsedError;
  FriendInviteAcceptStatus get acceptStatus =>
      throw _privateConstructorUsedError;
  FriendInviteAcceptResponse? get acceptedResult =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendInviteStateCopyWith<FriendInviteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendInviteStateCopyWith<$Res> {
  factory $FriendInviteStateCopyWith(
    FriendInviteState value,
    $Res Function(FriendInviteState) then,
  ) = _$FriendInviteStateCopyWithImpl<$Res, FriendInviteState>;
  @useResult
  $Res call({
    FriendInviteLinkResponse? currentLink,
    FriendInviteCurrentStatus currentStatus,
    FriendInviteActionStatus createStatus,
    FriendInviteActionStatus revokeStatus,
    FriendInviteAcceptStatus acceptStatus,
    FriendInviteAcceptResponse? acceptedResult,
    String? errorMessage,
  });

  $FriendInviteLinkResponseCopyWith<$Res>? get currentLink;
  $FriendInviteAcceptResponseCopyWith<$Res>? get acceptedResult;
}

/// @nodoc
class _$FriendInviteStateCopyWithImpl<$Res, $Val extends FriendInviteState>
    implements $FriendInviteStateCopyWith<$Res> {
  _$FriendInviteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentLink = freezed,
    Object? currentStatus = null,
    Object? createStatus = null,
    Object? revokeStatus = null,
    Object? acceptStatus = null,
    Object? acceptedResult = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentLink: freezed == currentLink
                ? _value.currentLink
                : currentLink // ignore: cast_nullable_to_non_nullable
                      as FriendInviteLinkResponse?,
            currentStatus: null == currentStatus
                ? _value.currentStatus
                : currentStatus // ignore: cast_nullable_to_non_nullable
                      as FriendInviteCurrentStatus,
            createStatus: null == createStatus
                ? _value.createStatus
                : createStatus // ignore: cast_nullable_to_non_nullable
                      as FriendInviteActionStatus,
            revokeStatus: null == revokeStatus
                ? _value.revokeStatus
                : revokeStatus // ignore: cast_nullable_to_non_nullable
                      as FriendInviteActionStatus,
            acceptStatus: null == acceptStatus
                ? _value.acceptStatus
                : acceptStatus // ignore: cast_nullable_to_non_nullable
                      as FriendInviteAcceptStatus,
            acceptedResult: freezed == acceptedResult
                ? _value.acceptedResult
                : acceptedResult // ignore: cast_nullable_to_non_nullable
                      as FriendInviteAcceptResponse?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendInviteLinkResponseCopyWith<$Res>? get currentLink {
    if (_value.currentLink == null) {
      return null;
    }

    return $FriendInviteLinkResponseCopyWith<$Res>(_value.currentLink!, (
      value,
    ) {
      return _then(_value.copyWith(currentLink: value) as $Val);
    });
  }

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendInviteAcceptResponseCopyWith<$Res>? get acceptedResult {
    if (_value.acceptedResult == null) {
      return null;
    }

    return $FriendInviteAcceptResponseCopyWith<$Res>(_value.acceptedResult!, (
      value,
    ) {
      return _then(_value.copyWith(acceptedResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendInviteStateImplCopyWith<$Res>
    implements $FriendInviteStateCopyWith<$Res> {
  factory _$$FriendInviteStateImplCopyWith(
    _$FriendInviteStateImpl value,
    $Res Function(_$FriendInviteStateImpl) then,
  ) = __$$FriendInviteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FriendInviteLinkResponse? currentLink,
    FriendInviteCurrentStatus currentStatus,
    FriendInviteActionStatus createStatus,
    FriendInviteActionStatus revokeStatus,
    FriendInviteAcceptStatus acceptStatus,
    FriendInviteAcceptResponse? acceptedResult,
    String? errorMessage,
  });

  @override
  $FriendInviteLinkResponseCopyWith<$Res>? get currentLink;
  @override
  $FriendInviteAcceptResponseCopyWith<$Res>? get acceptedResult;
}

/// @nodoc
class __$$FriendInviteStateImplCopyWithImpl<$Res>
    extends _$FriendInviteStateCopyWithImpl<$Res, _$FriendInviteStateImpl>
    implements _$$FriendInviteStateImplCopyWith<$Res> {
  __$$FriendInviteStateImplCopyWithImpl(
    _$FriendInviteStateImpl _value,
    $Res Function(_$FriendInviteStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentLink = freezed,
    Object? currentStatus = null,
    Object? createStatus = null,
    Object? revokeStatus = null,
    Object? acceptStatus = null,
    Object? acceptedResult = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$FriendInviteStateImpl(
        currentLink: freezed == currentLink
            ? _value.currentLink
            : currentLink // ignore: cast_nullable_to_non_nullable
                  as FriendInviteLinkResponse?,
        currentStatus: null == currentStatus
            ? _value.currentStatus
            : currentStatus // ignore: cast_nullable_to_non_nullable
                  as FriendInviteCurrentStatus,
        createStatus: null == createStatus
            ? _value.createStatus
            : createStatus // ignore: cast_nullable_to_non_nullable
                  as FriendInviteActionStatus,
        revokeStatus: null == revokeStatus
            ? _value.revokeStatus
            : revokeStatus // ignore: cast_nullable_to_non_nullable
                  as FriendInviteActionStatus,
        acceptStatus: null == acceptStatus
            ? _value.acceptStatus
            : acceptStatus // ignore: cast_nullable_to_non_nullable
                  as FriendInviteAcceptStatus,
        acceptedResult: freezed == acceptedResult
            ? _value.acceptedResult
            : acceptedResult // ignore: cast_nullable_to_non_nullable
                  as FriendInviteAcceptResponse?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FriendInviteStateImpl implements _FriendInviteState {
  const _$FriendInviteStateImpl({
    this.currentLink,
    this.currentStatus = FriendInviteCurrentStatus.idle,
    this.createStatus = FriendInviteActionStatus.idle,
    this.revokeStatus = FriendInviteActionStatus.idle,
    this.acceptStatus = FriendInviteAcceptStatus.idle,
    this.acceptedResult,
    this.errorMessage,
  });

  @override
  final FriendInviteLinkResponse? currentLink;
  @override
  @JsonKey()
  final FriendInviteCurrentStatus currentStatus;
  @override
  @JsonKey()
  final FriendInviteActionStatus createStatus;
  @override
  @JsonKey()
  final FriendInviteActionStatus revokeStatus;
  @override
  @JsonKey()
  final FriendInviteAcceptStatus acceptStatus;
  @override
  final FriendInviteAcceptResponse? acceptedResult;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'FriendInviteState(currentLink: $currentLink, currentStatus: $currentStatus, createStatus: $createStatus, revokeStatus: $revokeStatus, acceptStatus: $acceptStatus, acceptedResult: $acceptedResult, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendInviteStateImpl &&
            (identical(other.currentLink, currentLink) ||
                other.currentLink == currentLink) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.createStatus, createStatus) ||
                other.createStatus == createStatus) &&
            (identical(other.revokeStatus, revokeStatus) ||
                other.revokeStatus == revokeStatus) &&
            (identical(other.acceptStatus, acceptStatus) ||
                other.acceptStatus == acceptStatus) &&
            (identical(other.acceptedResult, acceptedResult) ||
                other.acceptedResult == acceptedResult) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentLink,
    currentStatus,
    createStatus,
    revokeStatus,
    acceptStatus,
    acceptedResult,
    errorMessage,
  );

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendInviteStateImplCopyWith<_$FriendInviteStateImpl> get copyWith =>
      __$$FriendInviteStateImplCopyWithImpl<_$FriendInviteStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FriendInviteState implements FriendInviteState {
  const factory _FriendInviteState({
    final FriendInviteLinkResponse? currentLink,
    final FriendInviteCurrentStatus currentStatus,
    final FriendInviteActionStatus createStatus,
    final FriendInviteActionStatus revokeStatus,
    final FriendInviteAcceptStatus acceptStatus,
    final FriendInviteAcceptResponse? acceptedResult,
    final String? errorMessage,
  }) = _$FriendInviteStateImpl;

  @override
  FriendInviteLinkResponse? get currentLink;
  @override
  FriendInviteCurrentStatus get currentStatus;
  @override
  FriendInviteActionStatus get createStatus;
  @override
  FriendInviteActionStatus get revokeStatus;
  @override
  FriendInviteAcceptStatus get acceptStatus;
  @override
  FriendInviteAcceptResponse? get acceptedResult;
  @override
  String? get errorMessage;

  /// Create a copy of FriendInviteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendInviteStateImplCopyWith<_$FriendInviteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
