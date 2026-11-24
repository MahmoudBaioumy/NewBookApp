import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class HomeTopSliderWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const HomeTopSliderWidget({
    super.key,
    required this.banners,
    required this.pageController,
    required this.isLoading,
    required this.onPageChanged,
    required this.onBannerTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final List<String> banners;
  final PageController pageController;
  final bool isLoading;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onBannerTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildShimmer();
    if (banners.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: Dimensions.bannerTopHeight,
      child: PageView.builder(
        controller: pageController,
        itemCount: banners.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) => _buildBannerItem(index),
      ),
    );
  }

  // --------------------------[ _buildBannerItem ]-------------------------- //
  Widget _buildBannerItem(int index) {
    return GestureDetector(
      onTap: () => onBannerTap(index),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall,
        ),
        child: CachedImageWidget(
          imageUrl: banners[index],
          height: Dimensions.bannerTopHeight,
          width: double.infinity,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
      ),
    );
  }

  // --------------------------[ _buildShimmer ]-------------------------- //
  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: ShimmerHelper.buildBasicShimmer(
        height: Dimensions.bannerTopHeight,
        width: double.infinity,
        radios: Dimensions.radiusSmall,
      ),
    );
  }
}
