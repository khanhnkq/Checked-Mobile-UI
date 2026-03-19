import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(String email, String username, String password) {
	return _repository.register(email, username, password);
  }
}

