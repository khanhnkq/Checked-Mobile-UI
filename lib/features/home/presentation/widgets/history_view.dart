import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'history_top_bar.dart';
import 'history_photo_grid.dart';

import '../providers/photo_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/capture_button.dart';

class HistoryView extends StatefulWidget {
  final VoidCallback onBackToCamera;

  const HistoryView({super.key, required this.onBackToCamera});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhotoProvider>().fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.userProfile;

    return Consumer<PhotoProvider>(
      builder: (context, photoProvider, child) {
        return Container(
          color: const Color(0xFF12110B),
          child: SafeArea(
            child: Column(
              children: [
                HistoryTopBar(
                  selectedFilter: photoProvider.currentFilter == PhotoFilter.all
                      ? 'Mọi người'
                      : (user?.firstName ?? user?.username ?? 'Cá nhân'),
                  currentFilter: photoProvider.currentFilter,
                  onFilterSelected: (filter) {
                    photoProvider.setFilter(filter);
                  },
                  userDisplayName: user?.firstName ?? user?.username,
                  userAvatarUrl: user?.avatarUrl,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildBody(photoProvider),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 60),
                      CaptureButton(
                        onTap: widget.onBackToCamera,
                        size: 70,
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: const Icon(LucideIcons.playCircle,
                            color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(PhotoProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFFFD35A)),
      );
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.alertCircle, color: Colors.redAccent, size: 48),
              const SizedBox(height: 16),
              Text(
                provider.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              TextButton(
                onPressed: () => provider.fetchPhotos(),
                child: const Text('Thử lại', style: TextStyle(color: Color(0xFFFFD35A))),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.photos.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có ảnh nào',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return HistoryPhotoGrid(
      photos: provider.photos,
    );
  }
}
