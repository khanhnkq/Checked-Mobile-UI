// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_invite_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendInviteLinkCreateRequestImpl
_$$FriendInviteLinkCreateRequestImplFromJson(Map<String, dynamic> json) =>
    _$FriendInviteLinkCreateRequestImpl(
      ttlMinutes: (json['ttlMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FriendInviteLinkCreateRequestImplToJson(
  _$FriendInviteLinkCreateRequestImpl instance,
) => <String, dynamic>{'ttlMinutes': instance.ttlMinutes};

_$FriendInviteLinkResponseImpl _$$FriendInviteLinkResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FriendInviteLinkResponseImpl(
  id: json['id'] as String,
  inviteUrl: json['inviteUrl'] as String,
  tokenPreview: json['tokenPreview'] as String,
  maxUses: (json['maxUses'] as num).toInt(),
  usedCount: (json['usedCount'] as num).toInt(),
  expiresAt: _dateTimeFromJson(json['expiresAt']),
  revokedAt: _nullableDateTimeFromJson(json['revokedAt']),
  status: json['status'] as String,
);

Map<String, dynamic> _$$FriendInviteLinkResponseImplToJson(
  _$FriendInviteLinkResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'inviteUrl': instance.inviteUrl,
  'tokenPreview': instance.tokenPreview,
  'maxUses': instance.maxUses,
  'usedCount': instance.usedCount,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'revokedAt': instance.revokedAt?.toIso8601String(),
  'status': instance.status,
};

_$FriendInviteAcceptRequestImpl _$$FriendInviteAcceptRequestImplFromJson(
  Map<String, dynamic> json,
) => _$FriendInviteAcceptRequestImpl(token: json['token'] as String);

Map<String, dynamic> _$$FriendInviteAcceptRequestImplToJson(
  _$FriendInviteAcceptRequestImpl instance,
) => <String, dynamic>{'token': instance.token};

_$FriendInviteAcceptResponseImpl _$$FriendInviteAcceptResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FriendInviteAcceptResponseImpl(
  friendshipId: json['friendshipId'] as String,
  status: json['status'] as String,
  friend: UserResponse.fromJson(json['friend'] as Map<String, dynamic>),
  acceptedAt: _dateTimeFromJson(json['acceptedAt']),
);

Map<String, dynamic> _$$FriendInviteAcceptResponseImplToJson(
  _$FriendInviteAcceptResponseImpl instance,
) => <String, dynamic>{
  'friendshipId': instance.friendshipId,
  'status': instance.status,
  'friend': instance.friend,
  'acceptedAt': instance.acceptedAt.toIso8601String(),
};
