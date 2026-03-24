import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/friendship_repository.dart';
import '../../domain/usecases/get_friendships_usecase.dart';
import 'friendship_state.dart';

class FriendshipNotifier extends StateNotifier<FriendshipState> {
  FriendshipNotifier({required FriendshipRepository repository})
    : _repository = repository,
      super(FriendshipState.initial()) {
    _getFriendshipsUseCase = GetFriendshipsUseCase(_repository);
  }

  final FriendshipRepository _repository;
  late final GetFriendshipsUseCase _getFriendshipsUseCase;

  Future<void> fetchFriendships({bool force = false}) async {
    if (state.isLoading) return;
    if (!force && state.friends.isNotEmpty) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final friendships = await _getFriendshipsUseCase.call();
      state = state.copyWith(friends: friendships, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> refreshFriendships() => fetchFriendships(force: true);
}
