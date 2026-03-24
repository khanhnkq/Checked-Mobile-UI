import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/friend_invite_models.dart';
import '../../../friendship/presentation/riverpod_providers.dart';
import '../riverpod_notifiers/friend_invite_state.dart';
import '../riverpod_providers.dart';

class FriendInviteScreen extends ConsumerStatefulWidget {
  const FriendInviteScreen({super.key});

  @override
  ConsumerState<FriendInviteScreen> createState() => _FriendInviteScreenState();
}

class _FriendInviteScreenState extends ConsumerState<FriendInviteScreen> {
  final TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(friendInviteProvider.notifier).loadCurrentLink();
    });
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<FriendInviteState>(friendInviteProvider, (previous, next) {
      final acceptedNow =
          previous?.acceptStatus != FriendInviteAcceptStatus.success &&
          next.acceptStatus == FriendInviteAcceptStatus.success;
      if (acceptedNow) {
        ref.read(friendshipProvider.notifier).refreshFriendships();
      }

      final message = next.errorMessage;
      if (message == null || message.isEmpty) return;
      if (previous?.errorMessage == message) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    });

    final state = ref.watch(friendInviteProvider);
    final notifier = ref.read(friendInviteProvider.notifier);
    final currentLink = state.currentLink;
    final isCreating = state.createStatus == FriendInviteActionStatus.loading;
    final isRevoking = state.revokeStatus == FriendInviteActionStatus.loading;
    final isAccepting = state.acceptStatus == FriendInviteAcceptStatus.loading;

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
          'Mời bạn bè',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InviteLinkCard(
                state: state,
                onCreate: isCreating ? null : () => notifier.createLink(),
                onCopyLink: currentLink == null
                    ? null
                    : () => _copyInviteUrl(currentLink),
                onCopyCode: currentLink == null
                    ? null
                    : () => _copyInviteCode(currentLink),
                onShare: currentLink == null
                    ? null
                    : () => _shareInvite(currentLink),
                onRevoke: currentLink == null || isRevoking
                    ? null
                    : () => notifier.revokeCurrentLink(),
                onRefresh: () => notifier.loadCurrentLink(),
              ),
              const SizedBox(height: 20),
              _AcceptCodeCard(
                controller: _tokenController,
                isAccepting: isAccepting,
                onAccept: () =>
                    notifier.acceptInviteByToken(_tokenController.text),
              ),
              if (state.acceptStatus == FriendInviteAcceptStatus.success &&
                  state.acceptedResult != null) ...[
                const SizedBox(height: 14),
                _AcceptSuccessCard(result: state.acceptedResult!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copyInviteUrl(FriendInviteLinkResponse link) async {
    await Clipboard.setData(ClipboardData(text: link.inviteUrl));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã sao chép link mời')));
  }

  Future<void> _copyInviteCode(FriendInviteLinkResponse link) async {
    final token = _extractToken(link.inviteUrl);
    await Clipboard.setData(ClipboardData(text: token));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã sao chép mã mời')));
  }

  Future<void> _shareInvite(FriendInviteLinkResponse link) async {
    final token = _extractToken(link.inviteUrl);
    final text =
        'Kết bạn với mình trên Locket.\n'
        'Mở app và nhập mã mời: $token\n'
        'Hoặc dùng link: ${link.inviteUrl}';
    await Share.share(text);
  }

  String _extractToken(String inviteUrl) {
    final parsed = Uri.tryParse(inviteUrl);
    final token = parsed?.queryParameters['token'];
    if (token != null && token.isNotEmpty) return token;
    return inviteUrl;
  }
}

class _InviteLinkCard extends StatelessWidget {
  const _InviteLinkCard({
    required this.state,
    required this.onCreate,
    required this.onCopyLink,
    required this.onCopyCode,
    required this.onShare,
    required this.onRevoke,
    required this.onRefresh,
  });

  final FriendInviteState state;
  final VoidCallback? onCreate;
  final VoidCallback? onCopyLink;
  final VoidCallback? onCopyCode;
  final VoidCallback? onShare;
  final VoidCallback? onRevoke;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final link = state.currentLink;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Link mời hiện tại',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onRefresh,
                icon: const Icon(
                  LucideIcons.refreshCw,
                  color: Colors.white70,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (state.currentStatus == FriendInviteCurrentStatus.loading)
            const LinearProgressIndicator(
              color: Color(0xFFFFD35A),
              minHeight: 3,
            )
          else if (state.currentStatus == FriendInviteCurrentStatus.empty)
            const Text(
              'Bạn chưa có link mời active.',
              style: TextStyle(color: Colors.white70),
            )
          else if (state.currentStatus == FriendInviteCurrentStatus.error)
            const Text(
              'Không tải được link hiện tại. Hãy thử làm mới.',
              style: TextStyle(color: Colors.redAccent),
            )
          else if (link != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  link.inviteUrl,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mã: ${link.tokenPreview} | Dùng ${link.usedCount}/${link.maxUses}',
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  'Hết hạn: ${link.expiresAt.toLocal()}',
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            )
          else
            const Text(
              'Nhấn tạo để có link mời mới.',
              style: TextStyle(color: Colors.white70),
            ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: onCreate,
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text('Tạo link'),
              ),
              OutlinedButton.icon(
                onPressed: onCopyLink,
                icon: const Icon(LucideIcons.link2, size: 16),
                label: const Text('Copy link'),
              ),
              OutlinedButton.icon(
                onPressed: onCopyCode,
                icon: const Icon(LucideIcons.copy, size: 16),
                label: const Text('Copy mã'),
              ),
              OutlinedButton.icon(
                onPressed: onShare,
                icon: const Icon(LucideIcons.send, size: 16),
                label: const Text('Chia sẻ'),
              ),
              TextButton(
                onPressed: onRevoke,
                child: const Text(
                  'Thu hồi link',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AcceptCodeCard extends StatelessWidget {
  const _AcceptCodeCard({
    required this.controller,
    required this.isAccepting,
    required this.onAccept,
  });

  final TextEditingController controller;
  final bool isAccepting;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tham gia bằng mã mời',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Nhập token mời',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.08),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAccepting ? null : onAccept,
              child: isAccepting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Chấp nhận lời mời'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AcceptSuccessCard extends StatelessWidget {
  const _AcceptSuccessCard({required this.result});

  final FriendInviteAcceptResponse result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Đã kết bạn với ${result.friend.displayName}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
