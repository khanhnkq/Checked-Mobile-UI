import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/camera_provider.dart';
import '../providers/photo_provider.dart';
import '../screens/image_preview_screen.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import '../../../../shared/widgets/capture_button.dart';

class HomeBottomControls extends StatelessWidget {
  const HomeBottomControls({super.key});

  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CameraProvider>(context, listen: false);

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
                  final image = await cameraProvider.takePicture();
                  if (image != null && context.mounted) {
                    // Sử dụng PageRouteBuilder để tạo hiệu ứng hiện dần (Fade In)
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ImagePreviewScreen(imagePath: image.path),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
              ),
              
              // Flip Camera Button
              CircleIconButton(
                icon: LucideIcons.refreshCw,
                onPressed: () {
                  cameraProvider.flipCamera();
                },
                size: 50,
                iconSize: 24,
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildHistorySection(context),
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Selector<PhotoProvider, String?>(
      selector: (_, photoProvider) {
        if (photoProvider.photos.isEmpty) return null;
        return photoProvider.photos.first.thumbnailUrl;
      },
      builder: (context, latestThumbnailUrl, _) => Column(
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
      ),
    );
  }
}
