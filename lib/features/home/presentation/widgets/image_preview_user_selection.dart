import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ImagePreviewUserSelection extends StatelessWidget {
  const ImagePreviewUserSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildUserIcon(
          icon: LucideIcons.users,
          label: 'Tất cả',
          isSelected: true,
        ),
        const SizedBox(width: 24),
        _buildUserIcon(
          label: 'Khánh',
          isSelected: false,
          imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
        ),
      ],
    );
  }

  Widget _buildUserIcon({
    IconData? icon,
    String? label,
    required bool isSelected,
    String? imageUrl,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: const Color(0xFFFFD35A), width: 2)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              child: icon != null ? Icon(icon, color: Colors.white, size: 24) : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label ?? '',
          style: TextStyle(
            color: isSelected ? const Color(0xFFFFD35A) : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
