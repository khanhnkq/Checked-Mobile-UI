import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../riverpod_providers.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import '../../../../shared/widgets/capture_button.dart';

class HomeBottomControls extends ConsumerWidget {
  const HomeBottomControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraNotifier = ref.read(cameraProvider.notifier);

    return Padding(
      // Đồng bộ padding horizontal 24.0
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Gallery Button
              CircleIconButton(
                icon: LucideIcons.image,
                onPressed: () {},
                size: 50,
                iconSize: 24,
              ),
              
               // Capture Button
               CaptureButton(
                 onTap: () async {
                   final image = await cameraNotifier.takePicture();
                   if (image != null && context.mounted) {
                     context.push('/image-preview?path=${Uri.encodeComponent(image.path)}');
                   }
                 },
               ),
              
              // Flip Camera Button
              CircleIconButton(
                icon: LucideIcons.refreshCw,
                onPressed: () {
                  cameraNotifier.flipCamera();
                },
                size: 50,
                iconSize: 24,
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildHistorySection(context, ref),
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photosProvider);
    final latestThumbnailUrl = photos.isNotEmpty ? photos.first.thumbnailUrl : null;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: latestThumbnailUrl == null
                    ? Colors.white.withValues(alpha: 0.12)
                    : null,
                image: latestThumbnailUrl == null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(latestThumbnailUrl),
                        fit: BoxFit.cover,
                      ),
              ),
              child: latestThumbnailUrl == null
                  ? const Icon(LucideIcons.image, color: Colors.white70, size: 16)
                  : null,
            ),
            const SizedBox(width: 12),
            const Text(
              'Lịch sử',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Icon(LucideIcons.chevronDown, color: Colors.white, size: 24),
      ],
    );
  }
}
