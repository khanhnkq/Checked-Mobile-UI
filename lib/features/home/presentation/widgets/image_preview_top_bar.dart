import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import 'home_top_bar.dart';
import 'package:locket/core/theme/app_colors.dart';

class ImagePreviewTopBar extends StatelessWidget {
  final VoidCallback onDownload;

  const ImagePreviewTopBar({super.key, required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return HomeTopBar.shared(
      center: const Text(
        'Gửi đến...',
        style: TextStyle(
          color: AppColors.text,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: CircleIconButton(
        icon: LucideIcons.download,
        onPressed: onDownload,
        size: 44,
        iconSize: 22,
        color: AppColors.text.withValues(alpha: 0.15),
      ),
      useProfileLeading: true,
    );
  }
}
