import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/auth_response_entity.dart';

abstract class AuthRemoteDataSource {
  // Method to signUp a user
  Future<Either<AuthResponseEntity, Failure>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });
}
