import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/helper/dialogs/logout_dialog.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/auth/data/responses/login_response.dart';
import 'package:flutter/material.dart';

import '../../cubit/profile_cubit.dart';
import '../../data/requests/update_profile_request.dart';
import '../../data/responses/profile_response.dart';

class ProfileController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  ProfileController(this._profileCubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  final ProfileCubit _profileCubit;
  final CancelToken _cancel = CancelToken();
  final String profileState = UniqueKey().toString();
  final String updateProfileState = UniqueKey().toString();
  final String logoutState = UniqueKey().toString();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? _errorMessage;
  bool _isSettingsExpanded = false;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String? get errorMessage => _errorMessage;

  bool get isSettingsExpanded => _isSettingsExpanded;

  UserResponse? get profileUser =>
      _profileCubit.profileResponse?.data ?? AppSessionManager.user;

  bool get hasNoProfileData => profileUser == null;

  String? get userImage => profileUser?.image;

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() {
    _syncControllersWithUser(profileUser);
    _loadProfile();
  }

  // --------------------------[ onRetry ]-------------------------- //
  void onRetry() => _loadProfile();

  // --------------------------[ onToggleSettings ]-------------------------- //
  void onToggleSettings() {
    _isSettingsExpanded = !_isSettingsExpanded;
    notifyListeners();
  }

  // --------------------------[ onTapEditProfile ]-------------------------- //
  void onTapEditProfile() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    _updateProfile();
  }

  // --------------------------[ onTapLogout ]-------------------------- //
  void onTapLogout() {
    showLogoutConfirmationDialog(onConfirm: _logout);
  }

  // ========================== 🔒 Private methods 🔒 ========================== //
  // --------------------------[ _logout ]-------------------------- //
  Future<void> _logout() async {
    await safeLogout(
      cancelToken: _cancel,
      state: logoutState,
    );
  }

  // --------------------------[ _loadProfile ]-------------------------- //
  Future<void> _loadProfile() async {
    final res = await _profileCubit.getProfile(
      cancelToken: _cancel,
      state: profileState,
    );
    res.fold(
      (failure) {
        _errorMessage = failure.message;
        failure.showToast();
      },
      (ProfileResponse response) {
        _errorMessage = null;
        AppSessionManager.updateUserProfile(response.data);
        _syncControllersWithUser(response.data);
        notifyListeners();
      },
    );
  }

  // --------------------------[ _updateProfile ]-------------------------- //
  Future<void> _updateProfile() async {
    final request = UpdateProfileRequest(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      city: cityController.text.trim(),
      address: addressController.text.trim(),
    );

    final res = await _profileCubit.updateProfile(
      request: request,
      cancelToken: _cancel,
      state: updateProfileState,
    );
    res.fold(
      (failure) => failure.showToast(),
      (ProfileResponse response) {
        AppSessionManager.updateUserProfile(response.data);
        _syncControllersWithUser(response.data);
        if ((response.message ?? '').trim().isNotEmpty) {
          AppBotToast.show(response.message, type: ToastType.success);
        }
        notifyListeners();
      },
    );
  }

  // --------------------------[ _syncControllersWithUser ]-------------------------- //
  void _syncControllersWithUser(UserResponse? user) {
    if (user == null) return;
    nameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
    phoneController.text = user.phone ?? '';
    cityController.text = user.city ?? '';
    addressController.text = user.address ?? '';
  }

  @override
  void dispose() {
    _cancel.cancel();
    _profileCubit.disposeState(profileState);
    _profileCubit.disposeState(updateProfileState);
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
