import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flustra_template/core/services/console_printer.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../cubit/auth_cubit.dart';
import '../data/requests/register_request.dart';
import '../data/responses/login_response.dart';

class RegisterController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  RegisterController(this._authCubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  final AuthCubit _authCubit;
  final CancelToken _cancel = CancelToken();
  final String registerState = UniqueKey().toString();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  bool _isPasswordVisible = false;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  bool get isPasswordVisible => _isPasswordVisible;

  // ========================== 🔥 initialization 🔥 ========================== //
  void init() {
    if (kDebugMode) {
      nameController.text = "";
      emailController.text = "";
      passwordController.text = "";
      confirmPasswordController.text = "";
      phoneController.text = "";
      cityController.text = "";
    }
  }

  // ========================== 🌍 Public events 🌍 ========================== //

  // --------------------------[ onTogglePasswordVisibility ]-------------------------- //
  void onTogglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // --------------------------[ validateConfirmPassword ]-------------------------- //
  String? validateConfirmPassword(String? value) {
    return AppValidators.confirmPassword(passwordController.text, value)?.message;
  }

  // --------------------------[ onTapRegister ]-------------------------- //
  void onTapRegister() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    _register();
  }

  // --------------------------[ onTapLogin ]-------------------------- //
  void onTapLogin() {
    "Login redirect tapped".printWithColor();
    navigateTo(AppRoutes.login, type: NavigationType.replace);
  }

  // ========================== 🔒 Private methods 🔒 ========================== //

  // --------------------------[ _register ]-------------------------- //
  Future<void> _register() async {
    final res = await _authCubit.register(
      registerRequest: RegisterRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        phone: phoneController.text.trim(),
        city: cityController.text.trim(),
      ),
      cancelToken: _cancel,
      state: registerState,
    );
    res.fold((Failure f) => f.showToast(), (AuthResponse model) {
      if (model.data == null) return;
      AppSessionManager.updateUser(model);
      HomeScreenWithNavigationBar.navigateToMe(HomeScreenWithNavigationBarData(initialPage: MainScreenPageType.home));
    });
  }

  @override
  void dispose() {
    _cancel.cancel();
    _authCubit.disposeState(registerState);
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
