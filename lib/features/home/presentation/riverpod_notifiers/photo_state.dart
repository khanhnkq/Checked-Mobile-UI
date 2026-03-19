import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/photo_models.dart';

part 'photo_state.freezed.dart';

enum PhotoFilter { all, me }

@freezed
class PhotoState with _$PhotoState {
  const factory PhotoState({
    @Default([]) List<PhotoResponse> photos,
    @Default(false) bool isLoading,
    @Default(PhotoFilter.all) PhotoFilter currentFilter,
    String? errorMessage,
    @Default(0) int currentPage,
    @Default(true) bool hasMore,
  }) = _PhotoState;

  factory PhotoState.initial() => const PhotoState();
}

