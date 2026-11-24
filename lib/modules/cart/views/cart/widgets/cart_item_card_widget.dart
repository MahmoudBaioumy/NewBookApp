import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_image_network.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

import '../../../data/responses/cart_response.dart';

class CartItemCardWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CartItemCardWidget({
    super.key,
    required this.item,
    required this.quantity,
    required this.onCardTap,
    required this.onIncrementTap,
    required this.onDecrementTap,
    required this.onRemoveTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final CartItemResponse item;
  final int quantity;
  final VoidCallback onCardTap;
  final VoidCallback onIncrementTap;
  final VoidCallback onDecrementTap;
  final VoidCallback onRemoveTap;

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
            // --------------------------[ Book Cover Image ]-------------------------- //
            _buildBookCover(),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            // --------------------------[ Item Info & Controls ]-------------------------- //
            Expanded(child: _buildItemContent()),
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildBookCover ]-------------------------- //
  Widget _buildBookCover() {
    return SizedBox(
      width: Dimensions.bookListCardImageWidth,
      height: Dimensions.bookListCardImageHeight,
      child: CachedImageWidget(
        imageUrl: item.itemProductImage ?? '',
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
    );
  }

  // --------------------------[ _buildItemContent ]-------------------------- //
  Widget _buildItemContent() {
    return SizedBox(
      height: Dimensions.bookListCardImageHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --------------------------[ Title & Delete Button ]-------------------------- //
          _buildHeaderRow(),
          // --------------------------[ Quantity Selector & Prices ]-------------------------- //
          _buildFooterRow(),
        ],
      ),
    );
  }

  // --------------------------[ _buildHeaderRow ]-------------------------- //
  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: Dimensions.paddingSizeTiny,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------[ Book Title ]-------------------------- //
          Expanded(
            child: Text(
              item.itemProductName ?? '',
              style: AppTextStyle.titleMedium.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // --------------------------[ Delete Button ]-------------------------- //
          _buildDeleteButton(),
        ],
      ),
    );
  }

  // --------------------------[ _buildDeleteButton ]-------------------------- //
  Widget _buildDeleteButton() {
    return InkWell(
      onTap: onRemoveTap,
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(Dimensions.paddingSizeMini),
        child: Icon(
          Icons.delete_rounded,
          color: AppColors.error,
          size: Dimensions.iconSizeDefault,
        ),
      ),
    );
  }

  // --------------------------[ _buildFooterRow ]-------------------------- //
  Widget _buildFooterRow() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: Dimensions.paddingSizeExtraSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // --------------------------[ Quantity Selector ]-------------------------- //
          _buildQuantitySelector(),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // --------------------------[ Original & Discounted Prices ]-------------------------- //
          Expanded(child: _buildPricesColumn()),
        ],
      ),
    );
  }

  // --------------------------[ _buildQuantitySelector ]-------------------------- //
  Widget _buildQuantitySelector() {
    return Container(
      height: Dimensions.cartQuantityBoxHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.outline,
          width: Dimensions.borderWidthDefault,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --------------------------[ Increment Button ]-------------------------- //
          _buildQuantityActionButton(
            icon: Icons.add,
            iconColor: AppColors.onSurface,
            onTap: onIncrementTap,
          ),
          // --------------------------[ Quantity Value ]-------------------------- //
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: Dimensions.cartQuantityMinTextWidth,
            ),
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyLarge.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // --------------------------[ Decrement Button ]-------------------------- //
          _buildQuantityActionButton(
            icon: Icons.remove,
            iconColor: AppColors.onSurfaceVariant,
            onTap: onDecrementTap,
          ),
        ],
      ),
    );
  }

  // --------------------------[ _buildQuantityActionButton ]-------------------------- //
  Widget _buildQuantityActionButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: Dimensions.cartQuantityButtonWidth,
        height: Dimensions.cartQuantityBoxHeight,
        child: Icon(
          icon,
          size: Dimensions.iconSizeSmall,
          color: iconColor,
        ),
      ),
    );
  }

  // --------------------------[ _buildPricesColumn ]-------------------------- //
  Widget _buildPricesColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --------------------------[ Original Price ]-------------------------- //
        Text(
          '${item.originalUnitPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
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
          '${item.discountedUnitPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
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
}
