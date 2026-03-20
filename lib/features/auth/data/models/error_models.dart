import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_models.freezed.dart';
part 'error_models.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    required String timestamp,
    required int status,
    required String message,
    required String path,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
