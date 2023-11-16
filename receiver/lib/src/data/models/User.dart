class UserEntity {
  final String? token;
  final List location;

  UserEntity({required this.token, required this.location});

  factory UserEntity.fromMap(Map<String, dynamic> data) {
    return UserEntity(
      token: data['token'],
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fcmToken': token,
      'locate': location,
    };
  }
}
