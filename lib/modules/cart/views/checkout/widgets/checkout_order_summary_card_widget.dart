import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

import '../../../data/responses/checkout_response.dart';

class CheckoutOrderSummaryCardWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const CheckoutOrderSummaryCardWidget({
    super.key,
    required this.items,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final List<CheckoutCartItemResponse> items;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------[ Section Title ]-------------------------- //
        _buildSectionTitle(),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        // --------------------------[ Order Items Container ]-------------------------- //
        _buildSummaryContainer(),
      ],
    );
  }

  // --------------------------[ _buildSectionTitle ]-------------------------- //
  Widget _buildSectionTitle() {
    return Text(
      AppStrings.orderSummary.tx(),
      style: AppTextStyle.titleMedium.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // --------------------------[ _buildSummaryContainer ]-------------------------- //
  Widget _buildSummaryContainer() {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(
          color: AppColors.outline,
          width: Dimensions.borderWidthThin,
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: Dimensions.paddingSizeH,
          ),
          child: Divider(
            height: Dimensions.borderWidthThin,
            thickness: Dimensions.borderWidthThin,
            color: AppColors.outlineVariant,
          ),
        ),
        itemBuilder: (_, index) => _buildOrderItemRow(items[index]),
      ),
    );
  }

  // --------------------------[ _buildOrderItemRow ]-------------------------- //
  Widget _buildOrderItemRow(CheckoutCartItemResponse item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------[ Book Name & Unit Info ]-------------------------- //
        Expanded(child: _buildItemMainInfo(item)),
        const SizedBox(width: Dimensions.paddingSizeDefault),
        // --------------------------[ Item Total & Quantity Badge ]-------------------------- //
        _buildItemRightSummary(item),
      ],
    );
  }

  // --------------------------[ _buildItemMainInfo ]-------------------------- //
  Widget _buildItemMainInfo(CheckoutCartItemResponse item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.itemProductName ?? '',
          style: AppTextStyle.titleSmall.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          '${AppStrings.unitPriceLabel.tx()} ${item.parsedUnitPrice.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // --------------------------[ _buildItemRightSummary ]-------------------------- //
  Widget _buildItemRightSummary(CheckoutCartItemResponse item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: Dimensions.paddingSizeSmall,
            vertical: Dimensions.paddingSizeMini,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryTint,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
          ),
          child: Text(
            '${AppStrings.quantityShort.tx()} ${item.itemQuantity ?? 1}',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          '${item.parsedItemTotal.toStringAsFixed(2)} ${AppStrings.currencyLE.tx()}',
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
