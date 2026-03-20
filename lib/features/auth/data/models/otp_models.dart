import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_models.freezed.dart';
part 'otp_models.g.dart';

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String email,
    required String otp,
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}
