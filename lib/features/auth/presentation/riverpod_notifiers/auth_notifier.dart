import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
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
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  late final LoginUseCase _loginUseCase;
  late final RegisterUseCase _registerUseCase;
  late final VerifyOtpUseCase _verifyOtpUseCase;
  late final RestoreSessionUseCase _restoreSessionUseCase;
  late final GetMyProfileUseCase _getMyProfileUseCase;
  late final CompleteProfileUseCase _completeProfileUseCase;
  late final LogoutUseCase _logoutUseCase;

  AuthNotifier({AuthRepository? repository})
      : _repository = repository ?? AuthRepositoryImpl(),
        super(AuthState.initial()) {
    _loginUseCase = LoginUseCase(_repository);
    _registerUseCase = RegisterUseCase(_repository);
    _verifyOtpUseCase = VerifyOtpUseCase(_repository);
    _restoreSessionUseCase = RestoreSessionUseCase(_repository);
    _getMyProfileUseCase = GetMyProfileUseCase(_repository);
    _completeProfileUseCase = CompleteProfileUseCase(_repository);
    _logoutUseCase = LogoutUseCase(_repository);

    DioClient().onUnauthorized = logout;
  }

  Future<void> restoreSession() async {
    state = state.copyWith(errorMessage: null);

    try {
      final token = await _restoreSessionUseCase.call();
      if (token == null || token.isEmpty) {
        await _resetSession(clearStorage: false);
        return;
      }

      state = state.copyWith(status: AuthStatus.authenticated);

      await _refreshProfile(token: token);
    } catch (e) {
      appLogger.e('Error restoring session', error: e);
      await _resetSession();
    } finally {
      state = state.copyWith(isInitializing: false);
    }
  }

  Future<void> login(String identifier, String password) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      final response = await _loginUseCase.call(identifier, password);
      if (response != null) {
        state = state.copyWith(authResponse: response);
        await _refreshProfile(token: response.token);
        state = state.copyWith(status: AuthStatus.authenticated);
      }
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      if (errorMsg == 'USER_NOT_VERIFIED') {
        state = state.copyWith(
          pendingEmail: identifier.contains('@') ? identifier : null,
          status: AuthStatus.otpPending,
        );
      } else {
        state = state.copyWith(
          errorMessage: errorMsg,
          status: AuthStatus.unauthenticated,
        );
      }
    }
  }

  Future<void> register(String email, String username, String password) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      await _registerUseCase.call(email, username, password);
      state = state.copyWith(
        pendingEmail: email,
        status: AuthStatus.otpPending,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        status: AuthStatus.unauthenticated,
      );
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      final response = await _verifyOtpUseCase.call(email, otp);
      if (response != null) {
        state = state.copyWith(authResponse: response);
        await _refreshProfile(token: response.token);
        state = state.copyWith(status: AuthStatus.authenticated);
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        status: AuthStatus.otpPending,
      );
    }
  }

  Future<void> _refreshProfile({required String token}) async {
    try {
      final profile = await _getMyProfileUseCase.call();
      if (profile != null) {
        state = state.copyWith(
          userProfile: profile,
          authResponse: AuthResponse(
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
          ),
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

    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      authResponse: null,
      userProfile: null,
      pendingEmail: null,
    );
  }

  Future<bool> completeProfile({
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final response = await _completeProfileUseCase.call(
        firstName: firstName,
        lastName: lastName,
        username: username,
      );
      if (response != null) {
        state = state.copyWith(userProfile: response);
        final token = state.authResponse?.token;
        if (token != null && token.isNotEmpty) {
          await _refreshProfile(token: token);
        }
        state = state.copyWith(status: AuthStatus.authenticated);
        return true;
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
    state = state.copyWith(status: AuthStatus.authenticated);
    return false;
  }

  Future<void> logout() async {
    await _resetSession();
  }
}

