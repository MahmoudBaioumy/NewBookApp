import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/default_app_response.dart';
import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';

import '../data/auth_repo.dart';
import '../data/requests/register_request.dart';
import '../data/responses/login_response.dart';

enum AuthCubitTypes { none, login, register, logout }

class AuthCubit extends BaseCubit<dynamic> {
  final AuthRepo _repo;

  AuthCubit(this._repo) : super(AuthCubitTypes.none);

  static AuthCubit get i => getIt<AuthCubit>();

  // ========================== 🔥 login 🔥 ==========================
  BaseEitherResponse<AuthResponse> login({
    required String email,
    required String password,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire(
      type: state ?? AuthCubitTypes.login,
      fun: () => _repo.login(
        email: email,
        password: password,
        cancelToken: cancelToken,
      ),
      onSuccess: noOp,
      onFailure: (failure) => failure.printInfo("login"),
    );
  }

  // ========================== 🔥 register 🔥 ==========================
  BaseEitherResponse<AuthResponse> register({
    required RegisterRequest registerRequest,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire(
      type: state ?? AuthCubitTypes.register,
      fun: () => _repo.register(
        registerRequest: registerRequest,
        cancelToken: cancelToken,
      ),
      onSuccess: noOp,
      onFailure: (failure) => failure.printInfo("register"),
    );
  }

  // ========================== 🔥 logout 🔥 ==========================
  BaseEitherResponse<DefaultAppResponse> logout({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<DefaultAppResponse>(
      type: state ?? AuthCubitTypes.logout,
      fun: () => _repo.logout(cancelToken: cancelToken),
      onSuccess: noOp,
      onFailure: (failure) => failure.printInfo("logout"),
    );
  }
}
