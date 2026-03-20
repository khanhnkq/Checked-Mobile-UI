import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
class ProfileUpdateRequest with _$ProfileUpdateRequest {
  const factory ProfileUpdateRequest({
    String? username,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  }) = _ProfileUpdateRequest;

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);
}

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    required String id,
    required String email,
    required String username,
    String? firstName,
    String? lastName,
    required String displayName,
    String? avatarUrl,
    required bool isVerified,
    required bool isGoldMember,
    required bool profileCompleted,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
