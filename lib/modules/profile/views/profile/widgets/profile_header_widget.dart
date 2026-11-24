import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onLogoutTap;

  const ProfileHeaderWidget({
    super.key,
    required this.imageUrl,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.profileHeaderTotalHeight,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          // --------------------------[ Curved Primary Background ]-------------------------- //
          _buildCurvedBackground(),
          // --------------------------[ Title & Logout Bar ]-------------------------- //
          _buildTopBar(),
          // --------------------------[ Overlapping Circular Avatar ]-------------------------- //
          Positioned(
            bottom: Dimensions.paddingSizeMini,
            child: _buildCircularAvatar(),
          ),
        ],
      ),
    );
  }

  // --------------------------[ Curved Primary Background ]-------------------------- //
  Widget _buildCurvedBackground() {
    return ClipPath(
      clipper: _ProfileHeaderCurvedClipper(),
      child: Container(
        height: Dimensions.profileHeaderCurveHeight,
        width: double.infinity,
        color: AppColors.primary,
      ),
    );
  }

  // --------------------------[ Title & Logout Bar ]-------------------------- //
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
        vertical: Dimensions.paddingSizeSmall,
      ),
      child: SizedBox(
        height: Dimensions.buttonHeightDefault,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Text(
              AppStrings.profile.tx(),
              style: AppTextStyle.displayLarge.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: IconButton(
                onPressed: onLogoutTap,
                icon: Icon(
                  Icons.logout_rounded,
                  color: AppColors.onPrimary,
                  size: Dimensions.iconSizeLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Overlapping Circular Avatar ]-------------------------- //
  Widget _buildCircularAvatar() {
    return Container(
      width: Dimensions.profileAvatarSize,
      height: Dimensions.profileAvatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceContainer,
        border: Border.all(
          color: AppColors.surface,
          width: Dimensions.profileAvatarBorderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withOpacityEX(
              Dimensions.bookDetailsOverlayOpacity,
            ),
            blurRadius: Dimensions.shadowBlurDefault,
            offset: const Offset(0, Dimensions.shadowOffsetDefault),
          ),
        ],
      ),
      child: ClipOval(
        child: CachedImageWidget(
          imageUrl: imageUrl,
          width: Dimensions.profileAvatarSize,
          height: Dimensions.profileAvatarSize,
          fit: BoxFit.cover,
          isCircle: true,
          errorWidget: _buildFallbackAvatar(),
        ),
      ),
    );
  }

  // --------------------------[ Fallback Avatar ]-------------------------- //
  Widget _buildFallbackAvatar() {
    return Container(
      color: AppColors.surfaceContainerHigh,
      alignment: AlignmentDirectional.center,
      child: Icon(
        Icons.person_rounded,
        size: Dimensions.emptyStateIconContainerSize,
        color: AppColors.primary,
      ),
    );
  }
}

class _ProfileHeaderCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - Dimensions.profileHeaderCurveDepth);
    path.quadraticBezierTo(
      size.width / Dimensions.paddingSizeMini,
      size.height + Dimensions.profileHeaderCurveDepth,
      size.width,
      size.height - Dimensions.profileHeaderCurveDepth,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
