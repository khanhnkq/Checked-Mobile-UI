import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/models/photo_models.dart';
import '../../../../shared/widgets/skeleton.dart';

class HistoryPhotoGrid extends StatelessWidget {
  final List<PhotoResponse> photos;
  final ValueChanged<PhotoResponse> onPhotoTap;

  const HistoryPhotoGrid({
    super.key,
    required this.photos,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return GestureDetector(
          onTap: () => onPhotoTap(photo),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white.withValues(alpha: 0.05),
              child: Image.network(
                photo.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SkeletonBox(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(LucideIcons.imageOff, color: Colors.white24, size: 24),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
