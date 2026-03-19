import '../../data/models/login_models.dart';
import '../../../profile/data/models/profile_models.dart';

abstract class AuthRepository {
  Future<String?> getStoredToken();
  Future<AuthResponse?> login(String identifier, String password);
  Future<void> register(String email, String username, String password);
  Future<AuthResponse?> verifyOtp(String email, String otp);
  Future<UserResponse?> getMyProfile();
  Future<UserResponse?> completeProfile({
    required String firstName,
    required String lastName,
    String? username,
  });
  Future<void> clearSession();
}

