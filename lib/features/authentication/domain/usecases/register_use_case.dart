import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/authentication/domain/entities/auth_response_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/auth_repositories/auth_repository_contract.dart';

@injectable
class RegisterUseCase {
  final AuthRepositoryContract _AuthRepositoryContract;

  RegisterUseCase(this._AuthRepositoryContract);

  Future<Either<AuthResponseEntity, Failure>> invoke({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    return await _AuthRepositoryContract.register(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }
}
