import 'package:flutter/material.dart';

import '../../data/models/photo_models.dart';
import '../../data/repositories/photo_repository_impl.dart';
import '../../domain/repositories/photo_repository.dart';
import '../../domain/usecases/fetch_feed_photos_usecase.dart';
import '../../domain/usecases/fetch_my_photos_usecase.dart';

enum PhotoFilter { all, me }

class HomeFeedViewModel extends ChangeNotifier {
  HomeFeedViewModel({PhotoRepository? repository})
      : _repository = repository ?? PhotoRepositoryImpl() {
    _fetchFeedPhotosUseCase = FetchFeedPhotosUseCase(_repository);
    _fetchMyPhotosUseCase = FetchMyPhotosUseCase(_repository);
  }

  final PhotoRepository _repository;
  late final FetchFeedPhotosUseCase _fetchFeedPhotosUseCase;
  late final FetchMyPhotosUseCase _fetchMyPhotosUseCase;

  List<PhotoResponse> _photos = [];
  bool _isLoading = false;
  PhotoFilter _currentFilter = PhotoFilter.all;
  String? _errorMessage;

  int _currentPage = 0;
  bool _hasMore = true;

  List<PhotoResponse> get photos => _photos;
  bool get isLoading => _isLoading;
  PhotoFilter get currentFilter => _currentFilter;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  Future<void> fetchPhotos({PhotoFilter? filter, bool refresh = true}) async {
    if (filter != null) {
      _currentFilter = filter;
    }

    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      _photos = [];
    }

    if (!_hasMore && !refresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_currentFilter == PhotoFilter.all) {
        final results = await Future.wait([
          _fetchFeedPhotosUseCase.call(page: _currentPage),
          _fetchMyPhotosUseCase.call(page: _currentPage),
        ]);

        final feedSlice = results[0] as SliceResponse<PhotoResponse>;
        final myPhotosPage = results[1] as PageResponse<PhotoResponse>;

        final fetchedItems = [...feedSlice.content, ...myPhotosPage.content];
        if (refresh) {
          _photos = fetchedItems;
        } else {
          _photos.addAll(fetchedItems);
        }

        _hasMore = !feedSlice.last || !myPhotosPage.last;
        if (_hasMore) {
          _currentPage++;
        }

        final uniqueMap = <String, PhotoResponse>{};
        for (final photo in _photos) {
          uniqueMap[photo.id] = photo;
        }

        _photos = uniqueMap.values.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        final pageResponse = await _fetchMyPhotosUseCase.call(page: _currentPage);

        if (refresh) {
          _photos = pageResponse.content;
        } else {
          _photos.addAll(pageResponse.content);
        }

        _hasMore = !pageResponse.last;
        if (_hasMore) {
          _currentPage++;
        }

        _photos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setFilter(PhotoFilter filter) {
    if (_currentFilter != filter) {
      _currentFilter = filter;
      fetchPhotos(refresh: true);
    }
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    await fetchPhotos(refresh: false);
  }
}

