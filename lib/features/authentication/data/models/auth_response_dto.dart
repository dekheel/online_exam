import 'package:online_exam/features/authentication/domain/entities/auth_response_entity.dart';

class AuthResponseDto extends AuthResponseEntity {
  AuthResponseDto({super.message, super.code, super.token, super.user});

  AuthResponseDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
  }
}

class UserDto extends UserEntity {
  UserDto({
    super.id,
    super.username,
    super.firstName,
    super.lastName,
    super.email,
    super.phone,
    super.role,
    super.isVerified,
    super.createdAt,
  });

  UserDto.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
  }
}
