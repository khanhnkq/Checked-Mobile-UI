import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/service_locator.dart';
import 'riverpod_notifiers/friend_invite_notifier.dart';
import 'riverpod_notifiers/friend_invite_state.dart';

final friendInviteProvider =
    StateNotifierProvider<FriendInviteNotifier, FriendInviteState>((ref) {
      return FriendInviteNotifier(
        repository: ref.watch(friendInviteRepositoryProvider),
      );
    });
