import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class WishlistEmptyWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const WishlistEmptyWidget({super.key});

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(
          Dimensions.paddingSizeExtraLarge,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --------------------------[ Favorite Icon ]-------------------------- //
            _buildIconContainer(),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            // --------------------------[ Empty Title ]-------------------------- //
            _buildTitle(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ Empty Description ]-------------------------- //
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildIconContainer ]-------------------------- //
  Widget _buildIconContainer() {
    return Container(
      width: Dimensions.emptyStateIconContainerSize,
      height: Dimensions.emptyStateIconContainerSize,
      decoration: BoxDecoration(
        color: AppColors.primaryTint,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.favorite_border_rounded,
        size: Dimensions.emptyStateIconSize,
        color: AppColors.primary,
      ),
    );
  }

  // --------------------------[ _buildTitle ]-------------------------- //
  Widget _buildTitle() {
    return Text(
      AppStrings.noFavoritesYet.tx(),
      textAlign: TextAlign.center,
      style: AppTextStyle.titleMedium.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // --------------------------[ _buildDescription ]-------------------------- //
  Widget _buildDescription() {
    return Text(
      AppStrings.noFavoritesYetDesc.tx(),
      textAlign: TextAlign.center,
      style: AppTextStyle.bodyMedium.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
    );
  }
}
