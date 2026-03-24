// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FriendshipState {
  List<UserResponse> get friends => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of FriendshipState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendshipStateCopyWith<FriendshipState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendshipStateCopyWith<$Res> {
  factory $FriendshipStateCopyWith(
    FriendshipState value,
    $Res Function(FriendshipState) then,
  ) = _$FriendshipStateCopyWithImpl<$Res, FriendshipState>;
  @useResult
  $Res call({List<UserResponse> friends, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$FriendshipStateCopyWithImpl<$Res, $Val extends FriendshipState>
    implements $FriendshipStateCopyWith<$Res> {
  _$FriendshipStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendshipState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            friends: null == friends
                ? _value.friends
                : friends // ignore: cast_nullable_to_non_nullable
                      as List<UserResponse>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendshipStateImplCopyWith<$Res>
    implements $FriendshipStateCopyWith<$Res> {
  factory _$$FriendshipStateImplCopyWith(
    _$FriendshipStateImpl value,
    $Res Function(_$FriendshipStateImpl) then,
  ) = __$$FriendshipStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserResponse> friends, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$$FriendshipStateImplCopyWithImpl<$Res>
    extends _$FriendshipStateCopyWithImpl<$Res, _$FriendshipStateImpl>
    implements _$$FriendshipStateImplCopyWith<$Res> {
  __$$FriendshipStateImplCopyWithImpl(
    _$FriendshipStateImpl _value,
    $Res Function(_$FriendshipStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendshipState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$FriendshipStateImpl(
        friends: null == friends
            ? _value._friends
            : friends // ignore: cast_nullable_to_non_nullable
                  as List<UserResponse>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FriendshipStateImpl implements _FriendshipState {
  const _$FriendshipStateImpl({
    final List<UserResponse> friends = const [],
    this.isLoading = false,
    this.errorMessage,
  }) : _friends = friends;

  final List<UserResponse> _friends;
  @override
  @JsonKey()
  List<UserResponse> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'FriendshipState(friends: $friends, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendshipStateImpl &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_friends),
    isLoading,
    errorMessage,
  );

  /// Create a copy of FriendshipState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendshipStateImplCopyWith<_$FriendshipStateImpl> get copyWith =>
      __$$FriendshipStateImplCopyWithImpl<_$FriendshipStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FriendshipState implements FriendshipState {
  const factory _FriendshipState({
    final List<UserResponse> friends,
    final bool isLoading,
    final String? errorMessage,
  }) = _$FriendshipStateImpl;

  @override
  List<UserResponse> get friends;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of FriendshipState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendshipStateImplCopyWith<_$FriendshipStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
