import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class CheckoutBottomBarWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CheckoutBottomBarWidget({
    super.key,
    required this.totalPrice,
    required this.isLoading,
    required this.onOrderNowTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final double totalPrice;
  final bool isLoading;
  final VoidCallback onOrderNowTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
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
              // --------------------------[ Order Now Button ]-------------------------- //
              _buildOrderNowButton(),
            ],
          ),
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

  // --------------------------[ _buildOrderNowButton ]-------------------------- //
  Widget _buildOrderNowButton() {
    if (isLoading) {
      return ShimmerHelper.buildBasicShimmer(
        height: Dimensions.cartCheckoutButtonHeight,
        width: Dimensions.cartCheckoutButtonShimmerWidth,
        radios: Dimensions.radiusPill,
      );
    }

    return SizedBox(
      height: Dimensions.cartCheckoutButtonHeight,
      child: ElevatedButton(
        onPressed: onOrderNowTap,
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
          AppStrings.orderNow.tx(),
          style: AppTextStyle.titleSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
