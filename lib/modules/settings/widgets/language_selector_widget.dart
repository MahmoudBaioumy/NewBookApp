import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/localization_supported_data.dart';
import 'package:flutter/material.dart';

class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;
    // Register dependency on Theme to automatically rebuild when dark mode changes
    final _ = Theme.of(context);

    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.selectorContainerPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Dimensions.selectorContainerRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            'EN',
            isSelected: currentLang == 'en',
            onTap: () {
              if (currentLang == 'en') return;
              final enOption = AppLocalizationController.supportedLanguagesMap['en'];
              if (enOption == null) return;
              AppLocalizationController.changeLanguage(enOption);
              if (mounted) setState(() {});
            },
          ),
          _buildTab(
            'AR',
            isSelected: currentLang == 'ar',
            onTap: () {
              if (currentLang == 'ar') return;
              final arOption = AppLocalizationController.supportedLanguagesMap['ar'];
              if (arOption == null) return;
              AppLocalizationController.changeLanguage(arOption);
              if (mounted) setState(() {});
            },
          ),
          _buildTab(
            'DE',
            isSelected: currentLang == 'de',
            onTap: () {
              if (currentLang == 'de') return;
              final deOption = AppLocalizationController.supportedLanguagesMap['de'];
              if (deOption == null) return;
              AppLocalizationController.changeLanguage(deOption);
              if (mounted) setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.selectorTabHorizontalPadding,
          vertical: Dimensions.selectorTabVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.selectorTabRadius),
        ),
        child: Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
