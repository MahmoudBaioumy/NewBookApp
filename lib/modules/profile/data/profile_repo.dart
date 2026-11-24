import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';

import 'requests/update_profile_request.dart';
import 'responses/profile_response.dart';

abstract class ProfileRepo {
  // --------------------------[ getProfile ]-------------------------- //
  Future<Either<Failure, ProfileResponse>> getProfile({
    CancelToken? cancelToken,
  });

  // --------------------------[ updateProfile ]-------------------------- //
  Future<Either<Failure, ProfileResponse>> updateProfile({
    required UpdateProfileRequest request,
    CancelToken? cancelToken,
  });
}

class ProfileImp implements ProfileRepo {
  // --------------------------[ getProfile ]-------------------------- //
  @override
  Future<Either<Failure, ProfileResponse>> getProfile({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<ProfileResponse>(
      endPoint: ApiConstants.profile.profile,
      asObject: (json) => ProfileResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ updateProfile ]-------------------------- //
  @override
  Future<Either<Failure, ProfileResponse>> updateProfile({
    required UpdateProfileRequest request,
    CancelToken? cancelToken,
  }) async {
    final formData = await request.toFormData();
    return await handleResponse<ProfileResponse>(
      endPoint: ApiConstants.profile.updateProfile,
      asObject: (json) => ProfileResponse.fromJson(json),
      method: DioMethod.post,
      data: formData,
      cancelToken: cancelToken,
    );
  }
}
