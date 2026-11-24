import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/default_app_response.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/auth/cubit/auth_cubit.dart';
import 'package:flustra_template/modules/cart/cubit/cart_cubit.dart';
import 'package:flustra_template/modules/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';

import 'common_dialog.dart';

Future<void> safeLogout({
  CancelToken? cancelToken,
  dynamic state,
}) async {
  popIfUCan();
  final res = await AuthCubit.i.logout(
    cancelToken: cancelToken,
    state: state,
  );
  res.fold(
    (Failure failure) => failure.showToast(),
    (DefaultAppResponse response) {
      if ((response.message ?? '').trim().isNotEmpty) {
        AppBotToast.show(response.message, type: ToastType.success);
      }
      ProfileCubit.i.profileResponse = null;
      CartCubit.i.clearCartData();
      AppSessionManager.logout();
      navigateTo(AppRoutes.login, type: NavigationType.finish);
    },
  );
}

/// 🚪 Logout Dialog
Future<bool?> showLogoutConfirmationDialog({
  VoidCallback? onConfirm,
}) async {
  return await showCommonDialog(
    imagePath: AppAssetsImages.other.loggingOut,
    title: AppStrings.logout.tx(),
    description: AppStrings.logoutDesc.tx(),
    confirmText: AppStrings.yesLogOut.tx(),
    onConfirm: onConfirm ?? safeLogout,
  );
}
