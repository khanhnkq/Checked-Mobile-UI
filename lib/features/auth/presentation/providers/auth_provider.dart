import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/auth_models.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../profile/data/services/profile_service.dart';
import '../../../profile/data/models/profile_models.dart';

enum AuthStatus { unauthenticated, loading, otpPending, authenticated }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();
  final SecureStorageService _storageService = SecureStorageService();

  AuthStatus _status = AuthStatus.unauthenticated;
  String? _pendingEmail;
  AuthResponse? _authResponse;
  UserResponse? _userProfile;
  String? _errorMessage;

  AuthStatus get status => _status;
  String? get pendingEmail => _pendingEmail;
  AuthResponse? get authResponse => _authResponse;
  UserResponse? get userProfile => _userProfile;
  String? get errorMessage => _errorMessage;

  bool get isProfileIncomplete {
    if (_authResponse != null) {
      return _authResponse!.nextStep == 'COMPLETE_PROFILE' || !_authResponse!.profileCompleted;
    }
    if (_userProfile != null) {
      return !_userProfile!.profileCompleted;
    }
    return false;
  }

  Future<void> login(String identifier, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(identifier, password);
      if (response != null) {
        _authResponse = response;
        await _fetchUserProfile();
        _status = AuthStatus.authenticated;
      }
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      if (errorMsg == 'USER_NOT_VERIFIED') {
        _pendingEmail = identifier.contains('@') ? identifier : null;
        _status = AuthStatus.otpPending;
      } else {
        _errorMessage = errorMsg;
        _status = AuthStatus.unauthenticated;
      }
    }
    notifyListeners();
  }

  Future<void> register(String email, String username, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.register(email, username, password);
      _pendingEmail = email;
      _status = AuthStatus.otpPending;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> verifyOtp(String email, String otp) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(email, otp);
      if (response != null) {
        _authResponse = response;
        await _fetchUserProfile();
        _status = AuthStatus.authenticated;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AuthStatus.otpPending;
    }
    notifyListeners();
  }

  Future<void> _fetchUserProfile() async {
    try {
      _userProfile = await _profileService.getMe();
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  Future<bool> completeProfile({
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();
    try {
      final response = await _profileService.updateProfile(
        ProfileUpdateRequest(
          firstName: firstName,
          lastName: lastName,
          username: username,
        ),
      );
      if (response != null) {
        _userProfile = response;
        // Refresh me to sync profileCompleted state
        await _fetchUserProfile();
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    _status = AuthStatus.authenticated;
    notifyListeners();
    return false;
  }

  void logout() async {
    await _storageService.clearAll();
    _status = AuthStatus.unauthenticated;
    _authResponse = null;
    _userProfile = null;
    _pendingEmail = null;
    notifyListeners();
  }
}
