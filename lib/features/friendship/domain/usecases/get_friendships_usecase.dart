import '../../../profile/data/models/profile_models.dart';
import '../repositories/friendship_repository.dart';

class GetFriendshipsUseCase {
  GetFriendshipsUseCase(this._repository);

  final FriendshipRepository _repository;

  Future<List<UserResponse>> call() {
    return _repository.getFriendships();
  }
}
