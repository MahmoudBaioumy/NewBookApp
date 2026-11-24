import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'category_card_widget.dart';

class HomeCategoriesListWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const HomeCategoriesListWidget({
    super.key,
    required this.categories,
    required this.isLoading,
    required this.onCategoryTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  static const int _shimmerItemCount = 4;

  final List<BookCategoryModel> categories;
  final bool isLoading;
  final ValueChanged<BookCategoryModel> onCategoryTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? _shimmerItemCount : categories.length;
    if (!isLoading && categories.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: Dimensions.categoryCardSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingScreen,
        ),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(
          width: Dimensions.paddingSizeDefault,
        ),
        itemBuilder: (context, index) {
          if (isLoading) {
            return ShimmerHelper.buildBasicShimmer(
              height: Dimensions.categoryCardSize,
              width: Dimensions.categoryCardSize,
              radios: Dimensions.radiusDefault,
            );
          }
          final category = categories[index];
          return CategoryCardWidget(
            category: category,
            onTap: () => onCategoryTap(category),
          );
        },
      ),
    );
  }
}
