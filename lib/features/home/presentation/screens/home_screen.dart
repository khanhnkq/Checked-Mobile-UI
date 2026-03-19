import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/models/photo_models.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/home_camera_view.dart';
import '../widgets/home_bottom_controls.dart';
import '../widgets/detail_bottom_controls.dart';
import '../widgets/photo_detail_body.dart';
import '../providers/photo_provider.dart';

class HomeScreen extends StatefulWidget {
  final String? initialPhotoId;

  const HomeScreen({
    super.key,
    this.initialPhotoId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<bool> _isDetailPage = ValueNotifier<bool>(false);
  bool _didApplyInitialPhotoSelection = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhotoProvider>().fetchPhotos();
    });
  }

  void _onPageScroll() {
    if (!_pageController.hasClients) return;
    
    final isDetailPage = (_pageController.page?.round() ?? 0) > 0;
    if (isDetailPage != _isDetailPage.value) {
      _isDetailPage.value = isDetailPage;
    }

    // Trigger load more when near the end of the list
    final provider = context.read<PhotoProvider>();
    if (provider.hasMore && !provider.isLoading) {
      if (_pageController.page! >= provider.photos.length - 2) {
        provider.loadMore();
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
    context.push('/history');
  }

  @override
  void dispose() {
    _pageController.dispose();
    _isDetailPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: Stack(
        children: [
          // Main content fills the whole screen
          Positioned.fill(
            child: Selector<PhotoProvider, List<PhotoResponse>>(
              selector: (_, provider) => provider.photos,
              builder: (context, photos, child) {
                _tryOpenInitialPhoto(photos);

                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: 1 + photos.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildCameraContent();
                    }

                    return PhotoDetailBody(photo: photos[index - 1]);
                  },
                );
              },
            ),
          ),

          // Header overlays at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: ValueListenableBuilder<bool>(
                valueListenable: _isDetailPage,
                builder: (context, isDetailPage, _) =>
                    isDetailPage ? const HistoryTopBar() : const HomeTopBar(),
              ),
            ),
          ),

          // Bottom controls overlay at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: ValueListenableBuilder<bool>(
                valueListenable: _isDetailPage,
                builder: (context, isDetailPage, _) {
                  if (!isDetailPage) {
                    return const HomeBottomControls();
                  }

                  return DetailBottomControls(
                    onOpenGrid: _openHistoryGrid,
                    onPrimaryAction: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraContent() {
    return Column(
      children: [
        const SizedBox(height: 80), // Added space below header
        const Spacer(),
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: HomeCameraView(),
          ),
        ),
        const Spacer(),
        const SizedBox(height: 156), // Placeholder for bottom controls
      ],
    );
  }
}
