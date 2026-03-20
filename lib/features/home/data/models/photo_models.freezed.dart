// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PhotoResponse _$PhotoResponseFromJson(Map<String, dynamic> json) {
  return _PhotoResponse.fromJson(json);
}

/// @nodoc
mixin _$PhotoResponse {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderDisplayName => throw _privateConstructorUsedError;
  String? get senderAvatarUrl => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  String get recipientScope => throw _privateConstructorUsedError;
  int get recipientCount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  DateTime get takenAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PhotoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoResponseCopyWith<PhotoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoResponseCopyWith<$Res> {
  factory $PhotoResponseCopyWith(
    PhotoResponse value,
    $Res Function(PhotoResponse) then,
  ) = _$PhotoResponseCopyWithImpl<$Res, PhotoResponse>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderDisplayName,
    String? senderAvatarUrl,
    String imageUrl,
    String thumbnailUrl,
    String? caption,
    double? amount,
    String recipientScope,
    int recipientCount,
    String status,
    String mimeType,
    int fileSize,
    int width,
    int height,
    DateTime takenAt,
    DateTime createdAt,
  });
}

/// @nodoc
class _$PhotoResponseCopyWithImpl<$Res, $Val extends PhotoResponse>
    implements $PhotoResponseCopyWith<$Res> {
  _$PhotoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderDisplayName = null,
    Object? senderAvatarUrl = freezed,
    Object? imageUrl = null,
    Object? thumbnailUrl = null,
    Object? caption = freezed,
    Object? amount = freezed,
    Object? recipientScope = null,
    Object? recipientCount = null,
    Object? status = null,
    Object? mimeType = null,
    Object? fileSize = null,
    Object? width = null,
    Object? height = null,
    Object? takenAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderDisplayName: null == senderDisplayName
                ? _value.senderDisplayName
                : senderDisplayName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderAvatarUrl: freezed == senderAvatarUrl
                ? _value.senderAvatarUrl
                : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: null == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            caption: freezed == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double?,
            recipientScope: null == recipientScope
                ? _value.recipientScope
                : recipientScope // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientCount: null == recipientCount
                ? _value.recipientCount
                : recipientCount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            mimeType: null == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSize: null == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int,
            takenAt: null == takenAt
                ? _value.takenAt
                : takenAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoResponseImplCopyWith<$Res>
    implements $PhotoResponseCopyWith<$Res> {
  factory _$$PhotoResponseImplCopyWith(
    _$PhotoResponseImpl value,
    $Res Function(_$PhotoResponseImpl) then,
  ) = __$$PhotoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderDisplayName,
    String? senderAvatarUrl,
    String imageUrl,
    String thumbnailUrl,
    String? caption,
    double? amount,
    String recipientScope,
    int recipientCount,
    String status,
    String mimeType,
    int fileSize,
    int width,
    int height,
    DateTime takenAt,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$PhotoResponseImplCopyWithImpl<$Res>
    extends _$PhotoResponseCopyWithImpl<$Res, _$PhotoResponseImpl>
    implements _$$PhotoResponseImplCopyWith<$Res> {
  __$$PhotoResponseImplCopyWithImpl(
    _$PhotoResponseImpl _value,
    $Res Function(_$PhotoResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderDisplayName = null,
    Object? senderAvatarUrl = freezed,
    Object? imageUrl = null,
    Object? thumbnailUrl = null,
    Object? caption = freezed,
    Object? amount = freezed,
    Object? recipientScope = null,
    Object? recipientCount = null,
    Object? status = null,
    Object? mimeType = null,
    Object? fileSize = null,
    Object? width = null,
    Object? height = null,
    Object? takenAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$PhotoResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderDisplayName: null == senderDisplayName
            ? _value.senderDisplayName
            : senderDisplayName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderAvatarUrl: freezed == senderAvatarUrl
            ? _value.senderAvatarUrl
            : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: null == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double?,
        recipientScope: null == recipientScope
            ? _value.recipientScope
            : recipientScope // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientCount: null == recipientCount
            ? _value.recipientCount
            : recipientCount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        mimeType: null == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSize: null == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
        takenAt: null == takenAt
            ? _value.takenAt
            : takenAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoResponseImpl implements _PhotoResponse {
  const _$PhotoResponseImpl({
    required this.id,
    required this.senderId,
    required this.senderDisplayName,
    this.senderAvatarUrl,
    required this.imageUrl,
    required this.thumbnailUrl,
    this.caption,
    this.amount,
    required this.recipientScope,
    required this.recipientCount,
    required this.status,
    required this.mimeType,
    required this.fileSize,
    required this.width,
    required this.height,
    required this.takenAt,
    required this.createdAt,
  });

  factory _$PhotoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String senderDisplayName;
  @override
  final String? senderAvatarUrl;
  @override
  final String imageUrl;
  @override
  final String thumbnailUrl;
  @override
  final String? caption;
  @override
  final double? amount;
  @override
  final String recipientScope;
  @override
  final int recipientCount;
  @override
  final String status;
  @override
  final String mimeType;
  @override
  final int fileSize;
  @override
  final int width;
  @override
  final int height;
  @override
  final DateTime takenAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PhotoResponse(id: $id, senderId: $senderId, senderDisplayName: $senderDisplayName, senderAvatarUrl: $senderAvatarUrl, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, caption: $caption, amount: $amount, recipientScope: $recipientScope, recipientCount: $recipientCount, status: $status, mimeType: $mimeType, fileSize: $fileSize, width: $width, height: $height, takenAt: $takenAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderDisplayName, senderDisplayName) ||
                other.senderDisplayName == senderDisplayName) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.recipientScope, recipientScope) ||
                other.recipientScope == recipientScope) &&
            (identical(other.recipientCount, recipientCount) ||
                other.recipientCount == recipientCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.takenAt, takenAt) || other.takenAt == takenAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    senderDisplayName,
    senderAvatarUrl,
    imageUrl,
    thumbnailUrl,
    caption,
    amount,
    recipientScope,
    recipientCount,
    status,
    mimeType,
    fileSize,
    width,
    height,
    takenAt,
    createdAt,
  );

  /// Create a copy of PhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoResponseImplCopyWith<_$PhotoResponseImpl> get copyWith =>
      __$$PhotoResponseImplCopyWithImpl<_$PhotoResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoResponseImplToJson(this);
  }
}

