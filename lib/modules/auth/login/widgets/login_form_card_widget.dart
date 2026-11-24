import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flustra_template/modules/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import '../login_controller.dart';

class LoginFormCardWidget extends StatelessWidget {
  final LoginController controller;

  const LoginFormCardWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
        vertical: Dimensions.paddingSizeExtraLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
        border: Border.all(
          color: AppColors.primary,
          width: Dimensions.borderWidthDefault,
        ),
      ),
      child: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --------------------------[ Email Field ]-------------------------- //
            _buildEmailField(),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Password Field ]-------------------------- //
            _buildPasswordField(),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            // --------------------------[ Submit Button ]-------------------------- //
            _buildSubmitButtonSection(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Email Field ]-------------------------- //
  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: AppStrings.email.tx(),
        hintStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        prefixIcon: Icon(Icons.email, color: AppColors.primary),
      ),
      validator: AppValidators.email.translated,
    );
  }

  // --------------------------[ Password Field ]-------------------------- //
  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: AppStrings.password.tx(),
        hintStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        prefixIcon: Icon(Icons.lock, color: AppColors.primary),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.primary,
          ),
          onPressed: controller.onTogglePasswordVisibility,
        ),
      ),
      validator: AppValidators.passwordSimple.translated,
    );
  }

  // --------------------------[ Submit Button Section ]-------------------------- //
  Widget _buildSubmitButtonSection() {
    return BlockBuilderWidget2<AuthCubit, dynamic>(
      types: [controller.loginState],
      body: (_, state) => _buildSubmitButton(isLoading: state == StateType.loading || controller.isLoading),
    );
  }

  // --------------------------[ Submit Button ]-------------------------- //
  Widget _buildSubmitButton({required bool isLoading}) {
    if (isLoading) {
      return ShimmerHelper.buildBasicShimmer(
        height: Dimensions.buttonHeightDefault,
        radios: Dimensions.radiusPill,
      );
    }

    return ElevatedButton(
      onPressed: controller.onTapLogin,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, Dimensions.buttonHeightDefault),
      ),
      child: Text(AppStrings.login.tx()),
    );
  }
}
