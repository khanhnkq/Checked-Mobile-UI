import '../../data/models/friend_invite_models.dart';
import '../repositories/friend_invite_repository.dart';

class CreateInviteLinkUseCase {
  CreateInviteLinkUseCase(this._repository);

  final FriendInviteRepository _repository;

  Future<FriendInviteLinkResponse> call({int? ttlMinutes}) {
    return _repository.createInviteLink(ttlMinutes: ttlMinutes);
  }
}
