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

import '../register_controller.dart';

class RegisterFormCardWidget extends StatelessWidget {
  final RegisterController controller;

  const RegisterFormCardWidget({
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
            // --------------------------[ Name Field ]-------------------------- //
            _buildNameField(),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Email Field ]-------------------------- //
            _buildEmailField(),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Password Field ]-------------------------- //
            _buildPasswordField(),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Confirm Password Field ]-------------------------- //
            _buildConfirmPasswordField(),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Phone Field ]-------------------------- //
            _buildPhoneField(),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ City Field ]-------------------------- //
            _buildCityField(),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            // --------------------------[ Submit Button ]-------------------------- //
            _buildSubmitButtonSection(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Name Field ]-------------------------- //
  Widget _buildNameField() {
    return TextFormField(
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: AppStrings.name.tx(),
        hintStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        prefixIcon: Icon(Icons.person, color: AppColors.primary),
      ),
      validator: AppValidators.validateEmpty.translated,
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

  // --------------------------[ Confirm Password Field ]-------------------------- //
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: controller.confirmPasswordController,
      obscureText: !controller.isPasswordVisible,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: AppStrings.confirmPassword.tx(),
        hintStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        prefixIcon: Icon(Icons.lock, color: AppColors.primary),
      ),
      validator: controller.validateConfirmPassword,
    );
  }

  // --------------------------[ Phone Field ]-------------------------- //
  Widget _buildPhoneField() {
    return TextFormField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: AppStrings.phone.tx(),
        hintStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        prefixIcon: Icon(Icons.phone, color: AppColors.primary),
      ),
      validator: AppValidators.phone.translated,
    );
  }

  // --------------------------[ City Field ]-------------------------- //
  Widget _buildCityField() {
    return TextFormField(
      controller: controller.cityController,
      keyboardType: TextInputType.text,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: AppStrings.city.tx(),
        hintStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        prefixIcon: Icon(Icons.location_city, color: AppColors.primary),
      ),
      validator: AppValidators.validateEmpty.translated,
    );
  }

  // --------------------------[ Submit Button Section ]-------------------------- //
  Widget _buildSubmitButtonSection() {
    return BlockBuilderWidget2<AuthCubit, dynamic>(
      types: [controller.registerState],
      body: (_, state) => _buildSubmitButton(isLoading: state == StateType.loading),
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
      onPressed: controller.onTapRegister,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, Dimensions.buttonHeightDefault),
      ),
      child: Text(AppStrings.register.tx()),
    );
  }
}
