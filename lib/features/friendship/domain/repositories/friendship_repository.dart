import '../../../profile/data/models/profile_models.dart';

abstract class FriendshipRepository {
  Future<List<UserResponse>> getFriendships();
}
