import 'package:dartz/dartz.dart';
import 'package:online_exam/features/authentication/domain/entities/auth_response_entity.dart';

import '../../../../../core/errors/failure.dart';

/// AuthenticationRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract class AuthRepositoryContract {
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
