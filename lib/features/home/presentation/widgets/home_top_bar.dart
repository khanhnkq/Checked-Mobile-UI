import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../../shared/widgets/circle_icon_button.dart';
import '../../../../shared/widgets/painters.dart';

class HomeTopBar extends StatelessWidget {
  final Widget? leading;
  final Widget? center;
  final Widget? trailing;
  final bool useProfileLeading;
  final bool useMessageTrailing;
  final int friendsCount;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  const HomeTopBar({
    super.key,
    this.friendsCount = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.backgroundColor = Colors.transparent,
  })  : leading = null,
        center = null,
        trailing = null,
        useProfileLeading = true,
        useMessageTrailing = true;

  const HomeTopBar.shared({
    super.key,
    required this.center,
    this.leading,
    this.trailing,
    this.useProfileLeading = true,
    this.useMessageTrailing = false,
    this.friendsCount = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, String?>(
      selector: (_, auth) => auth.userProfile?.avatarUrl,
      builder: (context, avatarUrl, child) => _HomeTopBarFrame(
        backgroundColor: backgroundColor,
        padding: padding,
        leading: leading ??
            (useProfileLeading
                ? _HomeTopBarProfileButton(avatarUrl: avatarUrl)
                : const _HomeTopBarSlot()),
        center: center ?? _HomeTopBarFriendsPill(friendsCount: friendsCount),
        trailing: trailing ??
            (useMessageTrailing
                ? const _HomeTopBarMessageButton()
                : const _HomeTopBarSlot()),
      ),
    );
  }
}

class _HomeTopBarFrame extends StatelessWidget {
  final Widget leading;
  final Widget center;
  final Widget trailing;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  const _HomeTopBarFrame({
    required this.leading,
    required this.center,
    required this.trailing,
    required this.padding,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final topBarContent = Padding(
      padding: padding,
      child: SizedBox(
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: leading),
            Center(child: center),
            Align(alignment: Alignment.centerRight, child: trailing),
          ],
        ),
      ),
    );

    if (backgroundColor.a == 0) {
      return topBarContent;
    }

    return ColoredBox(
      color: backgroundColor,
      child: topBarContent,
    );
  }
}

class _HomeTopBarProfileButton extends StatelessWidget {
  final String? avatarUrl;

  const _HomeTopBarProfileButton({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 44.0;
    final Color buttonBgColor = Colors.white.withValues(alpha: 0.15);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: CustomPaint(
        painter: CircleBackgroundPainter(color: buttonBgColor),
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Padding(
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
    );
  }
}

class _HomeTopBarFriendsPill extends StatelessWidget {
  final int friendsCount;

  const _HomeTopBarFriendsPill({required this.friendsCount});

  @override
  Widget build(BuildContext context) {
    final Color buttonBgColor = Colors.white.withValues(alpha: 0.15);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
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
    );
  }
}

class _HomeTopBarMessageButton extends StatelessWidget {
  const _HomeTopBarMessageButton();

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: LucideIcons.messageCircle,
      onPressed: () {},
      size: 44,
      color: Colors.white.withValues(alpha: 0.15),
    );
  }
}

class _HomeTopBarSlot extends StatelessWidget {
  const _HomeTopBarSlot();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 44, height: 44);
  }
}
