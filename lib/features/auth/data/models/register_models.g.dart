// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  email: json['email'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'username': instance.username,
  'password': instance.password,
};

_$RegisterResponseImpl _$$RegisterResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterResponseImpl(
  message: json['message'] as String,
  email: json['email'] as String,
  nextStep: json['nextStep'] as String,
);

Map<String, dynamic> _$$RegisterResponseImplToJson(
  _$RegisterResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'email': instance.email,
  'nextStep': instance.nextStep,
};
