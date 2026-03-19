import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/login_models.dart';
import '../../../profile/data/models/profile_models.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { unauthenticated, loading, otpPending, authenticated }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    required bool isInitializing,
    String? pendingEmail,
    AuthResponse? authResponse,
    UserResponse? userProfile,
    String? errorMessage,
  }) = _AuthState;

  const AuthState._();

  String? get currentUserId => userProfile?.id ?? authResponse?.id;

  bool get isProfileIncomplete {
    if (authResponse != null) {
      return authResponse!.nextStep == 'COMPLETE_PROFILE' ||
          !authResponse!.profileCompleted;
    }
    if (userProfile != null) {
      return !userProfile!.profileCompleted;
    }
    return false;
  }

  factory AuthState.initial() => const AuthState(
    status: AuthStatus.unauthenticated,
    isInitializing: true,
    pendingEmail: null,
    authResponse: null,
    userProfile: null,
    errorMessage: null,
  );
}

