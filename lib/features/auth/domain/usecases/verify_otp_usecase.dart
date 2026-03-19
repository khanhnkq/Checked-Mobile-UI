import '../../data/models/login_models.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthResponse?> call(String email, String otp) {
    return _repository.verifyOtp(email, otp);
  }
}

