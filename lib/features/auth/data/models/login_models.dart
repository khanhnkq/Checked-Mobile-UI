class LoginRequest {
  final String identifier;
  final String password;

  LoginRequest({
    required this.identifier,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'password': password,
      };
}

class AuthResponse {
  final String token;
  final String type;
  final String id;
  final String email;
  final String username;
  final bool isVerified;
  final bool profileCompleted;
  final String displayName;
  final String? avatarUrl;
  final String nextStep;

  AuthResponse({
    required this.token,
    required this.type,
    required this.id,
    required this.email,
    required this.username,
    required this.isVerified,
    required this.profileCompleted,
    required this.displayName,
    this.avatarUrl,
    required this.nextStep,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
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
}
