import '../../data/models/friend_invite_models.dart';
import '../repositories/friend_invite_repository.dart';

class AcceptInviteUseCase {
  AcceptInviteUseCase(this._repository);

  final FriendInviteRepository _repository;

  Future<FriendInviteAcceptResponse> call({required String token}) {
    return _repository.acceptInvite(token: token);
  }
}
