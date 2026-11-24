import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/cart/cubit/cart_cubit.dart';
import 'package:flustra_template/modules/cart/data/responses/cart_response.dart';
import 'package:flustra_template/modules/products/data/responses/wishlist_response.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_controller.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_screen.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';

class WishlistController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  WishlistController(
    this._productsCubit, {
    CartCubit? cartCubit,
  }) : _cartCubit = cartCubit ?? CartCubit.i;

  // ========================== 🔒 Private variables 🔒 ========================== //
  final ProductsCubit _productsCubit;
  final CartCubit _cartCubit;
  final CancelToken _cancel = CancelToken();
  final String wishlistState = UniqueKey().toString();
  final String addToCartState = UniqueKey().toString();
  final Set<String> _unfavoritedBookKeys = <String>{};

  String? _errorMessage;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String? get errorMessage => _errorMessage;

  List<Product> get wishlistBooks {
    final items = _productsCubit.wishlistResponse?.data?.items ?? [];
    return items
        .map((item) => item.toProduct())
        .where((book) => !_unfavoritedBookKeys.contains(_bookKey(book)))
        .toList();
  }

  bool get hasNoWishlistBooks => wishlistBooks.isEmpty;

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() => _loadWishlist();

  // --------------------------[ onRetry ]-------------------------- //
  void onRetry() => _loadWishlist();

  // --------------------------[ isBookFavorite ]-------------------------- //
  bool isBookFavorite(Product book) {
    return !_unfavoritedBookKeys.contains(_bookKey(book));
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
  void onToggleFavoriteTap(Product book) {
    final key = _bookKey(book);
    if (_unfavoritedBookKeys.contains(key)) {
      _unfavoritedBookKeys.remove(key);
    } else {
      _unfavoritedBookKeys.add(key);
    }
    debugPrint('onToggleFavoriteTap: ${book.name}');
    // TODO: Integrate remove-from-wishlist API when requested
    notifyListeners();
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
  // --------------------------[ _loadWishlist ]-------------------------- //
  Future<void> _loadWishlist() async {
    final res = await _productsCubit.getWishlist(
      cancelToken: _cancel,
      state: wishlistState,
    );
    res.fold(
      (Failure failure) {
        _errorMessage = failure.message;
        failure.showToast();
      },
      (WishlistResponse response) {
        _errorMessage = null;
        _unfavoritedBookKeys.clear();
      },
    );
  }

  // --------------------------[ _bookKey ]-------------------------- //
  String _bookKey(Product book) => '${book.id ?? book.name}';

  @override
  void dispose() {
    _cancel.cancel();
    _productsCubit.disposeState(wishlistState);
    _cartCubit.disposeState(addToCartState);
    super.dispose();
  }
}
