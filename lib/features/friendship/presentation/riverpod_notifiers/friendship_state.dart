import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../profile/data/models/profile_models.dart';

part 'friendship_state.freezed.dart';

@freezed
class FriendshipState with _$FriendshipState {
  const factory FriendshipState({
    @Default([]) List<UserResponse> friends,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _FriendshipState;

  factory FriendshipState.initial() => const FriendshipState();
}
