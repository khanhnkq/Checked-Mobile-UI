import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/photo_models.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/home_camera_view.dart';
import '../widgets/home_bottom_controls.dart';
import '../widgets/detail_bottom_controls.dart';
import '../widgets/photo_detail_body.dart';
import 'history_grid_screen.dart';
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
  // Chỉ theo dõi camera/detail để chrome dùng chung không rebuild khi vuốt giữa các detail page.
  final ValueNotifier<bool> _isDetailPage = ValueNotifier<bool>(false);
  bool _didApplyInitialPhotoSelection = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final isDetailPage = (_pageController.page?.round() ?? 0) > 0;
      if (isDetailPage != _isDetailPage.value) {
        _isDetailPage.value = isDetailPage;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhotoProvider>().fetchPhotos();
    });
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
    final selectedPhotoId = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryGridScreen(),
      ),
    );

    if (!mounted || selectedPhotoId == null) {
      return;
    }

    final photos = context.read<PhotoProvider>().photos;
    final targetIndex = photos.indexWhere((photo) => photo.id == selectedPhotoId);

    if (targetIndex < 0 || !_pageController.hasClients) {
      return;
    }

    _pageController.jumpToPage(targetIndex + 1);
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
      body: SafeArea(
        child: Column(
          children: [
            // Top bar dùng chung cho tất cả trang trong PageView.
            // ValueListenableBuilder đảm bảo chỉ phần này rebuild khi đổi trang,
            // còn mỗi TopBar tự dùng Selector nên không rebuild theo provider.
            ValueListenableBuilder<bool>(
              valueListenable: _isDetailPage,
              builder: (context, isDetailPage, _) =>
                  isDetailPage ? const HistoryTopBar() : const HomeTopBar(),
            ),

            Expanded(
              child: Stack(
                children: [
                  Selector<PhotoProvider, List<PhotoResponse>>(
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
                  Align(
                    alignment: Alignment.bottomCenter,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraContent() {
    return Column(
      children: [
        const Spacer(),
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: HomeCameraView(),
          ),
        ),
        const Spacer(),
        const SizedBox(height: 156),
      ],
    );
  }
}
