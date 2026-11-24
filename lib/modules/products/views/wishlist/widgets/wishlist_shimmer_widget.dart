import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class WishlistShimmerWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const WishlistShimmerWidget({super.key});

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.only(
        start: Dimensions.paddingScreen,
        end: Dimensions.paddingScreen,
        bottom: Dimensions.paddingSizeExtraLarge,
      ),
      itemCount: Dimensions.bookListShimmerItemCount,
      separatorBuilder: (_, __) => const SizedBox(
        height: Dimensions.paddingSizeDefault,
      ),
      itemBuilder: (_, __) => _buildShimmerCard(),
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
          // --------------------------[ Details Shimmer ]-------------------------- //
          Expanded(child: _buildDetailsShimmer()),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // --------------------------[ Actions Shimmer ]-------------------------- //
          _buildActionsShimmer(),
        ],
      ),
    );
  }

  // --------------------------[ _buildDetailsShimmer ]-------------------------- //
  Widget _buildDetailsShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimensions.paddingSizeTiny),
        // --------------------------[ Title Shimmer ]-------------------------- //
        ShimmerHelper.buildBasicShimmer(
          height: Dimensions.bookListTitleShimmerHeight,
          width: double.infinity,
          radios: Dimensions.radiusExtraSmall,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        // --------------------------[ Category Shimmer ]-------------------------- //
        ShimmerHelper.buildBasicShimmer(
          height: Dimensions.bookListSubtitleShimmerHeight,
          width: Dimensions.bookListSubtitleShimmerWidth,
          radios: Dimensions.radiusExtraSmall,
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        // --------------------------[ Original Price Shimmer ]-------------------------- //
        ShimmerHelper.buildBasicShimmer(
          height: Dimensions.bookListPriceShimmerHeight,
          width: Dimensions.bookListPriceShimmerWidth,
          radios: Dimensions.radiusExtraSmall,
        ),
        const SizedBox(height: Dimensions.paddingSizeMini),
        // --------------------------[ Discounted Price Shimmer ]-------------------------- //
        ShimmerHelper.buildBasicShimmer(
          height: Dimensions.bookListPriceShimmerHeight,
          width: Dimensions.bookListPriceShimmerWidth,
          radios: Dimensions.radiusExtraSmall,
        ),
      ],
    );
  }

  // --------------------------[ _buildActionsShimmer ]-------------------------- //
  Widget _buildActionsShimmer() {
    return SizedBox(
      height: Dimensions.bookListCardImageHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --------------------------[ Favorite Icon Shimmer ]-------------------------- //
          ShimmerHelper.buildBasicShimmer(
            height: Dimensions.iconSizeLarge,
            width: Dimensions.iconSizeLarge,
            radios: Dimensions.radiusExtraSmall,
          ),
          // --------------------------[ Cart Icon Shimmer ]-------------------------- //
          ShimmerHelper.buildBasicShimmer(
            height: Dimensions.iconSizeLarge,
            width: Dimensions.iconSizeLarge,
            radios: Dimensions.radiusExtraSmall,
          ),
        ],
      ),
    );
  }
}
