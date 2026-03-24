import '../repositories/friend_invite_repository.dart';

class RevokeInviteLinkUseCase {
  RevokeInviteLinkUseCase(this._repository);

  final FriendInviteRepository _repository;

  Future<void> call() {
    return _repository.revokeCurrentInviteLink();
  }
}
