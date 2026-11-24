import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class BookDetailsShimmerWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookDetailsShimmerWidget({super.key});

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------[ Cover Shimmer ]-------------------------- //
          ShimmerHelper.buildBasicShimmer(
            height: Dimensions.bookDetailsCoverHeight,
            width: double.infinity,
            radios: Dimensions.radiusExtraLarge,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          // --------------------------[ Info Shimmer ]-------------------------- //
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Dimensions.paddingScreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerHelper.buildBasicShimmer(
                  height: Dimensions.bookDetailsTitleShimmerHeight,
                  width: Dimensions.bookDetailsTitleShimmerWidth,
                  radios: Dimensions.radiusExtraSmall,
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerHelper.buildBasicShimmer(
                      height: Dimensions.bookDetailsSubtitleShimmerHeight,
                      width: Dimensions.bookDetailsSubtitleShimmerWidth,
                      radios: Dimensions.radiusExtraSmall,
                    ),
                    ShimmerHelper.buildBasicShimmer(
                      height: Dimensions.bookDetailsTitleShimmerHeight,
                      width: Dimensions.bookDetailsPriceShimmerWidth,
                      radios: Dimensions.radiusExtraSmall,
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                ShimmerHelper.buildBasicShimmer(
                  height: Dimensions.bookDetailsSubtitleShimmerHeight,
                  width: Dimensions.bookDetailsSubtitleShimmerWidth,
                  radios: Dimensions.radiusExtraSmall,
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                ShimmerHelper.buildBasicShimmer(
                  height: Dimensions.bookDetailsDescShimmerHeight,
                  width: double.infinity,
                  radios: Dimensions.radiusSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