abstract class _PhotoResponse implements PhotoResponse {
  const factory _PhotoResponse({
    required final String id,
    required final String senderId,
    required final String senderDisplayName,
    final String? senderAvatarUrl,
    required final String imageUrl,
    required final String thumbnailUrl,
    final String? caption,
    final double? amount,
    required final String recipientScope,
    required final int recipientCount,
    required final String status,
    required final String mimeType,
    required final int fileSize,
    required final int width,
    required final int height,
    required final DateTime takenAt,
    required final DateTime createdAt,
  }) = _$PhotoResponseImpl;

  factory _PhotoResponse.fromJson(Map<String, dynamic> json) =
      _$PhotoResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get senderDisplayName;
  @override
  String? get senderAvatarUrl;
  @override
  String get imageUrl;
  @override
  String get thumbnailUrl;
  @override
  String? get caption;
  @override
  double? get amount;
  @override
  String get recipientScope;
  @override
  int get recipientCount;
  @override
  String get status;
  @override
  String get mimeType;
  @override
  int get fileSize;
  @override
  int get width;
  @override
  int get height;
  @override
  DateTime get takenAt;
  @override
  DateTime get createdAt;

  /// Create a copy of PhotoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoResponseImplCopyWith<_$PhotoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SliceResponse<T> _$SliceResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _SliceResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$SliceResponse<T> {
  List<T> get content => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  bool get first => throw _privateConstructorUsedError;
  bool get last => throw _privateConstructorUsedError;
  int get numberOfElements => throw _privateConstructorUsedError;
  bool get empty => throw _privateConstructorUsedError;

  /// Serializes this SliceResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SliceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SliceResponseCopyWith<T, SliceResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliceResponseCopyWith<T, $Res> {
  factory $SliceResponseCopyWith(
    SliceResponse<T> value,
    $Res Function(SliceResponse<T>) then,
  ) = _$SliceResponseCopyWithImpl<T, $Res, SliceResponse<T>>;
  @useResult
  $Res call({
    List<T> content,
    int number,
    int size,
    bool first,
    bool last,
    int numberOfElements,
    bool empty,
  });
}

