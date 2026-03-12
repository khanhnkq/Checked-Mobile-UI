class ErrorResponse {
  final String timestamp;
  final int status;
  final String message;
  final String path;

  ErrorResponse({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.path,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        timestamp: json['timestamp'] as String,
        status: json['status'] as int,
        message: json['message'] as String,
        path: json['path'] as String,
      );
}
