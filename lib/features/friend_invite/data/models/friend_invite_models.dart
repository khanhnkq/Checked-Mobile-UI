import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../profile/data/models/profile_models.dart';

part 'friend_invite_models.freezed.dart';
part 'friend_invite_models.g.dart';

DateTime _dateTimeFromJson(Object? value) {
  if (value is String && value.isNotEmpty) {
    return DateTime.parse(value);
  }
  return DateTime.now();
}

DateTime? _nullableDateTimeFromJson(Object? value) {
  if (value is String && value.isNotEmpty) {
    return DateTime.parse(value);
  }
  return null;
}

@freezed
class FriendInviteLinkCreateRequest with _$FriendInviteLinkCreateRequest {
  const factory FriendInviteLinkCreateRequest({int? ttlMinutes}) =
      _FriendInviteLinkCreateRequest;

  factory FriendInviteLinkCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendInviteLinkCreateRequestFromJson(json);
}

@freezed
class FriendInviteLinkResponse with _$FriendInviteLinkResponse {
  const factory FriendInviteLinkResponse({
    required String id,
    required String inviteUrl,
    required String tokenPreview,
    required int maxUses,
    required int usedCount,
    @JsonKey(fromJson: _dateTimeFromJson) required DateTime expiresAt,
    @JsonKey(fromJson: _nullableDateTimeFromJson) DateTime? revokedAt,
    required String status,
  }) = _FriendInviteLinkResponse;

  factory FriendInviteLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendInviteLinkResponseFromJson(json);
}

@freezed
class FriendInviteAcceptRequest with _$FriendInviteAcceptRequest {
  const factory FriendInviteAcceptRequest({required String token}) =
      _FriendInviteAcceptRequest;

  factory FriendInviteAcceptRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendInviteAcceptRequestFromJson(json);
}

@freezed
class FriendInviteAcceptResponse with _$FriendInviteAcceptResponse {
  const factory FriendInviteAcceptResponse({
    required String friendshipId,
    required String status,
    required UserResponse friend,
    @JsonKey(fromJson: _dateTimeFromJson) required DateTime acceptedAt,
  }) = _FriendInviteAcceptResponse;

  factory FriendInviteAcceptResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendInviteAcceptResponseFromJson(json);
}
