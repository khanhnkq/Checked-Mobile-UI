class ProfileUpdateRequest {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;

  ProfileUpdateRequest({
    this.username,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
        if (username != null) 'username': username,
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
      };
}

class UserResponse {
  final String id;
  final String email;
  final String username;
  final String? firstName;
  final String? lastName;
  final String displayName;
  final String? avatarUrl;
  final bool isVerified;
  final bool isGoldMember;
  final bool profileCompleted;

  UserResponse({
    required this.id,
    required this.email,
    required this.username,
    this.firstName,
    this.lastName,
    required this.displayName,
    this.avatarUrl,
    required this.isVerified,
    required this.isGoldMember,
    required this.profileCompleted,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json['id'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        displayName: json['displayName'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        isVerified: json['isVerified'] as bool,
        isGoldMember: json['isGoldMember'] as bool,
        profileCompleted: json['profileCompleted'] as bool,
      );
}
