import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import '../providers/photo_provider.dart';

class HistoryTopBar extends StatelessWidget {
  const HistoryTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Chỉ rebuild khi currentFilter, displayName hoặc avatarUrl thay đổi
    return Selector<PhotoProvider, PhotoFilter>(
      selector: (_, p) => p.currentFilter,
      builder: (context, currentFilter, child) {
        return Selector<AuthProvider, ({String? displayName, String? avatarUrl})>(
          selector: (_, auth) => (
            displayName: auth.userProfile?.firstName,
            avatarUrl: auth.userProfile?.avatarUrl,
          ),
          builder: (context, user, child) {
            return _HistoryTopBarContent(
              currentFilter: currentFilter,
              userDisplayName: user.displayName,
              userAvatarUrl: user.avatarUrl,
              onFilterSelected: (filter) =>
                  context.read<PhotoProvider>().setFilter(filter),
            );
          },
        );
      },
    );
  }
}

class _HistoryTopBarContent extends StatelessWidget {
  final PhotoFilter currentFilter;
  final String? userDisplayName;
  final String? userAvatarUrl;
  final void Function(PhotoFilter) onFilterSelected;

  const _HistoryTopBarContent({
    required this.currentFilter,
    required this.onFilterSelected,
    this.userDisplayName,
    this.userAvatarUrl,
  });

  String get _selectedLabel =>
      currentFilter == PhotoFilter.all ? 'Mọi người' : (userDisplayName ?? 'Cá nhân');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(
            icon: LucideIcons.user,
            onPressed: () {},
          ),

          // Dropdown Filter
          Theme(
            data: Theme.of(context).copyWith(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: PopupMenuButton<PhotoFilter>(
              offset: const Offset(0, 50),
              elevation: 0,
              color: const Color(0xFF2C2B26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: onFilterSelected,
              itemBuilder: (context) => [
                _buildPopupItem(
                  value: PhotoFilter.all,
                  title: 'Mọi người',
                  icon: const Icon(LucideIcons.users, color: Colors.white, size: 18),
                  isSelected: currentFilter == PhotoFilter.all,
                ),
                _buildPopupItem(
                  value: PhotoFilter.me,
                  title: userDisplayName ?? 'Cá nhân',
                  icon: CircleAvatar(
                    radius: 10,
                    backgroundImage: userAvatarUrl != null ? NetworkImage(userAvatarUrl!) : null,
                    backgroundColor: Colors.grey[800],
                    child: userAvatarUrl == null
                        ? const Icon(LucideIcons.user, color: Colors.white, size: 10)
                        : null,
                  ),
                  isSelected: currentFilter == PhotoFilter.me,
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(LucideIcons.chevronDown, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),

          CircleIconButton(
            icon: LucideIcons.messageCircle,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  PopupMenuItem<PhotoFilter> _buildPopupItem({
    required PhotoFilter value,
    required String title,
    required Widget icon,
    required bool isSelected,
  }) {
    return PopupMenuItem<PhotoFilter>(
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
