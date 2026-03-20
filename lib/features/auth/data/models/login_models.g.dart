// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      identifier: json['identifier'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'password': instance.password,
    };

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      token: json['token'] as String,
      type: json['type'] as String,
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      isVerified: json['isVerified'] as bool,
      profileCompleted: json['profileCompleted'] as bool,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      nextStep: json['nextStep'] as String,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'isVerified': instance.isVerified,
      'profileCompleted': instance.profileCompleted,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'nextStep': instance.nextStep,
    };
