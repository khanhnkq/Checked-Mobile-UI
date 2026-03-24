import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/photo_models.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/home_camera_view.dart';
import '../widgets/home_bottom_controls.dart';
import '../widgets/detail_bottom_controls.dart';
import '../widgets/photo_detail_body.dart';
import '../riverpod_providers.dart';
import '../../../friendship/presentation/riverpod_providers.dart';
import '../../../../shared/widgets/measure_size.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? initialPhotoId;

  const HomeScreen({super.key, this.initialPhotoId});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<bool> _isDetailPage = ValueNotifier<bool>(false);
  final ValueNotifier<int> _currentPageIndex = ValueNotifier<int>(0);
  bool _didApplyInitialPhotoSelection = false;
  double _topOverlayHeight = 0;
  double _bottomOverlayHeight = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(photoProvider.notifier).fetchPhotos();
      ref.read(friendshipProvider.notifier).fetchFriendships();
    });
  }

  void _onPageScroll() {
    if (!_pageController.hasClients) return;

    final roundedPage = _pageController.page?.round() ?? 0;
    final isDetailPage = roundedPage > 0;
    if (isDetailPage != _isDetailPage.value) {
      _isDetailPage.value = isDetailPage;
    }
    if (_currentPageIndex.value != roundedPage) {
      _currentPageIndex.value = roundedPage;
    }

    // Trigger load more when near the end of the list
    final photoState = ref.read(photoProvider);
    if (photoState.hasMore && !photoState.isLoading) {
      if (_pageController.page! >= photoState.photos.length - 2) {
        ref.read(photoProvider.notifier).loadMore();
      }
    }
  }

  void _tryOpenInitialPhoto(List<PhotoResponse> photos) {
    if (_didApplyInitialPhotoSelection || widget.initialPhotoId == null) {
      return;
    }

    final index = photos.indexWhere((p) => p.id == widget.initialPhotoId);
    if (index < 0) {
      return;
    }

    _didApplyInitialPhotoSelection = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageController.hasClients) return;
      _pageController.jumpToPage(index + 1);
    });
  }

  Future<void> _openHistoryGrid() async {
    final selectedPhotoId = await context.push<String>('/history');
    if (!mounted || selectedPhotoId == null || !_pageController.hasClients) {
      return;
    }

    final photos = ref.read(photosProvider);
    final selectedIndex = photos.indexWhere((p) => p.id == selectedPhotoId);
    if (selectedIndex < 0) return;

    _pageController.jumpToPage(selectedIndex + 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _isDetailPage.dispose();
    _currentPageIndex.dispose();
    super.dispose();
  }

  void _setTopOverlayHeight(double height) {
    if ((_topOverlayHeight - height).abs() < 0.5) return;
    setState(() => _topOverlayHeight = height);
  }

  void _setBottomOverlayHeight(double height) {
    if ((_bottomOverlayHeight - height).abs() < 0.5) return;
    setState(() => _bottomOverlayHeight = height);
  }

  @override
  Widget build(BuildContext context) {
    final photos = ref.watch(photosProvider);
    _tryOpenInitialPhoto(photos);
    final hasPhotos = photos.isNotEmpty;
    final detailPageCount = hasPhotos ? photos.length : 1;

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: Stack(
        children: [
          // Main content fills the whole screen
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: 1 + detailPageCount,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildCameraContent(
                    topInset: _topOverlayHeight,
                    bottomInset: _bottomOverlayHeight,
                  );
                }

                if (!hasPhotos) {
                  return _buildEmptyDetailContent(
                    topInset: _topOverlayHeight,
                    bottomInset: _bottomOverlayHeight,
                  );
                }

                return PhotoDetailBody(photo: photos[index - 1]);
              },
            ),
          ),

          // Header overlays at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MeasureSize(
              onChange: (size) => _setTopOverlayHeight(size.height),
              child: SafeArea(
                bottom: false,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isDetailPage,
                  builder: (context, isDetailPage, _) =>
                      isDetailPage ? const HistoryTopBar() : const HomeTopBar(),
                ),
              ),
            ),
          ),

          // Bottom controls overlay at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: MeasureSize(
              onChange: (size) => _setBottomOverlayHeight(size.height),
              child: SafeArea(
                top: false,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isDetailPage,
                  builder: (context, isDetailPage, _) {
                    if (!isDetailPage) {
                      return const HomeBottomControls();
                    }

                    return ValueListenableBuilder<int>(
                      valueListenable: _currentPageIndex,
                      builder: (context, currentPage, _) {
                        return DetailBottomControls(
                          onOpenGrid: _openHistoryGrid,
                          onPrimaryAction: () {
                            _pageController.jumpToPage(0);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraContent({
    required double topInset,
    required double bottomInset,
  }) {
    return Column(
      children: [
        SizedBox(height: topInset),
        const Spacer(),
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: HomeCameraView(),
          ),
        ),
        const Spacer(),
        SizedBox(height: bottomInset),
      ],
    );
  }

  Widget _buildEmptyDetailContent({
    required double topInset,
    required double bottomInset,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topInset, bottom: bottomInset),
      child: const Center(
        child: Text(
          'Không có ảnh cho bộ lọc này',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
