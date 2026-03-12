import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import '../../../../shared/widgets/painters.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Selector đảm bảo widget chỉ rebuild khi avatarUrl thay đổi,
    // không bị ảnh hưởng bởi PhotoProvider hay bất kỳ provider nào khác.
    return Selector<AuthProvider, String?>(
      selector: (_, auth) => auth.userProfile?.avatarUrl,
      builder: (context, avatarUrl, child) => _HomeTopBarContent(
        avatarUrl: avatarUrl,
        friendsCount: 1, // Mock
      ),
    );
  }
}

class _HomeTopBarContent extends StatelessWidget {
  final String? avatarUrl;
  final int friendsCount;

  const _HomeTopBarContent({
    this.avatarUrl,
    this.friendsCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 44.0;
    final Color buttonBgColor = Colors.white.withOpacity(0.15);

    return Padding(
      // Thống nhất padding horizontal 24.0
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Avatar Button
          GestureDetector(
            onTap: () {},
            child: CustomPaint(
              painter: CircleBackgroundPainter(color: buttonBgColor),
              child: Container(
                width: buttonSize,
                height: buttonSize,
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                  child: avatarUrl == null
                      ? const Icon(LucideIcons.user, color: Colors.white, size: 20)
                      : null,
                ),
              ),
            ),
          ),
          
          // Middle: Friends Pill
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: buttonSize),
            child: CustomPaint(
              painter: PillBackgroundPainter(color: buttonBgColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.users, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '$friendsCount người bạn',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Right: Chat Button
          CircleIconButton(
            icon: LucideIcons.messageCircle,
            onPressed: () {},
            size: buttonSize,
            color: buttonBgColor,
          ),
        ],
      ),
    );
  }
}
