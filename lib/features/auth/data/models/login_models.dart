import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_models.freezed.dart';
part 'login_models.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String identifier,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String token,
    required String type,
    required String id,
    required String email,
    required String username,
    required bool isVerified,
    required bool profileCompleted,
    required String displayName,
    String? avatarUrl,
    required String nextStep,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
