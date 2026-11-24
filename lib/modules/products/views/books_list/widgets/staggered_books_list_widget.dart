import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flutter/material.dart';

import 'book_list_horizontal_card_widget.dart';
import 'staggered_list_animation_widget.dart';

class StaggeredBooksListWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const StaggeredBooksListWidget({
    super.key,
    required this.books,
    required this.isBookFavorite,
    required this.onBookTap,
    required this.onToggleFavoriteTap,
    required this.onAddToCartTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final List<Product> books;
  final bool Function(Product book) isBookFavorite;
  final ValueChanged<Product> onBookTap;
  final ValueChanged<Product> onToggleFavoriteTap;
  final ValueChanged<Product> onAddToCartTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      padding: const EdgeInsetsDirectional.only(
        start: Dimensions.paddingScreen,
        end: Dimensions.paddingScreen,
        bottom: Dimensions.paddingSizeExtraLarge,
      ),
      itemCount: books.length,
      separatorBuilder: (_, __) => const SizedBox(
        height: Dimensions.paddingSizeDefault,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return StaggeredListAnimationWidget(
          key: ValueKey('${book.id ?? book.name}_$index'),
          index: index,
          child: BookListHorizontalCardWidget(
            book: book,
            isFavorite: isBookFavorite(book),
            onCardTap: () => onBookTap(book),
            onFavoriteTap: () => onToggleFavoriteTap(book),
            onAddToCartTap: () => onAddToCartTap(book),
          ),
        );
      },
    );
  }
}
