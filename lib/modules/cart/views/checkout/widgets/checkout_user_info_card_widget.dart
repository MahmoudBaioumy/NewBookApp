import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flutter/material.dart';

import '../checkout_controller.dart';

class CheckoutUserInfoCardWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CheckoutUserInfoCardWidget({
    super.key,
    required this.controller,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final CheckoutController controller;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------[ Section Title ]-------------------------- //
        _buildSectionTitle(),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        // --------------------------[ Form Container ]-------------------------- //
        _buildFormContainer(),
      ],
    );
  }

  // --------------------------[ _buildSectionTitle ]-------------------------- //
  Widget _buildSectionTitle() {
    return Text(
      AppStrings.customerInformation.tx(),
      style: AppTextStyle.titleMedium.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // --------------------------[ _buildFormContainer ]-------------------------- //
  Widget _buildFormContainer() {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
        border: Border.all(
          color: AppColors.outlineVariant,
          width: Dimensions.borderWidthThin,
        ),
      ),
      child: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --------------------------[ Name Field ]-------------------------- //
            _buildTextField(
              fieldController: controller.nameController,
              label: AppStrings.name.tx(),
              icon: Icons.person,
              keyboardType: TextInputType.name,
              validator: AppValidators.validateEmpty.translated,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Email Field ]-------------------------- //
            _buildTextField(
              fieldController: controller.emailController,
              label: AppStrings.email.tx(),
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.email.translated,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Phone Field ]-------------------------- //
            _buildTextField(
              fieldController: controller.phoneController,
              label: AppStrings.phone.tx(),
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: AppValidators.validateEmpty.translated,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Address Field ]-------------------------- //
            _buildTextField(
              fieldController: controller.addressController,
              label: AppStrings.address.tx(),
              icon: Icons.location_on_outlined,
              validator: AppValidators.validateEmpty.translated,
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildTextField ]-------------------------- //
  Widget _buildTextField({
    required TextEditingController fieldController,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: fieldController,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.titleSmall.copyWith(color: AppColors.primary),
        floatingLabelStyle: AppTextStyle.bodyMedium.copyWith(
          color: AppColors.primary,
        ),
        prefixIcon: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}
