import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'book_card_widget.dart';

class BookHorizontalListWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const BookHorizontalListWidget({
    super.key,
    required this.books,
    required this.isLoading,
    required this.onBookTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  static const int _shimmerItemCount = 4;

  final List<Product> books;
  final bool isLoading;
  final ValueChanged<Product> onBookTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? _shimmerItemCount : books.length;
    if (!isLoading && books.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: Dimensions.bookHorizontalListHeight,
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
            return SizedBox(
              width: Dimensions.bookCardWidth,
              child: ShimmerTemplates.productCard(
                width: Dimensions.bookCardWidth,
              ),
            );
          }
          final book = books[index];
          return BookCardWidget(
            book: book,
            onTap: () => onBookTap(book),
          );
        },
      ),
    );
  }
}
