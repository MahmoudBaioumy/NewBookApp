import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flutter/material.dart';

class BookDetailsCoverHeaderWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookDetailsCoverHeaderWidget({
    super.key,
    required this.imageUrl,
    required this.isFavorite,
    required this.onBackTap,
    required this.onFavoriteTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onBackTap;
  final VoidCallback onFavoriteTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.bookDetailsCoverHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // --------------------------[ Book Cover Image ]-------------------------- //
          CachedImageWidget(
            imageUrl: imageUrl,
            height: Dimensions.bookDetailsCoverHeight,
            width: double.infinity,
            fit: BoxFit.cover,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(Dimensions.radiusExtraLarge),
            ),
          ),
          // --------------------------[ Top Overlay Actions ]-------------------------- //
          SafeArea(
            bottom: false,
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimensions.paddingScreen,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // --------------------------[ Back Button ]-------------------------- //
                    _buildCircularOverlayButton(
                      icon: Icons.arrow_back_rounded,
                      iconColor: AppColors.onPrimary,
                      iconSize: Dimensions.iconSizeDefault,
                      onTap: onBackTap,
                    ),
                    // --------------------------[ Favorite Button ]-------------------------- //
                    _buildCircularOverlayButton(
                      icon: isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      iconColor:
                          isFavorite ? AppColors.primary : AppColors.onPrimary,
                      iconSize: Dimensions.iconSizeLarge,
                      onTap: onFavoriteTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------[ _buildCircularOverlayButton ]-------------------------- //
  Widget _buildCircularOverlayButton({
    required IconData icon,
    required Color iconColor,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimensions.avatarSizeDefault,
        height: Dimensions.avatarSizeDefault,
        decoration: BoxDecoration(
          color: AppColors.onSurface.withOpacityEX(
            Dimensions.bookDetailsOverlayOpacity,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
