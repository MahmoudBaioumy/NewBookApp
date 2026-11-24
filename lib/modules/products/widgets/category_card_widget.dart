import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class CategoryCardWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CategoryCardWidget({
    super.key,
    required this.category,
    required this.onTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final BookCategoryModel category;
  final VoidCallback onTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Dimensions.categoryCardSize,
        height: Dimensions.categoryCardSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // --------------------------[ Background Image ]-------------------------- //
            CachedImageWidget(
              imageUrl: category.imageUrl,
              width: Dimensions.categoryCardSize,
              height: Dimensions.categoryCardSize,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            // --------------------------[ Dark Overlay ]-------------------------- //
            Container(
              decoration: BoxDecoration(
                color: AppColors.onSurface.withOpacityEX(0.45),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
            ),
            // --------------------------[ Category Name ]-------------------------- //
            Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(
                  Dimensions.paddingSizeExtraSmall,
                ),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleSmall.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
