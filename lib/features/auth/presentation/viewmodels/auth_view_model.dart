import 'package:flutter/material.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../../../profile/data/models/profile_models.dart';
import '../../data/models/login_models.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/complete_profile_usecase.dart';
import '../../domain/usecases/get_my_profile_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/restore_session_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

enum AuthStatus { unauthenticated, loading, otpPending, authenticated }

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepositoryImpl() {
    _loginUseCase = LoginUseCase(_repository);
    _registerUseCase = RegisterUseCase(_repository);
    _verifyOtpUseCase = VerifyOtpUseCase(_repository);
    _restoreSessionUseCase = RestoreSessionUseCase(_repository);
    _getMyProfileUseCase = GetMyProfileUseCase(_repository);
    _completeProfileUseCase = CompleteProfileUseCase(_repository);
    _logoutUseCase = LogoutUseCase(_repository);

    DioClient().onUnauthorized = logout;
  }

  final AuthRepository _repository;
  late final LoginUseCase _loginUseCase;
  late final RegisterUseCase _registerUseCase;
  late final VerifyOtpUseCase _verifyOtpUseCase;
  late final RestoreSessionUseCase _restoreSessionUseCase;
  late final GetMyProfileUseCase _getMyProfileUseCase;
  late final CompleteProfileUseCase _completeProfileUseCase;
  late final LogoutUseCase _logoutUseCase;

  AuthStatus _status = AuthStatus.unauthenticated;
  bool _isInitializing = true;
  String? _pendingEmail;
  AuthResponse? _authResponse;
  UserResponse? _userProfile;
  String? _errorMessage;

  AuthStatus get status => _status;
  bool get isInitializing => _isInitializing;
  String? get pendingEmail => _pendingEmail;
  AuthResponse? get authResponse => _authResponse;
  UserResponse? get userProfile => _userProfile;
  String? get errorMessage => _errorMessage;
  String? get currentUserId => _userProfile?.id ?? _authResponse?.id;

  bool get isProfileIncomplete {
    if (_authResponse != null) {
      return _authResponse!.nextStep == 'COMPLETE_PROFILE' ||
          !_authResponse!.profileCompleted;
    }
    if (_userProfile != null) {
      return !_userProfile!.profileCompleted;
    }
    return false;
  }

  Future<void> restoreSession() async {
    _errorMessage = null;

    try {
      final token = await _restoreSessionUseCase.call();
      if (token == null || token.isEmpty) {
        await _resetSession(clearStorage: false);
        return;
      }

      _status = AuthStatus.authenticated;
      notifyListeners();

      await _refreshProfile(token: token);
    } catch (e) {
      appLogger.e('Error restoring session', error: e);
      await _resetSession();
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }

  Future<void> login(String identifier, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _loginUseCase.call(identifier, password);
      if (response != null) {
        _authResponse = response;
        await _refreshProfile(token: response.token);
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
      await _registerUseCase.call(email, username, password);
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
      final response = await _verifyOtpUseCase.call(email, otp);
      if (response != null) {
        _authResponse = response;
        await _refreshProfile(token: response.token);
        _status = AuthStatus.authenticated;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AuthStatus.otpPending;
    }
    notifyListeners();
  }

  Future<void> _refreshProfile({required String token}) async {
    try {
      final profile = await _getMyProfileUseCase.call();
      if (profile != null) {
        _userProfile = profile;
        _authResponse = AuthResponse(
          token: token,
          type: 'Bearer',
          id: profile.id,
          email: profile.email,
          username: profile.username,
          isVerified: profile.isVerified,
          profileCompleted: profile.profileCompleted,
          displayName: profile.displayName,
          avatarUrl: profile.avatarUrl,
          nextStep: profile.profileCompleted ? 'HOME' : 'COMPLETE_PROFILE',
        );
      }
    } catch (e) {
      appLogger.w('Silent error fetching profile (possibly offline): $e');
    }
  }

  Future<void> _resetSession({bool clearStorage = true}) async {
    if (clearStorage) {
      await _logoutUseCase.call();
    }

    _status = AuthStatus.unauthenticated;
    _authResponse = null;
    _userProfile = null;
    _pendingEmail = null;
  }

  Future<bool> completeProfile({
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();
    try {
      final response = await _completeProfileUseCase.call(
        firstName: firstName,
        lastName: lastName,
        username: username,
      );
      if (response != null) {
        _userProfile = response;
        final token = _authResponse?.token;
        if (token != null && token.isNotEmpty) {
          await _refreshProfile(token: token);
        }
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

  Future<void> logout() async {
    await _resetSession();
    notifyListeners();
  }
}

