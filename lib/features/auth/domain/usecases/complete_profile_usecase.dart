import '../../../profile/data/models/profile_models.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileUseCase {
  const CompleteProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserResponse?> call({
    required String firstName,
    required String lastName,
    String? username,
  }) {
    return _repository.completeProfile(
      firstName: firstName,
      lastName: lastName,
      username: username,
    );
  }
}

