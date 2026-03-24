import '../../data/models/friend_invite_models.dart';
import '../repositories/friend_invite_repository.dart';

class GetCurrentInviteLinkUseCase {
  GetCurrentInviteLinkUseCase(this._repository);

  final FriendInviteRepository _repository;

  Future<FriendInviteLinkResponse?> call() {
    return _repository.getCurrentInviteLink();
  }
}
