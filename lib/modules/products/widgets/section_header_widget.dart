import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final String title;
  final VoidCallback onSeeAllTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: Row(
        children: [
          // --------------------------[ Section Title ]-------------------------- //
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.titleLarge.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // --------------------------[ Forward Arrow ]-------------------------- //
          InkWell(
            onTap: onSeeAllTap,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeTiny),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.onSurface,
                size: Dimensions.iconSizeDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
