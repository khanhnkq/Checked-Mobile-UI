import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/history_photo_grid.dart';
import '../widgets/history_top_bar.dart';
import '../riverpod_providers.dart';
import '../../../../shared/widgets/skeleton.dart';
import '../../../../shared/widgets/measure_size.dart';

class HistoryGridScreen extends ConsumerStatefulWidget {
  const HistoryGridScreen({super.key});

  @override
  ConsumerState<HistoryGridScreen> createState() => _HistoryGridScreenState();
}

class _HistoryGridScreenState extends ConsumerState<HistoryGridScreen> {
  final ScrollController _scrollController = ScrollController();
  double _topOverlayHeight = 0;
  double _bottomOverlayHeight = 0;

  void _setTopOverlayHeight(double height) {
    if ((_topOverlayHeight - height).abs() < 0.5) return;
    setState(() => _topOverlayHeight = height);
  }

  void _setBottomOverlayHeight(double height) {
    if ((_bottomOverlayHeight - height).abs() < 0.5) return;
    setState(() => _bottomOverlayHeight = height);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final photoState = ref.read(photoProvider);
      if (!photoState.isLoading && photoState.hasMore) {
        ref.read(photoProvider.notifier).loadMore();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoState = ref.watch(photoProvider);
    final photos = photoState.photos;
    final isLoading = photoState.isLoading;
    final error = photoState.errorMessage;

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: Stack(
        children: [
          // 1. Grid content (Main background)
          Positioned.fill(
            child: () {
              if (photos.isEmpty && isLoading) {
                return GridView.builder(
                  padding: EdgeInsets.only(
                    top: _topOverlayHeight,
                    bottom: _bottomOverlayHeight,
                    left: 8,
                    right: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 140,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) => const SkeletonBox(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                );
              }

              if (error != null && photos.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(LucideIcons.alertCircle,
                            color: Colors.redAccent, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          error,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () =>
                              ref.read(photoProvider.notifier).fetchPhotos(),
                          child: const Text(
                            'Thử lại',
                            style: TextStyle(color: Color(0xFFFFD35A)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (photos.isEmpty) {
                return const Center(
                  child: Text(
                    'Chưa có ảnh nào',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return HistoryPhotoGrid(
                photos: photos,
                scrollController: _scrollController,
                onPhotoTap: (photo) => context.pop(photo.id),
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left: 8,
                  right: 8,
                ).copyWith(
                  top: _topOverlayHeight,
                  bottom: _bottomOverlayHeight,
                ),
                footer: photoState.hasMore
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFFD35A),
                          ),
                        ),
                      )
                    : null,
              );
            }(),
          ),

          // 2. Top Bar (Overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MeasureSize(
              onChange: (size) => _setTopOverlayHeight(size.height),
              child: SafeArea(
                bottom: false,
                child: const HistoryTopBar(),
              ),
            ),
          ),

          // 3. Bottom Close Button (Overlay)
          Align(
            alignment: Alignment.bottomCenter,
            child: MeasureSize(
              onChange: (size) => _setBottomOverlayHeight(size.height),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: IconButton(
                    icon: const Icon(LucideIcons.chevronDown,
                        color: Colors.white, size: 32),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
