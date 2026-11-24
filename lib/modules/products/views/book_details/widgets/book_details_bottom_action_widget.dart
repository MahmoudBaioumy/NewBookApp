import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class BookDetailsBottomActionWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookDetailsBottomActionWidget({
    super.key,
    required this.onAddToCartTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final VoidCallback onAddToCartTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingScreen,
          vertical: Dimensions.paddingSizeDefault,
        ),
        child: SizedBox(
          width: double.infinity,
          height: Dimensions.bookDetailsButtonHeight,
          child: ElevatedButton(
            onPressed: onAddToCartTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              ),
            ),
            child: Text(
              AppStrings.addToCart.tx(),
              style: AppTextStyle.titleMedium.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
