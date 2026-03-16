import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/painters.dart';
import 'home_top_bar.dart';
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
            return HomeTopBar.shared(
              center: _HistoryFilterPill(
                currentFilter: currentFilter,
                userDisplayName: user.displayName,
                userAvatarUrl: user.avatarUrl,
                onFilterSelected: (filter) =>
                    context.read<PhotoProvider>().setFilter(filter),
              ),
              useProfileLeading: true,
              useMessageTrailing: true,
            );
          },
        );
      },
    );
  }
}

class _HistoryFilterPill extends StatelessWidget {
  final PhotoFilter currentFilter;
  final String? userDisplayName;
  final String? userAvatarUrl;
  final void Function(PhotoFilter) onFilterSelected;

  const _HistoryFilterPill({
    required this.currentFilter,
    required this.onFilterSelected,
    this.userDisplayName,
    this.userAvatarUrl,
  });

  String get _selectedLabel =>
      currentFilter == PhotoFilter.all ? 'Mọi người' : (userDisplayName ?? 'Cá nhân');

  Future<void> _showCenteredMenu(BuildContext context) async {
    const double menuWidth = 260;
    const double horizontalScreenPadding = 8;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonTopLeft = button.localToGlobal(Offset.zero, ancestor: overlay);

    final double top = buttonTopLeft.dy + button.size.height + 8;
    final double maxAllowedWidth = overlay.size.width - (horizontalScreenPadding * 2);
    final double effectiveWidth = menuWidth > maxAllowedWidth ? maxAllowedWidth : menuWidth;
    final double left = (overlay.size.width - effectiveWidth) / 2;
    final double right = left;

    final selected = await showMenu<PhotoFilter>(
      context: context,
      color: const Color(0xFF2C2B26),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: BoxConstraints.tightFor(width: effectiveWidth),
      position: RelativeRect.fromLTRB(left, top, right, overlay.size.height - top),
      items: [
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
    );

    if (selected != null) {
      onFilterSelected(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonBgColor = Colors.white.withValues(alpha: 0.15);

    return GestureDetector(
      onTap: () => _showCenteredMenu(context),
      child: SizedBox(
        width: 132,
        height: 44,
        child: CustomPaint(
          painter: PillBackgroundPainter(color: buttonBgColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
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
                const Icon(LucideIcons.chevronDown, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
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
