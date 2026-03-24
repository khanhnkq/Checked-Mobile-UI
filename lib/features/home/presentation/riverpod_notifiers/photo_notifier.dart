import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/photo_models.dart';
import '../../data/repositories/photo_repository_impl.dart';
import '../../domain/repositories/photo_repository.dart';
import '../../domain/usecases/fetch_feed_photos_usecase.dart';
import '../../domain/usecases/fetch_my_photos_usecase.dart';
import 'photo_state.dart';

class PhotoNotifier extends StateNotifier<PhotoState> {
  final PhotoRepository _repository;
  late final FetchFeedPhotosUseCase _fetchFeedPhotosUseCase;
  late final FetchMyPhotosUseCase _fetchMyPhotosUseCase;

  PhotoNotifier({PhotoRepository? repository})
    : _repository = repository ?? PhotoRepositoryImpl(),
      super(PhotoState.initial()) {
    _fetchFeedPhotosUseCase = FetchFeedPhotosUseCase(_repository);
    _fetchMyPhotosUseCase = FetchMyPhotosUseCase(_repository);
  }

  Future<void> fetchPhotos({PhotoFilter? filter, bool refresh = true}) async {
    if (filter != null) {
      state = state.copyWith(currentFilter: filter);
    }

    if (refresh) {
      state = state.copyWith(currentPage: 0, hasMore: true, photos: []);
    }

    if (!state.hasMore && !refresh) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      if (state.currentFilter == PhotoFilter.all ||
          state.currentFilter == PhotoFilter.friend) {
        if (state.currentFilter == PhotoFilter.friend &&
            (state.selectedFriendId == null ||
                state.selectedFriendId!.isEmpty)) {
          state = state.copyWith(
            photos: const [],
            hasMore: false,
            currentPage: 0,
          );
          return;
        }

        final feedSlice = await _fetchFeedPhotosUseCase.call(
          page: state.currentPage,
          friendId: state.currentFilter == PhotoFilter.friend
              ? state.selectedFriendId
              : null,
        );

        final fetchedItems = [...feedSlice.content];

        List<PhotoResponse> newPhotos;
        if (refresh) {
          newPhotos = fetchedItems;
        } else {
          newPhotos = [...state.photos, ...fetchedItems];
        }

        final uniqueMap = <String, PhotoResponse>{};
        for (final photo in newPhotos) {
          uniqueMap[photo.id] = photo;
        }

        newPhotos = uniqueMap.values.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        bool newHasMore = !feedSlice.last;
        int newPage = state.currentPage;
        if (newHasMore) {
          newPage++;
        }

        state = state.copyWith(
          photos: newPhotos,
          hasMore: newHasMore,
          currentPage: newPage,
        );
      } else {
        final pageResponse = await _fetchMyPhotosUseCase.call(
          page: state.currentPage,
        );

        // pageResponse.content may be unmodifiable, so always copy before sorting.
        List<PhotoResponse> newPhotos;
        if (refresh) {
          newPhotos = [...pageResponse.content];
        } else {
          newPhotos = [...state.photos, ...pageResponse.content];
        }

        bool newHasMore = !pageResponse.last;
        int newPage = state.currentPage;
        if (newHasMore) {
          newPage++;
        }

        newPhotos.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        state = state.copyWith(
          photos: newPhotos,
          hasMore: newHasMore,
          currentPage: newPage,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadMore() async {
    await fetchPhotos(refresh: false);
  }

  void setFilter(PhotoFilter filter, {String? friendId}) {
    state = state.copyWith(
      currentFilter: filter,
      selectedFriendId: filter == PhotoFilter.friend ? friendId : null,
    );
  }

  void setAllFilter() {
    setFilter(PhotoFilter.all);
  }

  void setMyFilter() {
    setFilter(PhotoFilter.me);
  }

  void setFriendFilter(String friendId) {
    setFilter(PhotoFilter.friend, friendId: friendId);
  }
}
