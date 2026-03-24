// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_invite_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FriendInviteLinkCreateRequest _$FriendInviteLinkCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _FriendInviteLinkCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$FriendInviteLinkCreateRequest {
  int? get ttlMinutes => throw _privateConstructorUsedError;

  /// Serializes this FriendInviteLinkCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendInviteLinkCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendInviteLinkCreateRequestCopyWith<FriendInviteLinkCreateRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendInviteLinkCreateRequestCopyWith<$Res> {
  factory $FriendInviteLinkCreateRequestCopyWith(
    FriendInviteLinkCreateRequest value,
    $Res Function(FriendInviteLinkCreateRequest) then,
  ) =
      _$FriendInviteLinkCreateRequestCopyWithImpl<
        $Res,
        FriendInviteLinkCreateRequest
      >;
  @useResult
  $Res call({int? ttlMinutes});
}

/// @nodoc
class _$FriendInviteLinkCreateRequestCopyWithImpl<
  $Res,
  $Val extends FriendInviteLinkCreateRequest
>
    implements $FriendInviteLinkCreateRequestCopyWith<$Res> {
  _$FriendInviteLinkCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendInviteLinkCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ttlMinutes = freezed}) {
    return _then(
      _value.copyWith(
            ttlMinutes: freezed == ttlMinutes
                ? _value.ttlMinutes
                : ttlMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendInviteLinkCreateRequestImplCopyWith<$Res>
    implements $FriendInviteLinkCreateRequestCopyWith<$Res> {
  factory _$$FriendInviteLinkCreateRequestImplCopyWith(
    _$FriendInviteLinkCreateRequestImpl value,
    $Res Function(_$FriendInviteLinkCreateRequestImpl) then,
  ) = __$$FriendInviteLinkCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? ttlMinutes});
}

/// @nodoc
class __$$FriendInviteLinkCreateRequestImplCopyWithImpl<$Res>
    extends
        _$FriendInviteLinkCreateRequestCopyWithImpl<
          $Res,
          _$FriendInviteLinkCreateRequestImpl
        >
    implements _$$FriendInviteLinkCreateRequestImplCopyWith<$Res> {
  __$$FriendInviteLinkCreateRequestImplCopyWithImpl(
    _$FriendInviteLinkCreateRequestImpl _value,
    $Res Function(_$FriendInviteLinkCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendInviteLinkCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ttlMinutes = freezed}) {
    return _then(
      _$FriendInviteLinkCreateRequestImpl(
        ttlMinutes: freezed == ttlMinutes
            ? _value.ttlMinutes
            : ttlMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendInviteLinkCreateRequestImpl
    implements _FriendInviteLinkCreateRequest {
  const _$FriendInviteLinkCreateRequestImpl({this.ttlMinutes});

  factory _$FriendInviteLinkCreateRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$FriendInviteLinkCreateRequestImplFromJson(json);

  @override
  final int? ttlMinutes;

  @override
  String toString() {
    return 'FriendInviteLinkCreateRequest(ttlMinutes: $ttlMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendInviteLinkCreateRequestImpl &&
            (identical(other.ttlMinutes, ttlMinutes) ||
                other.ttlMinutes == ttlMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ttlMinutes);

  /// Create a copy of FriendInviteLinkCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendInviteLinkCreateRequestImplCopyWith<
    _$FriendInviteLinkCreateRequestImpl
  >
  get copyWith =>
      __$$FriendInviteLinkCreateRequestImplCopyWithImpl<
        _$FriendInviteLinkCreateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendInviteLinkCreateRequestImplToJson(this);
  }
}

abstract class _FriendInviteLinkCreateRequest
    implements FriendInviteLinkCreateRequest {
  const factory _FriendInviteLinkCreateRequest({final int? ttlMinutes}) =
      _$FriendInviteLinkCreateRequestImpl;

  factory _FriendInviteLinkCreateRequest.fromJson(Map<String, dynamic> json) =
      _$FriendInviteLinkCreateRequestImpl.fromJson;

  @override
  int? get ttlMinutes;

  /// Create a copy of FriendInviteLinkCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendInviteLinkCreateRequestImplCopyWith<
    _$FriendInviteLinkCreateRequestImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

FriendInviteLinkResponse _$FriendInviteLinkResponseFromJson(
  Map<String, dynamic> json,
) {
  return _FriendInviteLinkResponse.fromJson(json);
}

/// @nodoc
mixin _$FriendInviteLinkResponse {
  String get id => throw _privateConstructorUsedError;
  String get inviteUrl => throw _privateConstructorUsedError;
  String get tokenPreview => throw _privateConstructorUsedError;
  int get maxUses => throw _privateConstructorUsedError;
  int get usedCount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullableDateTimeFromJson)
  DateTime? get revokedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this FriendInviteLinkResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendInviteLinkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendInviteLinkResponseCopyWith<FriendInviteLinkResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendInviteLinkResponseCopyWith<$Res> {
  factory $FriendInviteLinkResponseCopyWith(
    FriendInviteLinkResponse value,
    $Res Function(FriendInviteLinkResponse) then,
  ) = _$FriendInviteLinkResponseCopyWithImpl<$Res, FriendInviteLinkResponse>;
  @useResult
  $Res call({
    String id,
    String inviteUrl,
    String tokenPreview,
    int maxUses,
    int usedCount,
    @JsonKey(fromJson: _dateTimeFromJson) DateTime expiresAt,
    @JsonKey(fromJson: _nullableDateTimeFromJson) DateTime? revokedAt,
    String status,
  });
}

/// @nodoc
class _$FriendInviteLinkResponseCopyWithImpl<
  $Res,
  $Val extends FriendInviteLinkResponse
>
    implements $FriendInviteLinkResponseCopyWith<$Res> {
  _$FriendInviteLinkResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendInviteLinkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inviteUrl = null,
    Object? tokenPreview = null,
    Object? maxUses = null,
    Object? usedCount = null,
    Object? expiresAt = null,
    Object? revokedAt = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            inviteUrl: null == inviteUrl
                ? _value.inviteUrl
                : inviteUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenPreview: null == tokenPreview
                ? _value.tokenPreview
                : tokenPreview // ignore: cast_nullable_to_non_nullable
                      as String,
            maxUses: null == maxUses
                ? _value.maxUses
                : maxUses // ignore: cast_nullable_to_non_nullable
                      as int,
            usedCount: null == usedCount
                ? _value.usedCount
                : usedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            revokedAt: freezed == revokedAt
                ? _value.revokedAt
                : revokedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendInviteLinkResponseImplCopyWith<$Res>
    implements $FriendInviteLinkResponseCopyWith<$Res> {
  factory _$$FriendInviteLinkResponseImplCopyWith(
    _$FriendInviteLinkResponseImpl value,
    $Res Function(_$FriendInviteLinkResponseImpl) then,
  ) = __$$FriendInviteLinkResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String inviteUrl,
    String tokenPreview,
    int maxUses,
    int usedCount,
    @JsonKey(fromJson: _dateTimeFromJson) DateTime expiresAt,
    @JsonKey(fromJson: _nullableDateTimeFromJson) DateTime? revokedAt,
    String status,
  });
}

/// @nodoc
class __$$FriendInviteLinkResponseImplCopyWithImpl<$Res>
    extends
        _$FriendInviteLinkResponseCopyWithImpl<
          $Res,
          _$FriendInviteLinkResponseImpl
        >
    implements _$$FriendInviteLinkResponseImplCopyWith<$Res> {
  __$$FriendInviteLinkResponseImplCopyWithImpl(
    _$FriendInviteLinkResponseImpl _value,
    $Res Function(_$FriendInviteLinkResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendInviteLinkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inviteUrl = null,
    Object? tokenPreview = null,
    Object? maxUses = null,
    Object? usedCount = null,
    Object? expiresAt = null,
    Object? revokedAt = freezed,
    Object? status = null,
  }) {
    return _then(
      _$FriendInviteLinkResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        inviteUrl: null == inviteUrl
            ? _value.inviteUrl
            : inviteUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenPreview: null == tokenPreview
            ? _value.tokenPreview
            : tokenPreview // ignore: cast_nullable_to_non_nullable
                  as String,
        maxUses: null == maxUses
            ? _value.maxUses
            : maxUses // ignore: cast_nullable_to_non_nullable
                  as int,
        usedCount: null == usedCount
            ? _value.usedCount
            : usedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        revokedAt: freezed == revokedAt
            ? _value.revokedAt
            : revokedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendInviteLinkResponseImpl implements _FriendInviteLinkResponse {
  const _$FriendInviteLinkResponseImpl({
    required this.id,
    required this.inviteUrl,
    required this.tokenPreview,
    required this.maxUses,
    required this.usedCount,
    @JsonKey(fromJson: _dateTimeFromJson) required this.expiresAt,
    @JsonKey(fromJson: _nullableDateTimeFromJson) this.revokedAt,
    required this.status,
  });

  factory _$FriendInviteLinkResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendInviteLinkResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String inviteUrl;
  @override
  final String tokenPreview;
  @override
  final int maxUses;
  @override
  final int usedCount;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime expiresAt;
  @override
  @JsonKey(fromJson: _nullableDateTimeFromJson)
  final DateTime? revokedAt;
  @override
  final String status;

  @override
  String toString() {
    return 'FriendInviteLinkResponse(id: $id, inviteUrl: $inviteUrl, tokenPreview: $tokenPreview, maxUses: $maxUses, usedCount: $usedCount, expiresAt: $expiresAt, revokedAt: $revokedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendInviteLinkResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inviteUrl, inviteUrl) ||
                other.inviteUrl == inviteUrl) &&
            (identical(other.tokenPreview, tokenPreview) ||
                other.tokenPreview == tokenPreview) &&
            (identical(other.maxUses, maxUses) || other.maxUses == maxUses) &&
            (identical(other.usedCount, usedCount) ||
                other.usedCount == usedCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.revokedAt, revokedAt) ||
                other.revokedAt == revokedAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    inviteUrl,
    tokenPreview,
    maxUses,
    usedCount,
    expiresAt,
    revokedAt,
    status,
  );

  /// Create a copy of FriendInviteLinkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendInviteLinkResponseImplCopyWith<_$FriendInviteLinkResponseImpl>
  get copyWith =>
      __$$FriendInviteLinkResponseImplCopyWithImpl<
        _$FriendInviteLinkResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendInviteLinkResponseImplToJson(this);
  }
}

abstract class _FriendInviteLinkResponse implements FriendInviteLinkResponse {
  const factory _FriendInviteLinkResponse({
    required final String id,
    required final String inviteUrl,
    required final String tokenPreview,
    required final int maxUses,
    required final int usedCount,
    @JsonKey(fromJson: _dateTimeFromJson) required final DateTime expiresAt,
    @JsonKey(fromJson: _nullableDateTimeFromJson) final DateTime? revokedAt,
    required final String status,
  }) = _$FriendInviteLinkResponseImpl;

  factory _FriendInviteLinkResponse.fromJson(Map<String, dynamic> json) =
      _$FriendInviteLinkResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get inviteUrl;
  @override
  String get tokenPreview;
  @override
  int get maxUses;
  @override
  int get usedCount;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get expiresAt;
  @override
  @JsonKey(fromJson: _nullableDateTimeFromJson)
  DateTime? get revokedAt;
  @override
  String get status;

  /// Create a copy of FriendInviteLinkResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendInviteLinkResponseImplCopyWith<_$FriendInviteLinkResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FriendInviteAcceptRequest _$FriendInviteAcceptRequestFromJson(
  Map<String, dynamic> json,
) {
  return _FriendInviteAcceptRequest.fromJson(json);
}

/// @nodoc
mixin _$FriendInviteAcceptRequest {
  String get token => throw _privateConstructorUsedError;

  /// Serializes this FriendInviteAcceptRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendInviteAcceptRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendInviteAcceptRequestCopyWith<FriendInviteAcceptRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendInviteAcceptRequestCopyWith<$Res> {
  factory $FriendInviteAcceptRequestCopyWith(
    FriendInviteAcceptRequest value,
    $Res Function(FriendInviteAcceptRequest) then,
  ) = _$FriendInviteAcceptRequestCopyWithImpl<$Res, FriendInviteAcceptRequest>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$FriendInviteAcceptRequestCopyWithImpl<
  $Res,
  $Val extends FriendInviteAcceptRequest
>
    implements $FriendInviteAcceptRequestCopyWith<$Res> {
  _$FriendInviteAcceptRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendInviteAcceptRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null}) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendInviteAcceptRequestImplCopyWith<$Res>
    implements $FriendInviteAcceptRequestCopyWith<$Res> {
  factory _$$FriendInviteAcceptRequestImplCopyWith(
    _$FriendInviteAcceptRequestImpl value,
    $Res Function(_$FriendInviteAcceptRequestImpl) then,
  ) = __$$FriendInviteAcceptRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$FriendInviteAcceptRequestImplCopyWithImpl<$Res>
    extends
        _$FriendInviteAcceptRequestCopyWithImpl<
          $Res,
          _$FriendInviteAcceptRequestImpl
        >
    implements _$$FriendInviteAcceptRequestImplCopyWith<$Res> {
  __$$FriendInviteAcceptRequestImplCopyWithImpl(
    _$FriendInviteAcceptRequestImpl _value,
    $Res Function(_$FriendInviteAcceptRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendInviteAcceptRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null}) {
    return _then(
      _$FriendInviteAcceptRequestImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendInviteAcceptRequestImpl implements _FriendInviteAcceptRequest {
  const _$FriendInviteAcceptRequestImpl({required this.token});

  factory _$FriendInviteAcceptRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendInviteAcceptRequestImplFromJson(json);

  @override
  final String token;

  @override
  String toString() {
    return 'FriendInviteAcceptRequest(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendInviteAcceptRequestImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of FriendInviteAcceptRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendInviteAcceptRequestImplCopyWith<_$FriendInviteAcceptRequestImpl>
  get copyWith =>
      __$$FriendInviteAcceptRequestImplCopyWithImpl<
        _$FriendInviteAcceptRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendInviteAcceptRequestImplToJson(this);
  }
}

abstract class _FriendInviteAcceptRequest implements FriendInviteAcceptRequest {
  const factory _FriendInviteAcceptRequest({required final String token}) =
      _$FriendInviteAcceptRequestImpl;

  factory _FriendInviteAcceptRequest.fromJson(Map<String, dynamic> json) =
      _$FriendInviteAcceptRequestImpl.fromJson;

  @override
  String get token;

  /// Create a copy of FriendInviteAcceptRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendInviteAcceptRequestImplCopyWith<_$FriendInviteAcceptRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FriendInviteAcceptResponse _$FriendInviteAcceptResponseFromJson(
  Map<String, dynamic> json,
) {
  return _FriendInviteAcceptResponse.fromJson(json);
}

/// @nodoc
mixin _$FriendInviteAcceptResponse {
  String get friendshipId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  UserResponse get friend => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get acceptedAt => throw _privateConstructorUsedError;

  /// Serializes this FriendInviteAcceptResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendInviteAcceptResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendInviteAcceptResponseCopyWith<FriendInviteAcceptResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendInviteAcceptResponseCopyWith<$Res> {
  factory $FriendInviteAcceptResponseCopyWith(
    FriendInviteAcceptResponse value,
    $Res Function(FriendInviteAcceptResponse) then,
  ) =
      _$FriendInviteAcceptResponseCopyWithImpl<
        $Res,
        FriendInviteAcceptResponse
      >;
  @useResult
  $Res call({
    String friendshipId,
    String status,
    UserResponse friend,
    @JsonKey(fromJson: _dateTimeFromJson) DateTime acceptedAt,
  });

  $UserResponseCopyWith<$Res> get friend;
}

/// @nodoc
class _$FriendInviteAcceptResponseCopyWithImpl<
  $Res,
  $Val extends FriendInviteAcceptResponse
>
    implements $FriendInviteAcceptResponseCopyWith<$Res> {
  _$FriendInviteAcceptResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendInviteAcceptResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendshipId = null,
    Object? status = null,
    Object? friend = null,
    Object? acceptedAt = null,
  }) {
    return _then(
      _value.copyWith(
            friendshipId: null == friendshipId
                ? _value.friendshipId
                : friendshipId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            friend: null == friend
                ? _value.friend
                : friend // ignore: cast_nullable_to_non_nullable
                      as UserResponse,
            acceptedAt: null == acceptedAt
                ? _value.acceptedAt
                : acceptedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendInviteAcceptResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserResponseCopyWith<$Res> get friend {
    return $UserResponseCopyWith<$Res>(_value.friend, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendInviteAcceptResponseImplCopyWith<$Res>
    implements $FriendInviteAcceptResponseCopyWith<$Res> {
  factory _$$FriendInviteAcceptResponseImplCopyWith(
    _$FriendInviteAcceptResponseImpl value,
    $Res Function(_$FriendInviteAcceptResponseImpl) then,
  ) = __$$FriendInviteAcceptResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String friendshipId,
    String status,
    UserResponse friend,
    @JsonKey(fromJson: _dateTimeFromJson) DateTime acceptedAt,
  });

  @override
  $UserResponseCopyWith<$Res> get friend;
}

/// @nodoc
class __$$FriendInviteAcceptResponseImplCopyWithImpl<$Res>
    extends
        _$FriendInviteAcceptResponseCopyWithImpl<
          $Res,
          _$FriendInviteAcceptResponseImpl
        >
    implements _$$FriendInviteAcceptResponseImplCopyWith<$Res> {
  __$$FriendInviteAcceptResponseImplCopyWithImpl(
    _$FriendInviteAcceptResponseImpl _value,
    $Res Function(_$FriendInviteAcceptResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendInviteAcceptResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendshipId = null,
    Object? status = null,
    Object? friend = null,
    Object? acceptedAt = null,
  }) {
    return _then(
      _$FriendInviteAcceptResponseImpl(
        friendshipId: null == friendshipId
            ? _value.friendshipId
            : friendshipId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        friend: null == friend
            ? _value.friend
            : friend // ignore: cast_nullable_to_non_nullable
                  as UserResponse,
        acceptedAt: null == acceptedAt
            ? _value.acceptedAt
            : acceptedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendInviteAcceptResponseImpl implements _FriendInviteAcceptResponse {
  const _$FriendInviteAcceptResponseImpl({
    required this.friendshipId,
    required this.status,
    required this.friend,
    @JsonKey(fromJson: _dateTimeFromJson) required this.acceptedAt,
  });

  factory _$FriendInviteAcceptResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$FriendInviteAcceptResponseImplFromJson(json);

  @override
  final String friendshipId;
  @override
  final String status;
  @override
  final UserResponse friend;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime acceptedAt;

  @override
  String toString() {
    return 'FriendInviteAcceptResponse(friendshipId: $friendshipId, status: $status, friend: $friend, acceptedAt: $acceptedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendInviteAcceptResponseImpl &&
            (identical(other.friendshipId, friendshipId) ||
                other.friendshipId == friendshipId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.friend, friend) || other.friend == friend) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, friendshipId, status, friend, acceptedAt);

  /// Create a copy of FriendInviteAcceptResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendInviteAcceptResponseImplCopyWith<_$FriendInviteAcceptResponseImpl>
  get copyWith =>
      __$$FriendInviteAcceptResponseImplCopyWithImpl<
        _$FriendInviteAcceptResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendInviteAcceptResponseImplToJson(this);
  }
}

abstract class _FriendInviteAcceptResponse
    implements FriendInviteAcceptResponse {
  const factory _FriendInviteAcceptResponse({
    required final String friendshipId,
    required final String status,
    required final UserResponse friend,
    @JsonKey(fromJson: _dateTimeFromJson) required final DateTime acceptedAt,
  }) = _$FriendInviteAcceptResponseImpl;

  factory _FriendInviteAcceptResponse.fromJson(Map<String, dynamic> json) =
      _$FriendInviteAcceptResponseImpl.fromJson;

  @override
  String get friendshipId;
  @override
  String get status;
  @override
  UserResponse get friend;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get acceptedAt;

  /// Create a copy of FriendInviteAcceptResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendInviteAcceptResponseImplCopyWith<_$FriendInviteAcceptResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
