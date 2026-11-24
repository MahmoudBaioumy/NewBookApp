import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flutter/material.dart';

import '../profile_controller.dart';
import 'profile_settings_section_widget.dart';

class ProfileInfoCardWidget extends StatelessWidget {
  final ProfileController controller;

  const ProfileInfoCardWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
      ),
      child: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --------------------------[ Name Field ]-------------------------- //
            _buildProfileField(
              fieldController: controller.nameController,
              label: AppStrings.name.tx(),
              icon: Icons.person,
              keyboardType: TextInputType.name,
              validator: AppValidators.validateEmpty.translated,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Email Field (Read-Only) ]-------------------------- //
            _buildProfileField(
              fieldController: controller.emailController,
              label: AppStrings.email.tx(),
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Phone Field ]-------------------------- //
            _buildProfileField(
              fieldController: controller.phoneController,
              label: AppStrings.phone.tx(),
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ City Field ]-------------------------- //
            _buildProfileField(
              fieldController: controller.cityController,
              label: AppStrings.city.tx(),
              icon: Icons.apartment,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Address Field ]-------------------------- //
            _buildProfileField(
              fieldController: controller.addressController,
              label: AppStrings.address.tx(),
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: Dimensions.paddingScreen),
            // --------------------------[ Settings Button & Options ]-------------------------- //
            ProfileSettingsSectionWidget(
              isExpanded: controller.isSettingsExpanded,
              onToggleTap: controller.onToggleSettings,
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Profile Text Field ]-------------------------- //
  Widget _buildProfileField({
    required TextEditingController fieldController,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: fieldController,
      readOnly: readOnly,
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
