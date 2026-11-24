import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/cart/cubit/cart_cubit.dart';
import 'package:flustra_template/modules/cart/data/responses/cart_response.dart';
import 'package:flustra_template/modules/products/data/responses/products_response.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_controller.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_screen.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';

class BooksListScreenArgs {
  final String? title;
  final ProductsResponse? productsResponse;
  final List<Product> books;

  const BooksListScreenArgs({
    this.title,
    this.productsResponse,
    required this.books,
  });
}

class BooksListController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  BooksListController(
    this._productsCubit, {
    CartCubit? cartCubit,
    this.args,
  }) : _cartCubit = cartCubit ?? CartCubit.i;

  // ========================== 🔒 Private variables 🔒 ========================== //
  final ProductsCubit _productsCubit;
  final CartCubit _cartCubit;
  final BooksListScreenArgs? args;
  final CancelToken _cancel = CancelToken();
  final String addToWishlistState = UniqueKey().toString();
  final String addToCartState = UniqueKey().toString();

  List<Product> _books = [];

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String get screenTitle {
    final passedTitle = args?.title;
    if (passedTitle != null && passedTitle.trim().isNotEmpty) {
      return passedTitle;
    }
    return AppStrings.books.tx();
  }

  bool get canShowBackButton => args != null;

  List<Product> get books => _books;

  bool get hasNoBooks => _books.isEmpty;

  // ========================== 🔥 initialization 🔥 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() {
    _resolveInitialBooksFromSavedModel();
  }

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ onBackTap ]-------------------------- //
  void onBackTap() {
    popIfUCan();
  }

  // --------------------------[ isBookFavorite ]-------------------------- //
  bool isBookFavorite(Product book) {
    return _productsCubit.isProductFavorite(book.id);
  }

  // --------------------------[ onBookTap ]-------------------------- //
  void onBookTap(Product book) {
    BookDetailsScreen.navigateToMe(
      BookDetailsScreenArgs(
        productId: book.id,
        initialBook: book,
      ),
    );
  }

  // --------------------------[ onToggleFavoriteTap ]-------------------------- //
  Future<void> onToggleFavoriteTap(Product book) async {
    final productId = book.id;
    if (productId == null) return;

    final wasFavorite = _productsCubit.isProductFavorite(productId);
    if (!wasFavorite) {
      _productsCubit.favoriteProductIds.add(productId);
      notifyListeners();
    }

    final res = await _productsCubit.addToWishlist(
      productId: productId,
      cancelToken: _cancel,
      state: addToWishlistState,
    );

    res.fold(
      (Failure failure) {
        if (!wasFavorite) {
          _productsCubit.favoriteProductIds.remove(productId);
          notifyListeners();
        }
        failure.showToast();
      },
      (_) {},
    );
  }

  // --------------------------[ onAddToCartTap ]-------------------------- //
  Future<void> onAddToCartTap(Product book) async {
    final productId = book.id;
    if (productId == null) return;

    final res = await _cartCubit.addToCart(
      productId: productId,
      cancelToken: _cancel,
      state: addToCartState,
    );

    res.fold(
      (Failure failure) => failure.showToast(),
      (CartResponse response) {
        final message = (response.message ?? '').trim();
        if (message.isNotEmpty) {
          AppBotToast.show(message, type: ToastType.success);
        }
      },
    );
  }

  // ========================== 🔒 Private methods 🔒 ========================== //
  // --------------------------[ _resolveInitialBooksFromSavedModel ]-------------------------- //
  void _resolveInitialBooksFromSavedModel() {
    final passedResponseProducts = args?.productsResponse?.data?.products;
    if (passedResponseProducts != null && passedResponseProducts.isNotEmpty) {
      _books = passedResponseProducts.map((item) => item.toProduct()).toList();
      return;
    }

    final passedBooks = args?.books;
    if (passedBooks != null && passedBooks.isNotEmpty) {
      _books = List<Product>.from(passedBooks);
      return;
    }

    final cachedBestSellers =
        _productsCubit.bestSellersResponse?.data?.products ?? [];
    final cachedNewArrivals =
        _productsCubit.newArrivalsResponse?.data?.products ?? [];

    final combinedMap = <String, Product>{};
    for (final item in [...cachedBestSellers, ...cachedNewArrivals]) {
      final product = item.toProduct();
      combinedMap[_bookKey(product)] = product;
    }
    _books = combinedMap.values.toList();
  }

  // --------------------------[ _bookKey ]-------------------------- //
  String _bookKey(Product book) => '${book.id ?? book.name}';

  @override
  void dispose() {
    _cancel.cancel();
    _productsCubit.disposeState(addToWishlistState);
    _cartCubit.disposeState(addToCartState);
    super.dispose();
  }
}
