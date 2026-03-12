import 'package:flutter/material.dart';
import '../../data/models/photo_models.dart';
import '../../data/services/photo_service.dart';

enum PhotoFilter { all, me }

class PhotoProvider extends ChangeNotifier {
  final PhotoService _photoService = PhotoService();
  
  List<PhotoResponse> _photos = [];
  bool _isLoading = false;
  PhotoFilter _currentFilter = PhotoFilter.all;
  String? _errorMessage;

  List<PhotoResponse> get photos => _photos;
  bool get isLoading => _isLoading;
  PhotoFilter get currentFilter => _currentFilter;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPhotos({PhotoFilter? filter}) async {
    if (filter != null) {
      _currentFilter = filter;
    }
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_currentFilter == PhotoFilter.all) {
        // Theo yêu cầu: "Mọi người" lấy cả feed (bạn bè) và user (ảnh của mình)
        final results = await Future.wait([
          _photoService.getFeed(),
          _photoService.getMyPhotos(),
        ]);
        
        // Gộp hai danh sách lại
        final List<PhotoResponse> combined = [...results[0], ...results[1]];
        
        // Sắp xếp theo thời gian mới nhất lên đầu
        combined.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
        // Loại bỏ ảnh trùng lặp nếu có (dựa trên ID)
        final Map<String, PhotoResponse> uniqueMap = {};
        for (var photo in combined) {
          uniqueMap[photo.id] = photo;
        }
        
        _photos = uniqueMap.values.toList();
        _photos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        // Chỉ lấy ảnh của tôi
        _photos = await _photoService.getMyPhotos();
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
      fetchPhotos();
    }
  }
}
