import '../../../../core/storage/secure_storage_service.dart';
import '../../../profile/data/models/profile_models.dart';
import '../../../profile/data/services/profile_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_models.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    AuthService? authService,
    ProfileService? profileService,
    SecureStorageService? storageService,
  })  : _authService = authService ?? AuthService(),
        _profileService = profileService ?? ProfileService(),
        _storageService = storageService ?? SecureStorageService();

  final AuthService _authService;
  final ProfileService _profileService;
  final SecureStorageService _storageService;

  @override
  Future<String?> getStoredToken() {
    return _storageService.getToken();
  }

  @override
  Future<AuthResponse?> login(String identifier, String password) {
    return _authService.login(identifier, password);
  }

  @override
  Future<void> register(String email, String username, String password) async {
    await _authService.register(email, username, password);
  }

  @override
  Future<AuthResponse?> verifyOtp(String email, String otp) {
    return _authService.verifyOtp(email, otp);
  }

  @override
  Future<UserResponse?> getMyProfile() {
    return _profileService.getMe();
  }

  @override
  Future<UserResponse?> completeProfile({
    required String firstName,
    required String lastName,
    String? username,
  }) {
    return _profileService.updateProfile(
      ProfileUpdateRequest(
        firstName: firstName,
        lastName: lastName,
        username: username,
      ),
    );
  }

  @override
  Future<void> clearSession() {
    return _storageService.clearAll();
  }
}