/// @nodoc
class _$SliceResponseCopyWithImpl<T, $Res, $Val extends SliceResponse<T>>
    implements $SliceResponseCopyWith<T, $Res> {
  _$SliceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SliceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? number = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
    Object? numberOfElements = null,
    Object? empty = null,
  }) {
    return _then(
      _value.copyWith(
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            first: null == first
                ? _value.first
                : first // ignore: cast_nullable_to_non_nullable
                      as bool,
            last: null == last
                ? _value.last
                : last // ignore: cast_nullable_to_non_nullable
                      as bool,
            numberOfElements: null == numberOfElements
                ? _value.numberOfElements
                : numberOfElements // ignore: cast_nullable_to_non_nullable
                      as int,
            empty: null == empty
                ? _value.empty
                : empty // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SliceResponseImplCopyWith<T, $Res>
    implements $SliceResponseCopyWith<T, $Res> {
  factory _$$SliceResponseImplCopyWith(
    _$SliceResponseImpl<T> value,
    $Res Function(_$SliceResponseImpl<T>) then,
  ) = __$$SliceResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    List<T> content,
    int number,
    int size,
    bool first,
    bool last,
    int numberOfElements,
    bool empty,
  });
}

/// @nodoc
class __$$SliceResponseImplCopyWithImpl<T, $Res>
    extends _$SliceResponseCopyWithImpl<T, $Res, _$SliceResponseImpl<T>>
    implements _$$SliceResponseImplCopyWith<T, $Res> {
  __$$SliceResponseImplCopyWithImpl(
    _$SliceResponseImpl<T> _value,
    $Res Function(_$SliceResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of SliceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? number = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
    Object? numberOfElements = null,
    Object? empty = null,
  }) {
    return _then(
      _$SliceResponseImpl<T>(
        content: null == content
            ? _value._content
            : content // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        first: null == first
            ? _value.first
            : first // ignore: cast_nullable_to_non_nullable
                  as bool,
        last: null == last
            ? _value.last
            : last // ignore: cast_nullable_to_non_nullable
                  as bool,
        numberOfElements: null == numberOfElements
            ? _value.numberOfElements
            : numberOfElements // ignore: cast_nullable_to_non_nullable
                  as int,
        empty: null == empty
            ? _value.empty
            : empty // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$SliceResponseImpl<T> implements _SliceResponse<T> {
  const _$SliceResponseImpl({
    required final List<T> content,
    required this.number,
    required this.size,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.empty,
  }) : _content = content;

  factory _$SliceResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$SliceResponseImplFromJson(json, fromJsonT);

  final List<T> _content;
  @override
  List<T> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  final int number;
  @override
  final int size;
  @override
  final bool first;
  @override
  final bool last;
  @override
  final int numberOfElements;
  @override
  final bool empty;

  @override
  String toString() {
    return 'SliceResponse<$T>(content: $content, number: $number, size: $size, first: $first, last: $last, numberOfElements: $numberOfElements, empty: $empty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SliceResponseImpl<T> &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.last, last) || other.last == last) &&
            (identical(other.numberOfElements, numberOfElements) ||
                other.numberOfElements == numberOfElements) &&
            (identical(other.empty, empty) || other.empty == empty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_content),
    number,
    size,
    first,
    last,
    numberOfElements,
    empty,
  );

  /// Create a copy of SliceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SliceResponseImplCopyWith<T, _$SliceResponseImpl<T>> get copyWith =>
      __$$SliceResponseImplCopyWithImpl<T, _$SliceResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$SliceResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _SliceResponse<T> implements SliceResponse<T> {
  const factory _SliceResponse({
    required final List<T> content,
    required final int number,
    required final int size,
    required final bool first,
    required final bool last,
    required final int numberOfElements,
    required final bool empty,
  }) = _$SliceResponseImpl<T>;

  factory _SliceResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$SliceResponseImpl<T>.fromJson;

  @override
  List<T> get content;
  @override
  int get number;
  @override
  int get size;
  @override
  bool get first;
  @override
  bool get last;
  @override
  int get numberOfElements;
  @override
  bool get empty;

  /// Create a copy of SliceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SliceResponseImplCopyWith<T, _$SliceResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

PageResponse<T> _$PageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _PageResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PageResponse<T> {
  List<T> get content => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  bool get first => throw _privateConstructorUsedError;
  bool get last => throw _privateConstructorUsedError;
  int get numberOfElements => throw _privateConstructorUsedError;
  bool get empty => throw _privateConstructorUsedError;
  int get totalElements => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this PageResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageResponseCopyWith<T, PageResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageResponseCopyWith<T, $Res> {
  factory $PageResponseCopyWith(
    PageResponse<T> value,
    $Res Function(PageResponse<T>) then,
  ) = _$PageResponseCopyWithImpl<T, $Res, PageResponse<T>>;
  @useResult
  $Res call({
    List<T> content,
    int number,
    int size,
    bool first,
    bool last,
    int numberOfElements,
    bool empty,
    int totalElements,
    int totalPages,
  });
}

/// @nodoc
class _$PageResponseCopyWithImpl<T, $Res, $Val extends PageResponse<T>>
    implements $PageResponseCopyWith<T, $Res> {
  _$PageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? number = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
    Object? numberOfElements = null,
    Object? empty = null,
    Object? totalElements = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            first: null == first
                ? _value.first
                : first // ignore: cast_nullable_to_non_nullable
                      as bool,
            last: null == last
                ? _value.last
                : last // ignore: cast_nullable_to_non_nullable
                      as bool,
            numberOfElements: null == numberOfElements
                ? _value.numberOfElements
                : numberOfElements // ignore: cast_nullable_to_non_nullable
                      as int,
            empty: null == empty
                ? _value.empty
                : empty // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalElements: null == totalElements
                ? _value.totalElements
                : totalElements // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageResponseImplCopyWith<T, $Res>
    implements $PageResponseCopyWith<T, $Res> {
  factory _$$PageResponseImplCopyWith(
    _$PageResponseImpl<T> value,
    $Res Function(_$PageResponseImpl<T>) then,
  ) = __$$PageResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    List<T> content,
    int number,
    int size,
    bool first,
    bool last,
    int numberOfElements,
    bool empty,
    int totalElements,
    int totalPages,
  });
}

/// @nodoc
class __$$PageResponseImplCopyWithImpl<T, $Res>
    extends _$PageResponseCopyWithImpl<T, $Res, _$PageResponseImpl<T>>
    implements _$$PageResponseImplCopyWith<T, $Res> {
  __$$PageResponseImplCopyWithImpl(
    _$PageResponseImpl<T> _value,
    $Res Function(_$PageResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? number = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
    Object? numberOfElements = null,
    Object? empty = null,
    Object? totalElements = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$PageResponseImpl<T>(
        content: null == content
            ? _value._content
            : content // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        first: null == first
            ? _value.first
            : first // ignore: cast_nullable_to_non_nullable
                  as bool,
        last: null == last
            ? _value.last
            : last // ignore: cast_nullable_to_non_nullable
                  as bool,
        numberOfElements: null == numberOfElements
            ? _value.numberOfElements
            : numberOfElements // ignore: cast_nullable_to_non_nullable
                  as int,
        empty: null == empty
            ? _value.empty
            : empty // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalElements: null == totalElements
            ? _value.totalElements
            : totalElements // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PageResponseImpl<T> implements _PageResponse<T> {
  const _$PageResponseImpl({
    required final List<T> content,
    required this.number,
    required this.size,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.empty,
    required this.totalElements,
    required this.totalPages,
  }) : _content = content;

  factory _$PageResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$PageResponseImplFromJson(json, fromJsonT);

  final List<T> _content;
  @override
  List<T> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  final int number;
  @override
  final int size;
  @override
  final bool first;
  @override
  final bool last;
  @override
  final int numberOfElements;
  @override
  final bool empty;
  @override
  final int totalElements;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'PageResponse<$T>(content: $content, number: $number, size: $size, first: $first, last: $last, numberOfElements: $numberOfElements, empty: $empty, totalElements: $totalElements, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageResponseImpl<T> &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.last, last) || other.last == last) &&
            (identical(other.numberOfElements, numberOfElements) ||
                other.numberOfElements == numberOfElements) &&
            (identical(other.empty, empty) || other.empty == empty) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_content),
    number,
    size,
    first,
    last,
    numberOfElements,
    empty,
    totalElements,
    totalPages,
  );

  /// Create a copy of PageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageResponseImplCopyWith<T, _$PageResponseImpl<T>> get copyWith =>
      __$$PageResponseImplCopyWithImpl<T, _$PageResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PageResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _PageResponse<T> implements PageResponse<T> {
  const factory _PageResponse({
    required final List<T> content,
    required final int number,
    required final int size,
    required final bool first,
    required final bool last,
    required final int numberOfElements,
    required final bool empty,
    required final int totalElements,
    required final int totalPages,
  }) = _$PageResponseImpl<T>;

  factory _PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$PageResponseImpl<T>.fromJson;

  @override
  List<T> get content;
  @override
  int get number;
  @override
  int get size;
  @override
  bool get first;
  @override
  bool get last;
  @override
  int get numberOfElements;
  @override
  bool get empty;
  @override
  int get totalElements;
  @override
  int get totalPages;

  /// Create a copy of PageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageResponseImplCopyWith<T, _$PageResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
