import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/Api/api_manager.dart';
import 'package:online_exam/core/constants/api_constants.dart';
import 'package:online_exam/core/errors/failure.dart';
import '../../domain/repositories/auth_data_source_contract/auth_remote_data_source.dart';
import '../models/auth_response_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;
  AuthRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<Either<AuthResponseDto, Failure>> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    final List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    if (connectivityResults.isEmpty ||
        connectivityResults.contains(ConnectivityResult.none)) {
      return Right(NetworkFailure(message: 'No internet connection'));
    }

    var response = await apiManager.postData(
      endPoint: ApiConst.signUpEndPoint,
      body: {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phone,
      },
    );

    print(response.data);
    var registerResponse = AuthResponseDto.fromJson(response.data);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return Left(registerResponse);
    } else {
      return Right(
        ServerFailure(message: registerResponse.message ?? "Server error"),
      );
    }
  }
}
