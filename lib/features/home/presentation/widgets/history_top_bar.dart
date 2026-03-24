import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../auth/presentation/riverpod_providers.dart';
import '../../../friendship/presentation/riverpod_providers.dart';
import '../../../profile/data/models/profile_models.dart';
import '../../../../shared/widgets/painters.dart';
import 'home_top_bar.dart';
import '../riverpod_notifiers/photo_state.dart';
import '../riverpod_providers.dart';

class HistoryTopBar extends ConsumerWidget {
  const HistoryTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(photoFilterProvider);
    final selectedFriendId = ref.watch(photoSelectedFriendIdProvider);
    final friendshipsState = ref.watch(friendshipProvider);
    final friends = friendshipsState.friends;
    final user = ref.watch(userProfileProvider);

    if (!friendshipsState.isLoading && friends.isEmpty) {
      ref.read(friendshipProvider.notifier).fetchFriendships();
    }

    return HomeTopBar.shared(
      center: _HistoryFilterPill(
        currentFilter: currentFilter,
        selectedFriendId: selectedFriendId,
        friends: friends,
        userDisplayName: user?.firstName,
        userAvatarUrl: user?.avatarUrl,
        onFilterSelected: (filter, friendId) {
          final notifier = ref.read(photoProvider.notifier);
          if (filter == PhotoFilter.friend && friendId != null) {
            notifier.setFriendFilter(friendId);
          } else if (filter == PhotoFilter.me) {
            notifier.setMyFilter();
          } else {
            notifier.setAllFilter();
          }
          notifier.fetchPhotos();
        },
      ),
      useProfileLeading: true,
      useMessageTrailing: true,
    );
  }
}

class _HistoryFilterPill extends StatelessWidget {
  final PhotoFilter currentFilter;
  final String? selectedFriendId;
  final List<UserResponse> friends;
  final String? userDisplayName;
  final String? userAvatarUrl;
  final void Function(PhotoFilter, String? friendId) onFilterSelected;

  const _HistoryFilterPill({
    required this.currentFilter,
    required this.selectedFriendId,
    required this.friends,
    required this.onFilterSelected,
    this.userDisplayName,
    this.userAvatarUrl,
  });

  String get _selectedLabel {
    if (currentFilter == PhotoFilter.all) return 'Mọi người';
    if (currentFilter == PhotoFilter.me) return 'Bạn';
    final selected = _selectedFriend;
    return selected?.displayName.isNotEmpty == true
        ? selected!.displayName
        : 'Bạn bè';
  }

  UserResponse? get _selectedFriend {
    for (final friend in friends) {
      if (friend.id == selectedFriendId) {
        return friend;
      }
    }
    return null;
  }

  Widget get _selectedLeadingIcon {
    if (currentFilter == PhotoFilter.all) {
      return const Icon(LucideIcons.users, color: Colors.white, size: 16);
    }

    if (currentFilter == PhotoFilter.me) {
      return CircleAvatar(
        radius: 9,
        backgroundImage: userAvatarUrl != null ? NetworkImage(userAvatarUrl!) : null,
        backgroundColor: Colors.grey[800],
        child: userAvatarUrl == null
            ? const Icon(LucideIcons.user, color: Colors.white, size: 10)
            : null,
      );
    }

    final friend = _selectedFriend;
    return CircleAvatar(
      radius: 9,
      backgroundImage: friend?.avatarUrl != null
          ? NetworkImage(friend!.avatarUrl!)
          : null,
      backgroundColor: Colors.grey[800],
      child: friend?.avatarUrl == null
          ? const Icon(LucideIcons.user, color: Colors.white, size: 10)
          : null,
    );
  }

  Future<void> _showCenteredMenu(BuildContext context) async {
    const double menuWidth = 260;
    const double horizontalScreenPadding = 8;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonTopLeft = button.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );

    final double top = buttonTopLeft.dy + button.size.height + 8;
    final double maxAllowedWidth =
        overlay.size.width - (horizontalScreenPadding * 2);
    final double effectiveWidth = menuWidth > maxAllowedWidth
        ? maxAllowedWidth
        : menuWidth;
    final double left = (overlay.size.width - effectiveWidth) / 2;
    final double right = left;

    final selected = await showMenu<_HistoryFilterSelection>(
      context: context,
      color: const Color(0xFF2C2B26),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      constraints: BoxConstraints.tightFor(width: effectiveWidth),
      position: RelativeRect.fromLTRB(
        left,
        top,
        right,
        overlay.size.height - top,
      ),
      items: [
        _buildPopupItem(
          value: const _HistoryFilterSelection(filter: PhotoFilter.all),
          title: 'Mọi người',
          icon: const Icon(LucideIcons.users, color: Colors.white, size: 18),
          isSelected: currentFilter == PhotoFilter.all,
        ),
        _buildPopupItem(
          value: const _HistoryFilterSelection(filter: PhotoFilter.me),
          title: 'Bạn',
          icon: CircleAvatar(
            radius: 10,
            backgroundImage: userAvatarUrl != null
                ? NetworkImage(userAvatarUrl!)
                : null,
            backgroundColor: Colors.grey[800],
            child: userAvatarUrl == null
                ? const Icon(LucideIcons.user, color: Colors.white, size: 10)
                : null,
          ),
          isSelected: currentFilter == PhotoFilter.me,
        ),
        ...friends.map(
          (friend) => _buildPopupItem(
            value: _HistoryFilterSelection(
              filter: PhotoFilter.friend,
              friendId: friend.id,
            ),
            title: friend.displayName,
            icon: CircleAvatar(
              radius: 10,
              backgroundImage: friend.avatarUrl != null
                  ? NetworkImage(friend.avatarUrl!)
                  : null,
              backgroundColor: Colors.grey[800],
              child: friend.avatarUrl == null
                  ? const Icon(LucideIcons.user, color: Colors.white, size: 10)
                  : null,
            ),
            isSelected:
                currentFilter == PhotoFilter.friend &&
                selectedFriendId == friend.id,
          ),
        ),
      ],
    );

    if (selected != null) {
      onFilterSelected(selected.filter, selected.friendId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonBgColor = Colors.white.withValues(alpha: 0.15);

    return GestureDetector(
      onTap: () => _showCenteredMenu(context),
      child: SizedBox(
        width: 164,
        height: 44,
        child: CustomPaint(
          painter: PillBackgroundPainter(color: buttonBgColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _selectedLeadingIcon,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  LucideIcons.chevronDown,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<_HistoryFilterSelection> _buildPopupItem({
    required _HistoryFilterSelection value,
    required String title,
    required Widget icon,
    required bool isSelected,
  }) {
    return PopupMenuItem<_HistoryFilterSelection>(
      value: value,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (isSelected)
            const Icon(LucideIcons.check, color: Color(0xFFFFD35A), size: 16),
        ],
      ),
    );
  }
}

class _HistoryFilterSelection {
  const _HistoryFilterSelection({required this.filter, this.friendId});

  final PhotoFilter filter;
  final String? friendId;
}
