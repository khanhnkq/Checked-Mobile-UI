import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../shared/widgets/circle_icon_button.dart';

class ImagePreviewTopBar extends StatelessWidget {
  final VoidCallback onDownload;

  const ImagePreviewTopBar({super.key, required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Thống nhất padding horizontal 24.0 để thẳng hàng với HomeTopBar
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 44), // Spacer for centering text
          const Text(
            'Gửi đến...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleIconButton(
            icon: LucideIcons.download,
            onPressed: onDownload,
            size: 44,
            iconSize: 22,
          ),
        ],
      ),
    );
  }
}
