import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_controller.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_screen.dart';
import 'package:flutter/material.dart';

import '../../cubit/cart_cubit.dart';
import '../../data/responses/cart_response.dart';
import '../checkout/checkout_screen.dart';

class CartController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  CartController(this._cartCubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  static const int _minAllowedQuantity = 1;

  final CartCubit _cartCubit;
  final CancelToken _cancel = CancelToken();
  final String cartState = UniqueKey().toString();
  final String updateCartState = UniqueKey().toString();
  final String removeFromCartState = UniqueKey().toString();
  final Set<String> _removedItemKeys = <String>{};
  final Map<String, int> _localQuantityOverrides = <String, int>{};

  String? _errorMessage;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String? get errorMessage => _errorMessage;

  List<CartItemResponse> get cartItems {
    final items = _cartCubit.cartResponse?.data?.cartItems ?? [];
    return items
        .where((item) => !_removedItemKeys.contains(_itemKey(item)))
        .toList();
  }

  bool get hasNoCartItems => cartItems.isEmpty;

  bool get hasLocalModifications =>
      _removedItemKeys.isNotEmpty || _localQuantityOverrides.isNotEmpty;

  double get totalCartPrice {
    if (hasNoCartItems) return 0.0;
    if (!hasLocalModifications) {
      final rawServerTotal = _cartCubit.cartResponse?.data?.total;
      final parsedServerTotal = double.tryParse(rawServerTotal ?? '');
      if (parsedServerTotal != null) return parsedServerTotal;
    }

    double calculatedTotal = 0.0;
    for (final item in cartItems) {
      calculatedTotal += item.discountedUnitPrice * getItemQuantity(item);
    }
    return calculatedTotal;
  }

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() => _loadCart();

  // --------------------------[ onRetry ]-------------------------- //
  void onRetry() => _loadCart();

  // --------------------------[ getItemQuantity ]-------------------------- //
  int getItemQuantity(CartItemResponse item) {
    final key = _itemKey(item);
    return _localQuantityOverrides[key] ??
        (item.itemQuantity ?? _minAllowedQuantity);
  }

  // --------------------------[ onItemTap ]-------------------------- //
  void onItemTap(CartItemResponse item) {
    BookDetailsScreen.navigateToMe(
      BookDetailsScreenArgs(
        productId: item.itemProductId,
        initialBook: item.toProduct(),
      ),
    );
  }

  // --------------------------[ onIncrementQuantityTap ]-------------------------- //
  Future<void> onIncrementQuantityTap(CartItemResponse item) async {
    final currentQuantity = getItemQuantity(item);
    final maxStock = item.itemProductStock;
    if (maxStock != null && maxStock > 0 && currentQuantity >= maxStock) return;

    await _updateItemQuantity(
      item: item,
      previousQuantity: currentQuantity,
      newQuantity: currentQuantity + 1,
    );
  }

  // --------------------------[ onDecrementQuantityTap ]-------------------------- //
  Future<void> onDecrementQuantityTap(CartItemResponse item) async {
    final currentQuantity = getItemQuantity(item);
    if (currentQuantity <= _minAllowedQuantity) return;

    await _updateItemQuantity(
      item: item,
      previousQuantity: currentQuantity,
      newQuantity: currentQuantity - 1,
    );
  }

  // --------------------------[ onRemoveItemTap ]-------------------------- //
  Future<void> onRemoveItemTap(CartItemResponse item) async {
    final cartItemId = item.itemId ?? item.itemProductId;
    if (cartItemId == null) return;

    final key = _itemKey(item);
    final previousOverride = _localQuantityOverrides[key];
    _removedItemKeys.add(key);
    _localQuantityOverrides.remove(key);
    notifyListeners();

    final res = await _cartCubit.removeFromCart(
      cartItemId: cartItemId,
      productId: item.itemProductId,
      cancelToken: _cancel,
      state: removeFromCartState,
    );

    res.fold(
      (Failure failure) {
        _removedItemKeys.remove(key);
        if (previousOverride != null) {
          _localQuantityOverrides[key] = previousOverride;
        }
        notifyListeners();
        failure.showToast();
      },
      (CartResponse response) {
        _removedItemKeys.remove(key);
        _showSuccessToastIfPresent(response.message);
        notifyListeners();
      },
    );
  }

  // --------------------------[ onCheckoutTap ]-------------------------- //
  void onCheckoutTap() {
    CheckoutScreen.navigateToMe();
  }

  // ========================== 🔒 Private methods 🔒 ========================== //
  // --------------------------[ _loadCart ]-------------------------- //
  Future<void> _loadCart() async {
    final res = await _cartCubit.getCart(
      cancelToken: _cancel,
      state: cartState,
    );
    res.fold(
      (Failure failure) {
        _errorMessage = failure.message;
        failure.showToast();
      },
      (CartResponse response) {
        _errorMessage = null;
        _removedItemKeys.clear();
        _localQuantityOverrides.clear();
      },
    );
  }

  // --------------------------[ _updateItemQuantity ]-------------------------- //
  Future<void> _updateItemQuantity({
    required CartItemResponse item,
    required int previousQuantity,
    required int newQuantity,
  }) async {
    final cartItemId = item.itemId ?? item.itemProductId;
    if (cartItemId == null) return;

    final key = _itemKey(item);
    _localQuantityOverrides[key] = newQuantity;
    notifyListeners();

    final res = await _cartCubit.updateCart(
      cartItemId: cartItemId,
      quantity: newQuantity,
      cancelToken: _cancel,
      state: updateCartState,
    );

    res.fold(
      (Failure failure) {
        _localQuantityOverrides[key] = previousQuantity;
        notifyListeners();
        failure.showToast();
      },
      (CartResponse response) {
        _localQuantityOverrides.remove(key);
        notifyListeners();
      },
    );
  }

  // --------------------------[ _showSuccessToastIfPresent ]-------------------------- //
  void _showSuccessToastIfPresent(String? message) {
    final trimmed = (message ?? '').trim();
    if (trimmed.isEmpty) return;
    AppBotToast.show(trimmed, type: ToastType.success);
  }

  // --------------------------[ _itemKey ]-------------------------- //
  String _itemKey(CartItemResponse item) =>
      '${item.itemId ?? item.itemProductId ?? item.itemProductName}';

  @override
  void dispose() {
    _cancel.cancel();
    _cartCubit.disposeState(cartState);
    _cartCubit.disposeState(updateCartState);
    _cartCubit.disposeState(removeFromCartState);
    super.dispose();
  }
}
