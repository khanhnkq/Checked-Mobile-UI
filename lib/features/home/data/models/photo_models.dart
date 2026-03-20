import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_models.freezed.dart';
part 'photo_models.g.dart';

@freezed
class PhotoResponse with _$PhotoResponse {
  const factory PhotoResponse({
    required String id,
    required String senderId,
    required String senderDisplayName,
    String? senderAvatarUrl,
    required String imageUrl,
    required String thumbnailUrl,
    String? caption,
    double? amount,
    required String recipientScope,
    required int recipientCount,
    required String status,
    required String mimeType,
    required int fileSize,
    required int width,
    required int height,
    required DateTime takenAt,
    required DateTime createdAt,
  }) = _PhotoResponse;

  factory PhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotoResponseFromJson(json);
}

@Freezed(genericArgumentFactories: true)
class SliceResponse<T> with _$SliceResponse<T> {
  const factory SliceResponse({
    required List<T> content,
    required int number,
    required int size,
    required bool first,
    required bool last,
    required int numberOfElements,
    required bool empty,
  }) = _SliceResponse<T>;

  factory SliceResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$SliceResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class PageResponse<T> with _$PageResponse<T> {
  const factory PageResponse({
    required List<T> content,
    required int number,
    required int size,
    required bool first,
    required bool last,
    required int numberOfElements,
    required bool empty,
    required int totalElements,
    required int totalPages,
  }) = _PageResponse<T>;

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PageResponseFromJson(json, fromJsonT);
}
