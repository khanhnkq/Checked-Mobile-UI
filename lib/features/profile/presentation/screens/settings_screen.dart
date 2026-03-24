import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../auth/presentation/riverpod_providers.dart';
import '../providers/app_settings_provider.dart';
import '../../data/services/profile_service.dart';
import '../widgets/name_input_bottom_sheet.dart';

Future<void> showSettingsBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      final sheetHeight = MediaQuery.of(sheetContext).size.height * 0.92;
      return SizedBox(
        height: sheetHeight,
        child: const SettingsScreen(isModal: true),
      );
    },
  );
}

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key, this.isModal});

  final bool? isModal;

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isUpdatingAvatar = false;
  final ProfileService _profileService = ProfileService();

  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (image == null) return;

    setState(() => _isUpdatingAvatar = true);

    try {
      final updatedUser = await _profileService.updateAvatar(image.path);
      if (updatedUser != null && mounted) {
        // Refresh session to update global userProfile state
        await ref.read(authProvider.notifier).restoreSession();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật ảnh đại diện thành công')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpdatingAvatar = false);
    }
  }

  Future<void> _onEditName() async {
    final user = ref.read(authProvider).userProfile;
    final result = await NameInputBottomSheet.show(
      context,
      currentFirstName: user?.firstName,
      currentLastName: user?.lastName,
    );
    if (result == null || !mounted) return;

    final success = await ref.read(authProvider.notifier).completeProfile(
      firstName: result.firstName,
      lastName: result.lastName,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Cập nhật tên thành công'
              : (ref.read(authProvider).errorMessage ??
                    'Cập nhật tên thất bại'),
        ),
      ),
    );
  }

  void _openSettingsRoute(String path) {
    final isModal = widget.isModal == true;
    if (isModal) {
      context.pop();
      Future.microtask(() {
        if (mounted) context.push(path);
      });
      return;
    }
    context.push(path);
  }

  Widget _buildContent() {
    final user = ref.watch(userProfileProvider);
    final settings = ref.watch(appSettingsProvider);
    final streaksEnabled = settings.streaksEnabled == true;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Tiện ích'),
          Row(
            children: [
              Expanded(
                child: _WidgetCard(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: user?.avatarUrl != null
                            ? NetworkImage(user!.avatarUrl!)
                            : null,
                        child: user?.avatarUrl == null
                            ? const Icon(LucideIcons.user, size: 20)
                            : null,
                      ),
                      if (_isUpdatingAvatar)
                        const CircularProgressIndicator(
                          color: Color(0xFFFFD35A),
                          strokeWidth: 2,
                        ),
                    ],
                  ),
                  label: 'Sửa',
                  onTap: _pickAndUploadAvatar,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _WidgetCard(
                  icon: const Icon(
                    LucideIcons.plus,
                    color: Color(0xFFFFD35A),
                    size: 32,
                  ),
                  label: 'Tạo',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Tính năng tạo tiện ích đang được phát triển',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const _SectionHeader(title: 'Tùy chỉnh'),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: LucideIcons.heart,
                title: 'Biểu tượng ứng dụng',
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.heart,
                      color: Color(0xFFFFD35A),
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      LucideIcons.chevronRight,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              _SettingsTile(
                icon: LucideIcons.camera,
                title: 'Camera theme',
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.heart,
                      color: Color(0xFFFFD35A),
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      LucideIcons.chevronRight,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              _SettingsTile(
                icon: LucideIcons.flame,
                title: 'Chuỗi trên tiện ích',
                trailing: Switch(
                  value: streaksEnabled,
                  onChanged: (value) => ref
                      .read(appSettingsProvider.notifier)
                      .setStreaksEnabled(value),
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                ),
              ),
            ],
          ),

          const _SectionHeader(title: 'Tổng quát'),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: LucideIcons.user,
                title: 'Sửa tên',
                onTap: _onEditName,
              ),
              _SettingsTile(
                icon: LucideIcons.calendar,
                title: 'Sửa ngày sinh',
                onTap: () {},
              ),
              _SettingsTile(
                icon: LucideIcons.mail,
                title: 'Đổi địa chỉ email',
                subtitle: user?.email,
                onTap: () {},
              ),
              _SettingsTile(
                icon: LucideIcons.plusCircle,
                title: 'Cách thêm tiện ích',
                onTap: () {},
              ),
              _SettingsTile(
                icon: LucideIcons.userPlus,
                title: 'Mời bạn bè',
                onTap: () => _openSettingsRoute('/friend-invite'),
              ),
              _SettingsTile(
                icon: LucideIcons.users,
                title: 'Danh sách bạn bè',
                onTap: () => _openSettingsRoute('/friendships'),
              ),
              _SettingsTile(
                icon: LucideIcons.refreshCw,
                title: 'Khôi phục đăng ký',
                onTap: () {},
              ),
            ],
          ),

          const _SectionHeader(title: 'Riêng tư & bảo mật'),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: LucideIcons.ban,
                title: 'Tài khoản đã bị chặn',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logout();
                if (!mounted) return;
                context.go('/login');
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isModal = widget.isModal == true;
    if (isModal) {
      return Material(
        color: const Color(0xFF12110B),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.chevronDown, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    const Expanded(
                      child: Text(
                        'Cài đặt',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Cài đặt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _WidgetCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _WidgetCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2B26),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Expanded(child: Center(child: icon)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2B26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          : null,
      trailing:
          trailing ??
          const Icon(LucideIcons.chevronRight, color: Colors.grey, size: 18),
    );
  }
}
