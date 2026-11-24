import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class LoginRedirectPromptWidget extends StatelessWidget {
  final VoidCallback onActionTap;

  const LoginRedirectPromptWidget({
    super.key,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // --------------------------[ Prompt Text ]-------------------------- //
        Flexible(
          child: Text(
            AppStrings.dontHaveAnAccount.tx(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.titleSmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        // --------------------------[ Action Link ]-------------------------- //
        _buildActionLink(),
      ],
    );
  }

  // --------------------------[ Action Link ]-------------------------- //
  Widget _buildActionLink() {
    return InkWell(
      onTap: onActionTap,
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall,
          vertical: Dimensions.paddingSizeExtraSmall,
        ),
        child: Text(
          AppStrings.register.tx(),
          style: AppTextStyle.titleSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
