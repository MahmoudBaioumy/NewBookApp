import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class CheckoutShimmerWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CheckoutShimmerWidget({super.key});

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --------------------------[ Scrollable Form & Order Summary Shimmer ]-------------------------- //
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------------------------[ Customer Info Section Shimmer ]-------------------------- //
                _buildSectionTitleShimmer(),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                _buildUserInfoCardShimmer(),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                // --------------------------[ Order Summary Section Shimmer ]-------------------------- //
                _buildSectionTitleShimmer(),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                _buildOrderSummaryCardShimmer(),
              ],
            ),
          ),
        ),
        // --------------------------[ Bottom Bar Shimmer ]-------------------------- //
        _buildBottomBarShimmer(),
      ],
    );
  }

  // --------------------------[ _buildSectionTitleShimmer ]-------------------------- //
  Widget _buildSectionTitleShimmer() {
    return ShimmerHelper.buildBasicShimmer(
      height: Dimensions.checkoutSectionTitleShimmerHeight,
      width: Dimensions.checkoutSectionTitleShimmerWidth,
      radios: Dimensions.radiusExtraSmall,
    );
  }

  // --------------------------[ _buildUserInfoCardShimmer ]-------------------------- //
  Widget _buildUserInfoCardShimmer() {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          Dimensions.checkoutUserFieldShimmerCount,
          (index) => Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: index == Dimensions.checkoutUserFieldShimmerCount - 1
                  ? 0
                  : Dimensions.paddingScreen,
            ),
            child: ShimmerHelper.buildBasicShimmer(
              height: Dimensions.profileFieldShimmerHeight,
              radios: Dimensions.radiusDefault,
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------[ _buildOrderSummaryCardShimmer ]-------------------------- //
  Widget _buildOrderSummaryCardShimmer() {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(
          color: AppColors.outline,
          width: Dimensions.borderWidthThin,
        ),
      ),
      child: Column(
        children: List.generate(
          Dimensions.checkoutOrderItemShimmerCount,
          (index) => Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: index == Dimensions.checkoutOrderItemShimmerCount - 1
                  ? 0
                  : Dimensions.paddingSizeDefault,
            ),
            child: ShimmerHelper.buildBasicShimmer(
              height: Dimensions.checkoutOrderItemShimmerHeight,
              radios: Dimensions.radiusExtraSmall,
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------[ _buildBottomBarShimmer ]-------------------------- //
  Widget _buildBottomBarShimmer() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: Dimensions.paddingScreen,
          end: Dimensions.paddingScreen,
          top: Dimensions.paddingSizeExtraSmall,
          bottom: Dimensions.paddingSizeSmall,
        ),
        child: ShimmerHelper.buildBasicShimmer(
          height: Dimensions.cartCheckoutBarHeight,
          width: double.infinity,
          radios: Dimensions.radiusDefault,
        ),
      ),
    );
  }
}
