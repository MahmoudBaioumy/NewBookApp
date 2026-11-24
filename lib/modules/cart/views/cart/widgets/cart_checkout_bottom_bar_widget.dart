import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class CartCheckoutBottomBarWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CartCheckoutBottomBarWidget({
    super.key,
    required this.totalPrice,
    required this.onCheckoutTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final double totalPrice;
  final VoidCallback onCheckoutTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: Dimensions.paddingScreen,
        end: Dimensions.paddingScreen,
        top: Dimensions.paddingSizeExtraSmall,
        bottom: Dimensions.paddingSizeSmall,
      ),
      child: Container(
        height: Dimensions.cartCheckoutBarHeight,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingScreen,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: Row(
          children: [
            // --------------------------[ Total Price Text ]-------------------------- //
            Expanded(child: _buildTotalPriceText()),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            // --------------------------[ CheckOut Button ]-------------------------- //
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildTotalPriceText ]-------------------------- //
  Widget _buildTotalPriceText() {
    return Text(
      '${AppStrings.totalPriceLabel.tx()} ${totalPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
      style: AppTextStyle.titleMedium.copyWith(
        color: AppColors.onPrimary,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // --------------------------[ _buildCheckoutButton ]-------------------------- //
  Widget _buildCheckoutButton() {
    return SizedBox(
      height: Dimensions.cartCheckoutButtonHeight,
      child: ElevatedButton(
        onPressed: onCheckoutTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onPrimary,
          foregroundColor: AppColors.primary,
          elevation: 0,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: Dimensions.cartCheckoutButtonHorizontalPadding,
          ),
          shape: const StadiumBorder(),
        ),
        child: Text(
          AppStrings.checkOut.tx(),
          style: AppTextStyle.titleSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
