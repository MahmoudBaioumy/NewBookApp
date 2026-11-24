import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/default_app_response.dart';
import 'package:flustra_template/core/constants/app_api.dart';

import '../../../core/common/error_handler/failure.dart';
import '../../../core/helper/shared_methods.dart';
import 'requests/register_request.dart';
import 'responses/login_response.dart';

abstract class AuthRepo {
  // -------------------------- login --------------------------
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
    CancelToken? cancelToken,
  });

  // -------------------------- register --------------------------
  Future<Either<Failure, AuthResponse>> register({
    required RegisterRequest registerRequest,
    CancelToken? cancelToken,
  });

  // -------------------------- logout --------------------------
  Future<Either<Failure, DefaultAppResponse>> logout({
    CancelToken? cancelToken,
  });
}

class AuthImp implements AuthRepo {
  // -------------------------- login --------------------------
  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse(
      endPoint: ApiConstants.auth.login,
      asObject: (e) => AuthResponse.fromJson(e),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  // -------------------------- register --------------------------
  @override
  Future<Either<Failure, AuthResponse>> register({
    required RegisterRequest registerRequest,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse(
      endPoint: ApiConstants.auth.register,
      asObject: (e) => AuthResponse.fromJson(e),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: registerRequest.toJson(),
    );
  }

  // -------------------------- logout --------------------------
  @override
  Future<Either<Failure, DefaultAppResponse>> logout({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<DefaultAppResponse>(
      endPoint: ApiConstants.auth.logout,
      asObject: (e) => DefaultAppResponse.fromJson(e),
      method: DioMethod.post,
      cancelToken: cancelToken,
    );
  }
}
