import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/service_locator.dart';
import 'riverpod_notifiers/friendship_notifier.dart';
import 'riverpod_notifiers/friendship_state.dart';

final friendshipProvider =
    StateNotifierProvider<FriendshipNotifier, FriendshipState>((ref) {
      return FriendshipNotifier(
        repository: ref.watch(friendshipRepositoryProvider),
      );
    });

final friendsProvider = Provider(
  (ref) => ref.watch(friendshipProvider).friends,
);

final friendsCountProvider = Provider(
  (ref) => ref.watch(friendshipProvider).friends.length,
);
