import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flutter/material.dart';

class BookListHorizontalCardWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookListHorizontalCardWidget({
    super.key,
    required this.book,
    required this.isFavorite,
    required this.onCardTap,
    required this.onFavoriteTap,
    required this.onAddToCartTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final Product book;
  final bool isFavorite;
  final VoidCallback onCardTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onAddToCartTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
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
            // --------------------------[ Book Cover & Discount Badge ]-------------------------- //
            _buildCoverWithBadge(),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            // --------------------------[ Book Details ]-------------------------- //
            Expanded(child: _buildBookDetails()),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            // --------------------------[ Favorite & Cart Actions ]-------------------------- //
            _buildActionsColumn(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildCoverWithBadge ]-------------------------- //
  Widget _buildCoverWithBadge() {
    return SizedBox(
      width: Dimensions.bookListCardImageWidth,
      height: Dimensions.bookListCardImageHeight,
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
              top: Dimensions.paddingSizeSmall,
              start: Dimensions.paddingSizeSmall,
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

  // --------------------------[ _buildBookDetails ]-------------------------- //
  Widget _buildBookDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimensions.paddingSizeTiny),
        // --------------------------[ Book Title ]-------------------------- //
        Text(
          book.name,
          style: AppTextStyle.titleMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        // --------------------------[ Book Category ]-------------------------- //
        Text(
          book.category,
          style: AppTextStyle.bodyLarge.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        // --------------------------[ Original Price ]-------------------------- //
        Text(
          '${book.originalPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.hint,
            decoration: TextDecoration.lineThrough,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.paddingSizeMini),
        // --------------------------[ Discounted Price ]-------------------------- //
        Text(
          '${book.discountedPrice} ${AppStrings.currencyLE.tx()}',
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // --------------------------[ _buildActionsColumn ]-------------------------- //
  Widget _buildActionsColumn() {
    return SizedBox(
      height: Dimensions.bookListCardImageHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --------------------------[ Favorite Button ]-------------------------- //
          InkWell(
            onTap: onFavoriteTap,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(
                Dimensions.paddingSizeMini,
              ),
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite ? AppColors.primary : AppColors.onSurface,
                size: Dimensions.iconSizeLarge,
              ),
            ),
          ),
          // --------------------------[ Add To Cart Button ]-------------------------- //
          InkWell(
            onTap: onAddToCartTap,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(
                Dimensions.paddingSizeMini,
              ),
              child: Icon(
                Icons.add_shopping_cart_outlined,
                color: AppColors.onSurface,
                size: Dimensions.iconSizeLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
