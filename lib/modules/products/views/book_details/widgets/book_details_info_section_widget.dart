import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flutter/material.dart';

class BookDetailsInfoSectionWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookDetailsInfoSectionWidget({
    super.key,
    required this.book,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final Product book;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------[ Book Title ]-------------------------- //
          _buildBookTitle(),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          // --------------------------[ Category & Prices Row ]-------------------------- //
          _buildCategoryAndPricesRow(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          // --------------------------[ Description Heading ]-------------------------- //
          _buildDescriptionTitle(),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          // --------------------------[ Description Body ]-------------------------- //
          _buildDescriptionBody(),
        ],
      ),
    );
  }

  // --------------------------[ _buildBookTitle ]-------------------------- //
  Widget _buildBookTitle() {
    return Text(
      book.name,
      style: AppTextStyle.displaySmall.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // --------------------------[ _buildCategoryAndPricesRow ]-------------------------- //
  Widget _buildCategoryAndPricesRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --------------------------[ Category Name ]-------------------------- //
        Expanded(
          child: Text(
            book.category,
            style: AppTextStyle.titleMedium.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        // --------------------------[ Original & Discounted Prices ]-------------------------- //
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${book.originalPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.hint,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeMini),
            Text(
              '${book.discountedPrice} ${AppStrings.currencyLE.tx()}',
              style: AppTextStyle.titleSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --------------------------[ _buildDescriptionTitle ]-------------------------- //
  Widget _buildDescriptionTitle() {
    return Text(
      AppStrings.descriptionLabel.tx(),
      style: AppTextStyle.titleLarge.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // --------------------------[ _buildDescriptionBody ]-------------------------- //
  Widget _buildDescriptionBody() {
    return Text(
      book.description,
      style: AppTextStyle.titleMedium.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
