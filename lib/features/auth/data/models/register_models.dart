class RegisterRequest {
  final String email;
  final String username;
  final String password;

  RegisterRequest({
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
      };
}

class RegisterResponse {
  final String message;
  final String email;
  final String nextStep;

  RegisterResponse({
    required this.message,
    required this.email,
    required this.nextStep,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        message: json['message'] as String,
        email: json['email'] as String,
        nextStep: json['nextStep'] as String,
      );
}
