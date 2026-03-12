import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/photo_provider.dart';

class HistoryFilterSheet extends StatelessWidget {
  final PhotoFilter currentFilter;
  final String? userDisplayName;
  final String? userAvatarUrl;
  final Function(PhotoFilter) onFilterSelected;

  const HistoryFilterSheet({
    super.key,
    required this.currentFilter,
    this.userDisplayName,
    this.userAvatarUrl,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF2C2B26),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          
          // Filter Options Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Option: Mọi người
                _buildOption(
                  context: context,
                  title: 'Mọi người',
                  isSelected: currentFilter == PhotoFilter.all,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38),
                    ),
                    child: const Icon(LucideIcons.users, color: Colors.white, size: 20),
                  ),
                  onTap: () => onFilterSelected(PhotoFilter.all),
                ),
                
                // Divider
                Divider(height: 1, color: Colors.white.withOpacity(0.1), indent: 60),
                
                // Option: Cá nhân (Tên người dùng)
                _buildOption(
                  context: context,
                  title: userDisplayName ?? 'Cá nhân',
                  isSelected: currentFilter == PhotoFilter.me,
                  icon: CircleAvatar(
                    radius: 18,
                    backgroundImage: userAvatarUrl != null ? NetworkImage(userAvatarUrl!) : null,
                    backgroundColor: Colors.grey[800],
                    child: userAvatarUrl == null ? const Icon(LucideIcons.user, color: Colors.white, size: 18) : null,
                  ),
                  onTap: () => onFilterSelected(PhotoFilter.me),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              const Icon(LucideIcons.chevronRight, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
