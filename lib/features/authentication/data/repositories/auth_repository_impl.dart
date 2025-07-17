import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failure.dart';
import 'package:online_exam/features/authentication/domain/entities/auth_response_entity.dart';
import '../../domain/repositories/auth_data_source_contract/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repositories/auth_repository_contract.dart';

@Injectable(as: AuthRepositoryContract)
class AuthRepositoryImpl implements AuthRepositoryContract {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<AuthResponseEntity, Failure>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    var either = await authRemoteDataSource.register(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );

    return either.fold(
      (response) {
        return Left(response);
      },
      (error) {
        return Right(error);
      },
    );
  }
}
