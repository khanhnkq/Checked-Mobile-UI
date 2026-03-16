import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../../data/models/photo_models.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class PhotoDetailBody extends StatelessWidget {
  final PhotoResponse photo;
  final double bottomSpacing;

  const PhotoDetailBody({
    super.key,
    required this.photo,
    this.bottomSpacing = 140,
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
    final authProvider = context.read<AuthProvider>();
    final isMe = photo.senderId == authProvider.currentUserId;
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Column(
      children: [
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
                
                // Caption & Amount Overlay
                Positioned(
                  bottom: 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (photo.amount != null && photo.amount! > 0)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD35A),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            currencyFormat.format(photo.amount),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      if (photo.caption != null && photo.caption!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${isMe ? "Bạn" : photo.senderDisplayName} · ${_getTimeAgo(photo.takenAt)}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
        _buildActivityButton(photo),
        const Spacer(),
        SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildActivityButton(PhotoResponse photo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
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
    );
  }
}
