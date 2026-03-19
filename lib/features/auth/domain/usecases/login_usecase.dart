import '../../data/models/login_models.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthResponse?> call(String identifier, String password) {
	return _repository.login(identifier, password);
  }
}

