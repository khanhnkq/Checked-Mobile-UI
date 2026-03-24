import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/friend_invite_models.dart';

part 'friend_invite_state.freezed.dart';

enum FriendInviteCurrentStatus { idle, loading, ready, empty, error }

enum FriendInviteActionStatus { idle, loading, success, error }

enum FriendInviteAcceptStatus {
  idle,
  loading,
  success,
  invalid,
  expired,
  maxUses,
  error,
}

@freezed
class FriendInviteState with _$FriendInviteState {
  const factory FriendInviteState({
    FriendInviteLinkResponse? currentLink,
    @Default(FriendInviteCurrentStatus.idle)
    FriendInviteCurrentStatus currentStatus,
    @Default(FriendInviteActionStatus.idle)
    FriendInviteActionStatus createStatus,
    @Default(FriendInviteActionStatus.idle)
    FriendInviteActionStatus revokeStatus,
    @Default(FriendInviteAcceptStatus.idle)
    FriendInviteAcceptStatus acceptStatus,
    FriendInviteAcceptResponse? acceptedResult,
    String? errorMessage,
  }) = _FriendInviteState;

  factory FriendInviteState.initial() => const FriendInviteState();
}
