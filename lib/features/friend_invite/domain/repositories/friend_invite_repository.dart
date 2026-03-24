import '../../data/models/friend_invite_models.dart';

abstract class FriendInviteRepository {
  Future<FriendInviteLinkResponse> createInviteLink({int? ttlMinutes});

  Future<FriendInviteLinkResponse?> getCurrentInviteLink();

  Future<void> revokeCurrentInviteLink();

  Future<FriendInviteAcceptResponse> acceptInvite({required String token});
}
