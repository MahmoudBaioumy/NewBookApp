import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/modules/products/views/books_list/widgets/staggered_list_animation_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/responses/cart_response.dart';
import 'cart_item_card_widget.dart';

class StaggeredCartListWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const StaggeredCartListWidget({
    super.key,
    required this.items,
    required this.getItemQuantity,
    required this.onItemTap,
    required this.onIncrementQuantityTap,
    required this.onDecrementQuantityTap,
    required this.onRemoveItemTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final List<CartItemResponse> items;
  final int Function(CartItemResponse item) getItemQuantity;
  final ValueChanged<CartItemResponse> onItemTap;
  final ValueChanged<CartItemResponse> onIncrementQuantityTap;
  final ValueChanged<CartItemResponse> onDecrementQuantityTap;
  final ValueChanged<CartItemResponse> onRemoveItemTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      padding: const EdgeInsetsDirectional.only(
        start: Dimensions.paddingScreen,
        end: Dimensions.paddingScreen,
        bottom: Dimensions.paddingSizeDefault,
      ),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(
        height: Dimensions.paddingSizeDefault,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return StaggeredListAnimationWidget(
          key: ValueKey(
            '${item.itemId ?? item.itemProductId ?? item.itemProductName}_$index',
          ),
          index: index,
          child: CartItemCardWidget(
            item: item,
            quantity: getItemQuantity(item),
            onCardTap: () => onItemTap(item),
            onIncrementTap: () => onIncrementQuantityTap(item),
            onDecrementTap: () => onDecrementQuantityTap(item),
            onRemoveTap: () => onRemoveItemTap(item),
          ),
        );
      },
    );
  }
}
