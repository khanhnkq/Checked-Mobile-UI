import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../data/models/photo_models.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/capture_button.dart';
import '../widgets/history_top_bar.dart';
import 'history_grid_screen.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoResponse photo;
  final VoidCallback? onBackToCamera;

  const PhotoDetailScreen({
    super.key,
    required this.photo,
    this.onBackToCamera,
  });

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays >= 1) return '${difference.inDays}ngày';
    if (difference.inHours >= 1) return '${difference.inHours}giờ';
    if (difference.inMinutes >= 1) return '${difference.inMinutes}phút';
    return 'vừa xong';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isMe = photo.senderId == authProvider.authResponse?.id;

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: SafeArea(
        child: Column(
          children: [
            // Self-contained, tự đọc provider qua Selector — không re-render theo provider khác
            const HistoryTopBar(),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        photo.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    if (photo.caption != null && photo.caption!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            photo.caption!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              '${isMe ? "Bạn" : photo.senderDisplayName} ${_getTimeAgo(photo.takenAt)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.sparkles, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Hoạt động',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: photo.senderAvatarUrl != null
                        ? NetworkImage(photo.senderAvatarUrl!)
                        : null,
                    child: photo.senderAvatarUrl == null
                        ? const Icon(LucideIcons.user, size: 12)
                        : null,
                  ),
                ],
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.layoutGrid, color: Colors.white, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryGridScreen(),
                        ),
                      );
                    },
                  ),
                  CaptureButton(
                    onTap: onBackToCamera ?? () => Navigator.pop(context),
                    size: 70,
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.share2, color: Colors.white, size: 32),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        photo.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    if (photo.caption != null && photo.caption!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            photo.caption!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              '${isMe ? "Bạn" : photo.senderDisplayName} ${_getTimeAgo(photo.takenAt)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.sparkles, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Hoạt động',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: photo.senderAvatarUrl != null 
                        ? NetworkImage(photo.senderAvatarUrl!) 
                        : null,
                    child: photo.senderAvatarUrl == null 
                        ? const Icon(LucideIcons.user, size: 12) 
                        : null,
                  ),
                ],
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.layoutGrid, color: Colors.white, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HistoryGridScreen()),
                      );
                    },
                  ),
                  CaptureButton(
                    onTap: onBackToCamera ?? () => Navigator.pop(context),
                    size: 70,
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.share2, color: Colors.white, size: 32),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
