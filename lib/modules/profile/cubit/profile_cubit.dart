import 'package:dio/dio.dart';
import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';

import '../data/profile_repo.dart';
import '../data/requests/update_profile_request.dart';
import '../data/responses/profile_response.dart';

enum ProfileCubitTypes { none, getProfile, updateProfile }

class ProfileCubit extends BaseCubit<dynamic> {
  final ProfileRepo _repo;

  ProfileCubit(this._repo) : super(ProfileCubitTypes.none);

  static ProfileCubit get i => getIt<ProfileCubit>();

  // ========================== 🔥 Data Cache 🔥 ========================== //
  ProfileResponse? profileResponse;

  // --------------------------[ getProfile ]-------------------------- //
  BaseEitherResponse<ProfileResponse> getProfile({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<ProfileResponse>(
      type: state ?? ProfileCubitTypes.getProfile,
      fun: () => _repo.getProfile(cancelToken: cancelToken),
      onSuccess: (response) => profileResponse = response,
      onFailure: (failure) => failure.printInfo('getProfile'),
    );
  }

  // --------------------------[ updateProfile ]-------------------------- //
  BaseEitherResponse<ProfileResponse> updateProfile({
    required UpdateProfileRequest request,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<ProfileResponse>(
      type: state ?? ProfileCubitTypes.updateProfile,
      fun: () => _repo.updateProfile(
        request: request,
        cancelToken: cancelToken,
      ),
      onSuccess: (response) => profileResponse = response,
      onFailure: (failure) => failure.printInfo('updateProfile'),
    );
  }
}
