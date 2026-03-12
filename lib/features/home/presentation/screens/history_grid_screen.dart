import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/history_photo_grid.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/history_filter_sheet.dart';
import '../providers/photo_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HistoryGridScreen extends StatelessWidget {
  const HistoryGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.userProfile;

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: SafeArea(
        child: Consumer<PhotoProvider>(
          builder: (context, photoProvider, child) {
            return Column(
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
                  child: photoProvider.isLoading
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFFFFD35A)))
                      : photoProvider.photos.isEmpty
                          ? const Center(child: Text('Chưa có ảnh nào', style: TextStyle(color: Colors.grey)))
                          : HistoryPhotoGrid(photos: photoProvider.photos),
                ),
                // Nút đóng/quay lại
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: IconButton(
                    icon: const Icon(LucideIcons.chevronDown, color: Colors.white, size: 32),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
