import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/dialogs/common_dialog.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar_controller.dart';
import 'package:flutter/material.dart';

import '../../cubit/cart_cubit.dart';
import '../../data/requests/place_order_request.dart';
import '../../data/responses/checkout_response.dart';
import '../../data/responses/place_order_response.dart';

class CheckoutController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  CheckoutController(this._cartCubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  final CartCubit _cartCubit;
  final CancelToken _cancel = CancelToken();
  final String checkoutState = UniqueKey().toString();
  final String placeOrderState = UniqueKey().toString();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  CheckoutResponse? _checkoutResponse;
  String? _errorMessage;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String? get errorMessage => _errorMessage;

  CheckoutDataResponse? get checkoutData =>
      _checkoutResponse?.data ?? _cartCubit.checkoutResponse?.data;

  CheckoutUserResponse? get checkoutUser => checkoutData?.user;

  List<CheckoutCartItemResponse> get checkoutItems =>
      checkoutData?.cartItems ?? [];

  bool get hasNoCheckoutData => checkoutData == null;

  double get totalPrice => checkoutData?.parsedTotal ?? 0.0;

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() {
    _syncControllersWithUser(checkoutUser);
    _loadCheckout();
  }

  // --------------------------[ onBackTap ]-------------------------- //
  void onBackTap() => popIfUCan();

  // --------------------------[ onRetry ]-------------------------- //
  void onRetry() => _loadCheckout();

  // --------------------------[ onOrderNowTap ]-------------------------- //
  Future<void> onOrderNowTap() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    await _submitPlaceOrder();
  }

  // ========================== 🔒 Private methods 🔒 ========================== //
  // --------------------------[ _loadCheckout ]-------------------------- //
  Future<void> _loadCheckout() async {
    final res = await _cartCubit.getCheckout(
      cancelToken: _cancel,
      state: checkoutState,
    );
    res.fold(
      (Failure failure) {
        _errorMessage = failure.message;
        failure.showToast();
      },
      (CheckoutResponse response) {
        _errorMessage = null;
        _checkoutResponse = response;
        _syncControllersWithUser(response.data?.user);
        notifyListeners();
      },
    );
  }

  // --------------------------[ _submitPlaceOrder ]-------------------------- //
  Future<void> _submitPlaceOrder() async {
    final request = PlaceOrderRequest(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      email: emailController.text.trim(),
    );

    final res = await _cartCubit.placeOrder(
      request: request,
      cancelToken: _cancel,
      state: placeOrderState,
    );

    res.fold(
      (Failure failure) => failure.showToast(),
      (PlaceOrderResponse response) {
        _checkoutResponse = null;
        _showOrderSuccessDialog();
      },
    );
  }

  // --------------------------[ _showOrderSuccessDialog ]-------------------------- //
  Future<void> _showOrderSuccessDialog() async {
    await showCommonDialog(
      icon: Icons.check_circle_rounded,
      title: AppStrings.orderPlacedTitle.tx(),
      description: AppStrings.orderPlacedDesc.tx(),
      confirmText: AppStrings.backToHome.tx(),
      showCancel: false,
      onConfirm: _onConfirmBackToHome,
    );
  }

  // --------------------------[ _onConfirmBackToHome ]-------------------------- //
  void _onConfirmBackToHome() {
    popIfUCan();
    HomeNavigationBarController.i.onItemTapped(MainScreenPageType.home);
    popIfUCan();
  }

  // --------------------------[ _syncControllersWithUser ]-------------------------- //
  void _syncControllersWithUser(CheckoutUserResponse? user) {
    if (user == null) return;
    nameController.text = user.userName ?? '';
    emailController.text = user.userEmail ?? '';
    phoneController.text = user.phone ?? '';
    addressController.text = user.address ?? '';
  }

  @override
  void dispose() {
    _cancel.cancel();
    _cartCubit.disposeState(checkoutState);
    _cartCubit.disposeState(placeOrderState);
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
