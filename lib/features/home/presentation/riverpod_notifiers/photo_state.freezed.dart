// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PhotoState {
  List<PhotoResponse> get photos => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  PhotoFilter get currentFilter => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;

  /// Create a copy of PhotoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoStateCopyWith<PhotoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoStateCopyWith<$Res> {
  factory $PhotoStateCopyWith(
    PhotoState value,
    $Res Function(PhotoState) then,
  ) = _$PhotoStateCopyWithImpl<$Res, PhotoState>;
  @useResult
  $Res call({
    List<PhotoResponse> photos,
    bool isLoading,
    PhotoFilter currentFilter,
    String? errorMessage,
    int currentPage,
    bool hasMore,
  });
}

/// @nodoc
class _$PhotoStateCopyWithImpl<$Res, $Val extends PhotoState>
    implements $PhotoStateCopyWith<$Res> {
  _$PhotoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photos = null,
    Object? isLoading = null,
    Object? currentFilter = null,
    Object? errorMessage = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _value.copyWith(
            photos: null == photos
                ? _value.photos
                : photos // ignore: cast_nullable_to_non_nullable
                      as List<PhotoResponse>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentFilter: null == currentFilter
                ? _value.currentFilter
                : currentFilter // ignore: cast_nullable_to_non_nullable
                      as PhotoFilter,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoStateImplCopyWith<$Res>
    implements $PhotoStateCopyWith<$Res> {
  factory _$$PhotoStateImplCopyWith(
    _$PhotoStateImpl value,
    $Res Function(_$PhotoStateImpl) then,
  ) = __$$PhotoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PhotoResponse> photos,
    bool isLoading,
    PhotoFilter currentFilter,
    String? errorMessage,
    int currentPage,
    bool hasMore,
  });
}

/// @nodoc
class __$$PhotoStateImplCopyWithImpl<$Res>
    extends _$PhotoStateCopyWithImpl<$Res, _$PhotoStateImpl>
    implements _$$PhotoStateImplCopyWith<$Res> {
  __$$PhotoStateImplCopyWithImpl(
    _$PhotoStateImpl _value,
    $Res Function(_$PhotoStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhotoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photos = null,
    Object? isLoading = null,
    Object? currentFilter = null,
    Object? errorMessage = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$PhotoStateImpl(
        photos: null == photos
            ? _value._photos
            : photos // ignore: cast_nullable_to_non_nullable
                  as List<PhotoResponse>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentFilter: null == currentFilter
            ? _value.currentFilter
            : currentFilter // ignore: cast_nullable_to_non_nullable
                  as PhotoFilter,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PhotoStateImpl implements _PhotoState {
  const _$PhotoStateImpl({
    final List<PhotoResponse> photos = const [],
    this.isLoading = false,
    this.currentFilter = PhotoFilter.all,
    this.errorMessage,
    this.currentPage = 0,
    this.hasMore = true,
  }) : _photos = photos;

  final List<PhotoResponse> _photos;
  @override
  @JsonKey()
  List<PhotoResponse> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final PhotoFilter currentFilter;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'PhotoState(photos: $photos, isLoading: $isLoading, currentFilter: $currentFilter, errorMessage: $errorMessage, currentPage: $currentPage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoStateImpl &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentFilter, currentFilter) ||
                other.currentFilter == currentFilter) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_photos),
    isLoading,
    currentFilter,
    errorMessage,
    currentPage,
    hasMore,
  );

  /// Create a copy of PhotoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoStateImplCopyWith<_$PhotoStateImpl> get copyWith =>
      __$$PhotoStateImplCopyWithImpl<_$PhotoStateImpl>(this, _$identity);
}

abstract class _PhotoState implements PhotoState {
  const factory _PhotoState({
    final List<PhotoResponse> photos,
    final bool isLoading,
    final PhotoFilter currentFilter,
    final String? errorMessage,
    final int currentPage,
    final bool hasMore,
  }) = _$PhotoStateImpl;

  @override
  List<PhotoResponse> get photos;
  @override
  bool get isLoading;
  @override
  PhotoFilter get currentFilter;
  @override
  String? get errorMessage;
  @override
  int get currentPage;
  @override
  bool get hasMore;

  /// Create a copy of PhotoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoStateImplCopyWith<_$PhotoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
