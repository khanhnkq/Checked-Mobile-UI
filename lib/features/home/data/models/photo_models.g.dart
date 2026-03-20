// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoResponseImpl _$$PhotoResponseImplFromJson(Map<String, dynamic> json) =>
    _$PhotoResponseImpl(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderDisplayName: json['senderDisplayName'] as String,
      senderAvatarUrl: json['senderAvatarUrl'] as String?,
      imageUrl: json['imageUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      caption: json['caption'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      recipientScope: json['recipientScope'] as String,
      recipientCount: (json['recipientCount'] as num).toInt(),
      status: json['status'] as String,
      mimeType: json['mimeType'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      takenAt: DateTime.parse(json['takenAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PhotoResponseImplToJson(_$PhotoResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderDisplayName': instance.senderDisplayName,
      'senderAvatarUrl': instance.senderAvatarUrl,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'caption': instance.caption,
      'amount': instance.amount,
      'recipientScope': instance.recipientScope,
      'recipientCount': instance.recipientCount,
      'status': instance.status,
      'mimeType': instance.mimeType,
      'fileSize': instance.fileSize,
      'width': instance.width,
      'height': instance.height,
      'takenAt': instance.takenAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$SliceResponseImpl<T> _$$SliceResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$SliceResponseImpl<T>(
  content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
  number: (json['number'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  first: json['first'] as bool,
  last: json['last'] as bool,
  numberOfElements: (json['numberOfElements'] as num).toInt(),
  empty: json['empty'] as bool,
);

Map<String, dynamic> _$$SliceResponseImplToJson<T>(
  _$SliceResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance.content.map(toJsonT).toList(),
  'number': instance.number,
  'size': instance.size,
  'first': instance.first,
  'last': instance.last,
  'numberOfElements': instance.numberOfElements,
  'empty': instance.empty,
};

_$PageResponseImpl<T> _$$PageResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$PageResponseImpl<T>(
  content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
  number: (json['number'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  first: json['first'] as bool,
  last: json['last'] as bool,
  numberOfElements: (json['numberOfElements'] as num).toInt(),
  empty: json['empty'] as bool,
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$$PageResponseImplToJson<T>(
  _$PageResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance.content.map(toJsonT).toList(),
  'number': instance.number,
  'size': instance.size,
  'first': instance.first,
  'last': instance.last,
  'numberOfElements': instance.numberOfElements,
  'empty': instance.empty,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
};
