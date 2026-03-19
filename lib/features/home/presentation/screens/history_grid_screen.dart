import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../widgets/history_photo_grid.dart';
import '../widgets/history_top_bar.dart';
import '../providers/photo_provider.dart';
import '../../../../shared/widgets/skeleton.dart';

class HistoryGridScreen extends StatefulWidget {
  const HistoryGridScreen({super.key});

  @override
  State<HistoryGridScreen> createState() => _HistoryGridScreenState();
}

class _HistoryGridScreenState extends State<HistoryGridScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<PhotoProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: Stack(
        children: [
          // 1. Grid content (Main background)
          Positioned.fill(
            child: Consumer<PhotoProvider>(
              builder: (context, provider, child) {
                final photos = provider.photos;
                final isLoading = provider.isLoading;
                final error = provider.errorMessage;

                if (photos.isEmpty && isLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 120.0, left: 8, right: 8), 
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) => const SkeletonBox(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
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
                            onPressed: () => provider.fetchPhotos(),
                            child: const Text('Thử lại',
                                style: TextStyle(color: Color(0xFFFFD35A))),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (photos.isEmpty) {
                  return const Center(
                    child: Text('Chưa có ảnh nào',
                        style: TextStyle(color: Colors.grey)),
                  );
                }

                return HistoryPhotoGrid(
                  photos: photos,
                  scrollController: _scrollController,
                  onPhotoTap: (photo) => context.pop(),
                  // Increased top padding to 120 to account for SafeArea + Header height
                  padding: const EdgeInsets.only(
                    top: 120, 
                    bottom: 156, 
                    left: 8, 
                    right: 8,
                  ),
                  footer: provider.hasMore
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFFFFD35A))),
                        )
                      : null,
                );
              },
            ),
          ),

          // 2. Top Bar (Overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: const HistoryTopBar(),
            ),
          ),

          // 3. Bottom Close Button (Overlay)
          Align(
            alignment: Alignment.bottomCenter,
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
        ],
      ),
    );
  }
}
