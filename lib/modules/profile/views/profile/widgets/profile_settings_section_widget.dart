import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/modules/settings/widgets/language_selector_widget.dart';
import 'package:flustra_template/modules/settings/widgets/theme_selector_widget.dart';
import 'package:flutter/material.dart';

class ProfileSettingsSectionWidget extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleTap;

  const ProfileSettingsSectionWidget({
    super.key,
    required this.isExpanded,
    required this.onToggleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --------------------------[ Settings Toggle Button ]-------------------------- //
        _buildSettingsButton(),
        if (isExpanded) ...[
          const SizedBox(height: Dimensions.paddingSizeH),
          // --------------------------[ Expanded Settings Options ]-------------------------- //
          _buildExpandedSettingsCard(),
        ],
      ],
    );
  }

  // --------------------------[ Settings Toggle Button ]-------------------------- //
  Widget _buildSettingsButton() {
    return InkWell(
      onTap: onToggleTap,
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingSizeH,
          vertical: Dimensions.paddingSizeDefault,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          border: Border.all(
            color: isExpanded ? AppColors.primary : AppColors.outline,
            width: Dimensions.borderWidthThin,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.settings_outlined,
              color: AppColors.primary,
              size: Dimensions.iconSizeDefault,
            ),
            const SizedBox(width: Dimensions.paddingSizeH),
            Expanded(
              child: Text(
                AppStrings.settings.tx(),
                style: AppTextStyle.titleSmall.copyWith(
                  color: AppColors.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppColors.primary,
              size: Dimensions.iconSizeDefault,
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Expanded Settings Options ]-------------------------- //
  Widget _buildExpandedSettingsCard() {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeH),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(
          color: AppColors.outlineVariant,
          width: Dimensions.borderWidthThin,
        ),
      ),
      child: Column(
        children: [
          // --------------------------[ Language Option ]-------------------------- //
          _buildLanguageRow(),
          const SizedBox(height: Dimensions.paddingSizeH),
          Divider(
            height: Dimensions.borderWidthThin,
            color: AppColors.outlineVariant,
          ),
          const SizedBox(height: Dimensions.paddingSizeH),
          // --------------------------[ Theme (Dark / Light Mode) Option ]-------------------------- //
          _buildThemeRow(),
        ],
      ),
    );
  }

  // --------------------------[ Language Row ]-------------------------- //
  Widget _buildLanguageRow() {
    return Row(
      children: [
        Icon(
          Icons.language_outlined,
          color: AppColors.primary,
          size: Dimensions.iconSizeDefault,
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          child: Text(
            AppStrings.language.tx(),
            style: AppTextStyle.titleSmall.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const LanguageSelectorWidget(),
      ],
    );
  }

  // --------------------------[ Theme Row ]-------------------------- //
  Widget _buildThemeRow() {
    final currentThemeLabel = AppColors.isDark
        ? AppStrings.darkMode.tx()
        : AppStrings.lightMode.tx();

    return Row(
      children: [
        Icon(
          Icons.dark_mode_outlined,
          color: AppColors.primary,
          size: Dimensions.iconSizeDefault,
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.theme.tx(),
                style: AppTextStyle.titleSmall.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                currentThemeLabel,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const ThemeSelectorWidget(),
      ],
    );
  }
}
