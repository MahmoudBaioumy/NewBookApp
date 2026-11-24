import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/cart/cubit/cart_cubit.dart';
import 'package:flustra_template/modules/cart/data/responses/cart_response.dart';
import 'package:flustra_template/modules/products/data/responses/product_details_response.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';

class BookDetailsScreenArgs {
  final int? productId;
  final Product? initialBook;

  const BookDetailsScreenArgs({
    this.productId,
    this.initialBook,
  });
}

class BookDetailsController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  BookDetailsController(
    this._productsCubit, {
    CartCubit? cartCubit,
    this.args,
  }) : _cartCubit = cartCubit ?? CartCubit.i;

  // ========================== 🔒 Private variables 🔒 ========================== //
  final ProductsCubit _productsCubit;
  final CartCubit _cartCubit;
  final BookDetailsScreenArgs? args;
  final CancelToken _cancel = CancelToken();
  final String productDetailsState = UniqueKey().toString();
  final String addToWishlistState = UniqueKey().toString();
  final String addToCartState = UniqueKey().toString();

  ProductDetailsResponse? _productDetailsResponse;
  String? _errorMessage;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String? get errorMessage => _errorMessage;

  bool get isFavorite => _productsCubit.isProductFavorite(_resolvedProductId);

  Product? get book {
    final loadedProduct = _productDetailsResponse?.data;
    if (loadedProduct != null) {
      return loadedProduct.toProduct();
    }
    return args?.initialBook;
  }

  bool get hasNoBookData => book == null;

  int? get _resolvedProductId => args?.productId ?? args?.initialBook?.id;

  // ========================== 🔥 initialization 🔥 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() {
    _loadProductDetails();
  }

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ onBackTap ]-------------------------- //
  void onBackTap() {
    popIfUCan();
  }

  // --------------------------[ onRetry ]-------------------------- //
  void onRetry() {
    _loadProductDetails();
  }

  // --------------------------[ onToggleFavoriteTap ]-------------------------- //
  Future<void> onToggleFavoriteTap() async {
    final productId = _resolvedProductId;
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
  Future<void> onAddToCartTap() async {
    final productId = _resolvedProductId;
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
  // --------------------------[ _loadProductDetails ]-------------------------- //
  Future<void> _loadProductDetails() async {
    final productId = _resolvedProductId;
    if (productId == null) return;

    final res = await _productsCubit.getProductDetails(
      productId: productId,
      cancelToken: _cancel,
      state: productDetailsState,
    );
    res.fold(
      (Failure failure) {
        _errorMessage = failure.message;
        failure.showToast();
      },
      (ProductDetailsResponse response) {
        _errorMessage = null;
        _productDetailsResponse = response;
      },
    );
  }

  @override
  void dispose() {
    _cancel.cancel();
    _productsCubit.disposeState(productDetailsState);
    _productsCubit.disposeState(addToWishlistState);
    _cartCubit.disposeState(addToCartState);
    super.dispose();
  }
}
