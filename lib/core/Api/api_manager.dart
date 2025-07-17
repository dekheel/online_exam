import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/constants/api_constants.dart';

@singleton
class ApiManager {
  final dio = Dio();

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
  }) async {
    return dio.get(
      ApiConst.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(validateStatus: (status) => true, headers: headers),
    );
  }

  Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? body,
    Map<String, dynamic>? headers,
  }) async {
    return dio.post(
      ApiConst.baseUrl + endPoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(validateStatus: (status) => true, headers: headers),
    );
  }
}
