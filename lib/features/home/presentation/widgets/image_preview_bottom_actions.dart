import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:locket/core/theme/app_colors.dart';

class ImagePreviewBottomActions extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSend;
  final VoidCallback onTypeText;

  const ImagePreviewBottomActions({
    super.key,
    required this.onClose,
    required this.onSend,
    required this.onTypeText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Thống nhất padding horizontal 24.0 để thẳng hàng với HomeBottomControls
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(LucideIcons.x, color: AppColors.text, size: 32),
            onPressed: onClose,
          ),
          _buildSendButton(),
          IconButton(
            icon: const Icon(LucideIcons.type, color: AppColors.text, size: 32),
            onPressed: onTypeText,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      onTap: onSend,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.text.withValues(alpha: 0.2),
        ),
        child: const Center(
          child: Icon(LucideIcons.send, color: AppColors.text, size: 32),
        ),
      ),
    );
  }
}
