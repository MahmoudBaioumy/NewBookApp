import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeSelectorWidget extends StatefulWidget {
  const ThemeSelectorWidget({super.key});

  @override
  State<ThemeSelectorWidget> createState() => _ThemeSelectorWidgetState();
}

class _ThemeSelectorWidgetState extends State<ThemeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.selectorContainerPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Dimensions.selectorContainerRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Light Mode Sun Icon
          GestureDetector(
            onTap: () {
              if (!isDark) return;
              AppSettingsCubit.i.changeTheme(ThemeModeType.light);
              if (mounted) setState(() {});
            },
            child: Container(
              padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                color: !isDark ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wb_sunny_outlined,
                size: Dimensions.selectorIconSize,
                color: !isDark ? AppColors.onPrimary : AppColors.onSurfaceVariant,
              ),
            ),
          ),
          // Dark Mode Moon Icon
          GestureDetector(
            onTap: () {
              if (isDark) return;
              AppSettingsCubit.i.changeTheme(ThemeModeType.dark);
              if (mounted) setState(() {});
            },
            child: Container(
              padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                color: isDark ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.nightlight_round_outlined,
                size: Dimensions.selectorIconSize,
                color: isDark ? AppColors.onPrimary : AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
