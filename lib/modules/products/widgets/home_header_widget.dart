import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const HomeHeaderWidget({
    super.key,
    required this.userName,
    required this.userAvatarUrl,
    required this.onMenuTap,
    required this.onAvatarTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final String userName;
  final String userAvatarUrl;
  final VoidCallback onMenuTap;
  final VoidCallback onAvatarTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: Row(
        children: [
          // --------------------------[ Menu Icon ]-------------------------- //
          _buildMenuButton(),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // --------------------------[ Greeting Texts ]-------------------------- //
          Expanded(child: _buildGreetingTexts()),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // --------------------------[ User Avatar ]-------------------------- //
          _buildUserAvatar(),
        ],
      ),
    );
  }

  // --------------------------[ _buildMenuButton ]-------------------------- //
  Widget _buildMenuButton() {
    return InkWell(
      onTap: onMenuTap,
      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeExtraSmall),
        child: Icon(
          Icons.filter_list_rounded,
          color: AppColors.onSurface,
          size: Dimensions.iconSizeLarge,
        ),
      ),
    );
  }

  // --------------------------[ _buildGreetingTexts ]-------------------------- //
  Widget _buildGreetingTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${AppStrings.hi.tx()} $userName',
          style: AppTextStyle.titleLarge.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.paddingSizeMini),
        Text(
          AppStrings.whatAreYouReadingToday.tx(),
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // --------------------------[ _buildUserAvatar ]-------------------------- //
  Widget _buildUserAvatar() {
    return GestureDetector(
      onTap: onAvatarTap,
      child: CachedImageWidget(
        imageUrl: userAvatarUrl,
        width: Dimensions.avatarSizeDefault,
        height: Dimensions.avatarSizeDefault,
        isCircle: true,
        fit: BoxFit.cover,
      ),
    );
  }
}
