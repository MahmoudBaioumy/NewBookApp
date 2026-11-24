import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class CartShimmerWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CartShimmerWidget({super.key});

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --------------------------[ Cart Items Shimmer List ]-------------------------- //
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only(
              start: Dimensions.paddingScreen,
              end: Dimensions.paddingScreen,
              bottom: Dimensions.paddingSizeDefault,
            ),
            itemCount: Dimensions.bookListShimmerItemCount,
            separatorBuilder: (_, __) => const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            itemBuilder: (_, __) => _buildShimmerCard(),
          ),
        ),
        // --------------------------[ Bottom Checkout Bar Shimmer ]-------------------------- //
        _buildBottomBarShimmer(),
      ],
    );
  }

  // --------------------------[ _buildShimmerCard ]-------------------------- //
  Widget _buildShimmerCard() {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeH),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(
          color: AppColors.outline,
          width: Dimensions.borderWidthThin,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------[ Cover Shimmer ]-------------------------- //
          ShimmerHelper.buildBasicShimmer(
            width: Dimensions.bookListCardImageWidth,
            height: Dimensions.bookListCardImageHeight,
            radios: Dimensions.radiusSmall,
          ),
          const SizedBox(width: Dimensions.paddingSizeDefault),
          // --------------------------[ Content Shimmer ]-------------------------- //
          Expanded(child: _buildContentShimmer()),
        ],
      ),
    );
  }

  // --------------------------[ _buildContentShimmer ]-------------------------- //
  Widget _buildContentShimmer() {
    return SizedBox(
      height: Dimensions.bookListCardImageHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --------------------------[ Header Row Shimmer ]-------------------------- //
          _buildHeaderShimmer(),
          // --------------------------[ Footer Row Shimmer ]-------------------------- //
          _buildFooterShimmer(),
        ],
      ),
    );
  }

  // --------------------------[ _buildHeaderShimmer ]-------------------------- //
  Widget _buildHeaderShimmer() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: Dimensions.paddingSizeTiny,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ShimmerHelper.buildBasicShimmer(
              height: Dimensions.bookListTitleShimmerHeight,
              width: double.infinity,
              radios: Dimensions.radiusExtraSmall,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          ShimmerHelper.buildBasicShimmer(
            height: Dimensions.iconSizeDefault,
            width: Dimensions.iconSizeDefault,
            radios: Dimensions.radiusExtraSmall,
          ),
        ],
      ),
    );
  }

  // --------------------------[ _buildFooterShimmer ]-------------------------- //
  Widget _buildFooterShimmer() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: Dimensions.paddingSizeExtraSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ShimmerHelper.buildBasicShimmer(
            height: Dimensions.cartQuantityBoxHeight,
            width: Dimensions.cartQuantityBoxShimmerWidth,
            radios: Dimensions.radiusExtraSmall,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShimmerHelper.buildBasicShimmer(
                height: Dimensions.bookListPriceShimmerHeight,
                width: Dimensions.bookListPriceShimmerWidth,
                radios: Dimensions.radiusExtraSmall,
              ),
              const SizedBox(height: Dimensions.paddingSizeMini),
              ShimmerHelper.buildBasicShimmer(
                height: Dimensions.bookListPriceShimmerHeight,
                width: Dimensions.bookListPriceShimmerWidth,
                radios: Dimensions.radiusExtraSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------[ _buildBottomBarShimmer ]-------------------------- //
  Widget _buildBottomBarShimmer() {
    return Padding(
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
    );
  }
}
