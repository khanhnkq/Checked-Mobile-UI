import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/models/photo_models.dart';
import '../../../../shared/widgets/skeleton.dart';
import 'package:locket/core/theme/app_colors.dart';

class HistoryPhotoGrid extends StatelessWidget {
  final List<PhotoResponse> photos;
  final ValueChanged<PhotoResponse> onPhotoTap;
  final ScrollController? scrollController;
  final Widget? footer;
  final EdgeInsetsGeometry padding;

  const HistoryPhotoGrid({
    super.key,
    required this.photos,
    required this.onPhotoTap,
    this.scrollController,
    this.footer,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 140,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final photo = photos[index];
                return GestureDetector(
                  onTap: () => onPhotoTap(photo),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: AppColors.text.withValues(alpha: 0.05),
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
                            child: Icon(LucideIcons.imageOff, color: AppColors.textSecondary, size: 24),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              childCount: photos.length,
            ),
          ),
        ),
        if (footer != null)
          SliverToBoxAdapter(
            child: footer,
          ),
      ],
    );
  }
}
