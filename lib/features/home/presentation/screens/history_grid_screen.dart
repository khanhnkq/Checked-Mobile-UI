import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../data/models/photo_models.dart';
import '../widgets/history_photo_grid.dart';
import '../widgets/history_top_bar.dart';
import '../providers/photo_provider.dart';
import '../../../../shared/widgets/skeleton.dart';

class HistoryGridScreen extends StatelessWidget {
  const HistoryGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: SafeArea(
        child: Column(
          children: [
            // Self-contained — tự đọc provider qua Selector bên trong
            const HistoryTopBar(),
            const SizedBox(height: 16),
            Expanded(
              child: Selector<PhotoProvider,
                  ({bool isLoading, String? error, List<PhotoResponse> photos})>(
                selector: (_, p) => (
                  isLoading: p.isLoading,
                  error: p.errorMessage,
                  photos: p.photos,
                ),
                builder: (context, state, child) {
                  if (state.isLoading) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    );
                  }
                  if (state.error != null) {
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
                              state.error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.read<PhotoProvider>().fetchPhotos(),
                              child: const Text('Thử lại',
                                  style: TextStyle(color: Color(0xFFFFD35A))),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state.photos.isEmpty) {
                    return const Center(
                      child: Text('Chưa có ảnh nào',
                          style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return HistoryPhotoGrid(
                    photos: state.photos,
                    onPhotoTap: (photo) => Navigator.pop(context, photo.id),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: IconButton(
                icon: const Icon(LucideIcons.chevronDown,
                    color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
