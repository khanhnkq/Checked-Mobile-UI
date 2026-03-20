// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      timestamp: json['timestamp'] as String,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'message': instance.message,
      'path': instance.path,
    };
