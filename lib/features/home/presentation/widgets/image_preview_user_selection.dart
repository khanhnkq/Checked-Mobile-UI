import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../friendship/presentation/riverpod_providers.dart';

class ImagePreviewUserSelection extends ConsumerWidget {
  const ImagePreviewUserSelection({
    super.key,
    required this.useAllFriends,
    required this.selectedFriendIds,
    required this.onSelectAll,
    required this.onToggleFriend,
  });

  final bool useAllFriends;
  final Set<String> selectedFriendIds;
  final VoidCallback onSelectAll;
  final ValueChanged<String> onToggleFriend;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendships = ref.watch(friendsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserIcon(
            icon: LucideIcons.users,
            label: 'Tất cả',
            isSelected: useAllFriends,
            onTap: onSelectAll,
          ),
          for (final friend in friendships) ...[
            const SizedBox(width: 16),
            _buildUserIcon(
              label: friend.displayName,
              isSelected:
                  !useAllFriends && selectedFriendIds.contains(friend.id),
              imageUrl: friend.avatarUrl,
              onTap: () => onToggleFriend(friend.id),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUserIcon({
    IconData? icon,
    String? label,
    required bool isSelected,
    String? imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl)
                    : null,
                child: icon != null
                    ? Icon(icon, color: Colors.white, size: 24)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 70,
            child: Text(
              label ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? const Color(0xFFFFD35A) : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
