import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../riverpod_providers.dart';

class FriendshipScreen extends ConsumerStatefulWidget {
  const FriendshipScreen({super.key});

  @override
  ConsumerState<FriendshipScreen> createState() => _FriendshipScreenState();
}

class _FriendshipScreenState extends ConsumerState<FriendshipScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(friendshipProvider.notifier).fetchFriendships(force: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final friendshipState = ref.watch(friendshipProvider);
    final friends = friendshipState.friends;

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Bạn bè (${friends.length})',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userPlus, color: Colors.white),
            onPressed: () => context.push('/friend-invite'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(friendshipProvider.notifier).refreshFriendships(),
        child: friendshipState.isLoading && friends.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFFFFD35A)),
              )
            : friends.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 160),
                  Center(
                    child: Text(
                      'Bạn chưa có bạn bè nào.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              )
            : ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    tileColor: const Color(0xFF1C1B15),
                    leading: CircleAvatar(
                      backgroundImage: friend.avatarUrl != null
                          ? NetworkImage(friend.avatarUrl!)
                          : null,
                      child: friend.avatarUrl == null
                          ? const Icon(LucideIcons.user, size: 18)
                          : null,
                    ),
                    title: Text(
                      friend.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '@${friend.username}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: friends.length,
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/friend-invite'),
        backgroundColor: const Color(0xFFFFD35A),
        foregroundColor: Colors.black,
        icon: const Icon(LucideIcons.userPlus2, size: 18),
        label: const Text('Mời bạn'),
      ),
    );
  }
}
