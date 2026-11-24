import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class PromoBannerSliderWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const PromoBannerSliderWidget({
    super.key,
    required this.banners,
    required this.currentIndex,
    required this.isLoading,
    required this.onPageChanged,
    required this.onBannerTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final List<String> banners;
  final int currentIndex;
  final bool isLoading;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onBannerTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildShimmer();
    if (banners.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: Column(
        children: [
          // --------------------------[ Framed Promo PageView ]-------------------------- //
          _buildFramedSlider(),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          // --------------------------[ Dots Indicator ]-------------------------- //
          _buildDotsIndicator(),
        ],
      ),
    );
  }

  // --------------------------[ _buildFramedSlider ]-------------------------- //
  Widget _buildFramedSlider() {
    return Container(
      height: Dimensions.bannerPromoHeight,
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeH),
      decoration: BoxDecoration(
        color: AppColors.coldTint,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: PageView.builder(
        itemCount: banners.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onBannerTap(index),
          child: CachedImageWidget(
            imageUrl: banners[index],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
          ),
        ),
      ),
    );
  }

  // --------------------------[ _buildDotsIndicator ]-------------------------- //
  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        banners.length,
        (index) => _buildSingleDot(isActive: index == currentIndex),
      ),
    );
  }

  // --------------------------[ _buildSingleDot ]-------------------------- //
  Widget _buildSingleDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingSizeMini,
      ),
      height: Dimensions.indicatorInactiveSize,
      width: isActive
          ? Dimensions.indicatorActiveWidth
          : Dimensions.indicatorInactiveSize,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.outline,
        borderRadius: BorderRadius.circular(Dimensions.radiusPill),
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
        height: Dimensions.bannerPromoHeight,
        width: double.infinity,
        radios: Dimensions.radiusDefault,
      ),
    );
  }
}
