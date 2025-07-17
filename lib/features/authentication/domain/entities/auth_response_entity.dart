class AuthResponseEntity {
  AuthResponseEntity({this.message, this.token, this.user, this.code});

  String? message;
  String? code;
  String? token;
  UserEntity? user;
}

class UserEntity {
  UserEntity({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
  });

  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? createdAt;
}
