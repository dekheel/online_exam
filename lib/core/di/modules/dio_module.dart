import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/di/di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constants/api_constants.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio provideDio() {
    // Implementation for providing Dio instance
    Dio dio = Dio();
    dio.options.headers = {'Content-Type': 'application/json'};
    dio.options.baseUrl = ApiConst.baseUrl;
    dio.interceptors.add(getIt<PrettyDioLogger>());
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    // Implementation for providing PrettyDioLogger instance
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
    );
  }
}
