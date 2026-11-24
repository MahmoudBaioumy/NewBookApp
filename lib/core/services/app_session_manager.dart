import '../../modules/auth/data/responses/login_response.dart';
import '../data/cache/cache_key.dart';

class AppSessionManager {
  AppSessionManager._();

  static AuthResponse? _user;

  static UserResponse? get user => _user?.data?.user;

  static String? get name => user?.name;

  static String? get email => user?.email;

  static String? get phone => user?.phone;

  static String? get city => user?.city;

  static String? get address => user?.address;

  static String? get image => user?.image;

  static bool get isEmailVerified => user?.emailVerified ?? false;

  static String? get token {
    if (_user == null) {
      init();
    }
    return _user?.data?.token;
  }

  static String get userId => user?.id?.toString() ?? "";

  static bool get amILogin => token?.isNotEmpty ?? false;

  static void updateUserToken(String token) {
    if (_user?.data != null) {
      _user!.data!.token = token;
      updateUser(_user);
    }
  }

  static void updateUserProfile(UserResponse? updatedUser) {
    if (updatedUser == null) return;
    _user ??= AuthResponse(data: AuthDataResponse());
    _user!.data ??= AuthDataResponse();
    _user!.data!.user = updatedUser;
    updateUser(_user);
  }

  /// Logout the user and clear session
  static void logout() {
    updateUser(null);
  }

  /// pass null that mean user will removes
  static void updateUser(AuthResponse? authResponse) {
    _user = authResponse;

    if (authResponse == null) {
      AppCache.remove(key: CacheKey.loginResponse);
      return;
    }

    AppCache.saveData(key: CacheKey.loginResponse, value: _user?.toJson());
  }

  static void init() {
    try {
      var res = AppCache.getMap(key: CacheKey.loginResponse);
      if (res != null) {
        _user = AuthResponse.fromJson(res);
      }
    } catch (e) {
      // Clear corrupted cache
      AppCache.remove(key: CacheKey.loginResponse);
    }
  }
}
