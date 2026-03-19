import '../../../profile/data/models/profile_models.dart';
import '../repositories/auth_repository.dart';

class GetMyProfileUseCase {
  const GetMyProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserResponse?> call() {
    return _repository.getMyProfile();
  }
}

