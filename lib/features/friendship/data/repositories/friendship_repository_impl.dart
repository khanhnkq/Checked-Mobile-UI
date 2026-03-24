import '../../domain/repositories/friendship_repository.dart';
import '../../../profile/data/models/profile_models.dart';
import '../services/friendship_service.dart';

class FriendshipRepositoryImpl implements FriendshipRepository {
  FriendshipRepositoryImpl({FriendshipService? service})
    : _service = service ?? FriendshipService();

  final FriendshipService _service;

  @override
  Future<List<UserResponse>> getFriendships() {
    return _service.getFriendships();
  }
}
