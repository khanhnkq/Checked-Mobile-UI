import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_locator.dart';
import 'riverpod_notifiers/auth_notifier.dart';
import 'riverpod_notifiers/auth_state.dart';

// Export for use in other files
export 'riverpod_notifiers/auth_state.dart' show AuthStatus;

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authNotifier = AuthNotifier(
    repository: ref.watch(authRepositoryProvider),
  );
  // Auto-restore session on app launch
  authNotifier.restoreSession();
  return authNotifier;
});

// Selector providers for easier consumption
final authStatusProvider = Provider((ref) {
  return ref.watch(authProvider).status;
});

final isAuthenticatedProvider = Provider((ref) {
  return ref.watch(authProvider).status == AuthStatus.authenticated;
});

final currentUserIdProvider = Provider((ref) {
  return ref.watch(authProvider).currentUserId;
});

final userProfileProvider = Provider((ref) {
  return ref.watch(authProvider).userProfile;
});

final authResponseProvider = Provider((ref) {
  return ref.watch(authProvider).authResponse;
});

final pendingEmailProvider = Provider((ref) {
  return ref.watch(authProvider).pendingEmail;
});

final isProfileIncompleteProvider = Provider((ref) {
  return ref.watch(authProvider).isProfileIncomplete;
});

final isInitializingProvider = Provider((ref) {
  return ref.watch(authProvider).isInitializing;
});

final authErrorMessageProvider = Provider((ref) {
  return ref.watch(authProvider).errorMessage;
});

