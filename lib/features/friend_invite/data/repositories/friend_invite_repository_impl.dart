import '../../domain/repositories/friend_invite_repository.dart';
import '../models/friend_invite_models.dart';
import '../services/friend_invite_service.dart';

class FriendInviteRepositoryImpl implements FriendInviteRepository {
  FriendInviteRepositoryImpl({FriendInviteService? service})
    : _service = service ?? FriendInviteService();

  final FriendInviteService _service;

  @override
  Future<FriendInviteLinkResponse> createInviteLink({int? ttlMinutes}) {
    return _service.createInviteLink(ttlMinutes: ttlMinutes);
  }

  @override
  Future<FriendInviteLinkResponse?> getCurrentInviteLink() async {
    try {
      return await _service.getCurrentInviteLink();
    } on FriendInviteApiException catch (e) {
      if (e.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  @override
  Future<void> revokeCurrentInviteLink() {
    return _service.revokeCurrentInviteLink();
  }

  @override
  Future<FriendInviteAcceptResponse> acceptInvite({required String token}) {
    return _service.acceptInvite(token: token);
  }
}
