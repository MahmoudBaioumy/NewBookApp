import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/color.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class BookCardWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookCardWidget({
    super.key,
    required this.book,
    required this.onTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final Product book;
  final VoidCallback onTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Dimensions.bookCardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --------------------------[ Book Cover & Discount Badge ]-------------------------- //
            _buildCoverWithBadge(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ Book Name ]-------------------------- //
            _buildBookTitle(),
            const SizedBox(height: Dimensions.paddingSizeMini),
            // --------------------------[ Category Name ]-------------------------- //
            _buildCategoryText(),
            const SizedBox(height: Dimensions.paddingSizeMini),
            // --------------------------[ Original Price ]-------------------------- //
            _buildOriginalPrice(),
            // --------------------------[ Discounted Price ]-------------------------- //
            _buildDiscountedPrice(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildCoverWithBadge ]-------------------------- //
  Widget _buildCoverWithBadge() {
    return Container(
      height: Dimensions.bookCardImageHeight,
      width: Dimensions.bookCardWidth,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withOpacityEX(0.12),
            blurRadius: Dimensions.shadowBlurDefault,
            offset: const Offset(0, Dimensions.shadowOffsetDefault),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedImageWidget(
              imageUrl: book.imageUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
          ),
          if (book.discountPercentage > 0)
            PositionedDirectional(
              top: Dimensions.paddingSizeExtraSmall,
              start: Dimensions.paddingSizeExtraSmall,
              child: _buildDiscountBadge(),
            ),
        ],
      ),
    );
  }

  // --------------------------[ _buildDiscountBadge ]-------------------------- //
  Widget _buildDiscountBadge() {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingSizeExtraSmall,
        vertical: Dimensions.paddingSizeMini,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
      ),
      child: Text(
        '${book.discountPercentage}%',
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // --------------------------[ _buildBookTitle ]-------------------------- //
  Widget _buildBookTitle() {
    return Text(
      book.name,
      textAlign: TextAlign.center,
      style: AppTextStyle.titleSmall.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // --------------------------[ _buildCategoryText ]-------------------------- //
  Widget _buildCategoryText() {
    return Text(
      book.category,
      textAlign: TextAlign.center,
      style: AppTextStyle.bodySmall.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // --------------------------[ _buildOriginalPrice ]-------------------------- //
  Widget _buildOriginalPrice() {
    return Text(
      '${book.originalPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
      textAlign: TextAlign.center,
      style: AppTextStyle.bodySmall.copyWith(
        color: AppColors.hint,
        decoration: TextDecoration.lineThrough,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // --------------------------[ _buildDiscountedPrice ]-------------------------- //
  Widget _buildDiscountedPrice() {
    return Text(
      '${book.discountedPrice.toStringAsFixed(1)} ${AppStrings.currencyLE.tx()}',
      textAlign: TextAlign.center,
      style: AppTextStyle.bodySmall.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
