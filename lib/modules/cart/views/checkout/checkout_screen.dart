import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_error_widget.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../cubit/cart_cubit.dart';
import 'checkout_controller.dart';
import 'widgets/checkout_bottom_bar_widget.dart';
import 'widgets/checkout_order_summary_card_widget.dart';
import 'widgets/checkout_shimmer_widget.dart';
import 'widgets/checkout_user_info_card_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String name = AppRoutes.checkoutScreen;

  static void navigateToMe() => navigateTo(name);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final CheckoutController _controller = CheckoutController(CartCubit.i);

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
    _controller.init();
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  // --------------------------[ Build ]-------------------------- //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // --------------------------[ AppBar ]-------------------------- //
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: BackButton(onPressed: _controller.onBackTap),
      title: Text(AppStrings.checkOut.tx()),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return BlockBuilderWidget2<CartCubit, dynamic>(
      types: [_controller.checkoutState],
      body: (_, state) => _buildCheckoutContent(state),
    );
  }

  // --------------------------[ Checkout Content ]-------------------------- //
  Widget _buildCheckoutContent(StateType state) {
    if (state == StateType.loading && _controller.hasNoCheckoutData) {
      return const CheckoutShimmerWidget();
    }
    if (state.isError() && _controller.hasNoCheckoutData) {
      return CustomErrorWidget(
        message: _controller.errorMessage,
        onRetry: _controller.onRetry,
      );
    }

    return Column(
      children: [
        // --------------------------[ Scrollable Form & Order Summary ]-------------------------- //
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --------------------------[ Customer Info Card ]-------------------------- //
                CheckoutUserInfoCardWidget(controller: _controller),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                // --------------------------[ Order Summary Card ]-------------------------- //
                CheckoutOrderSummaryCardWidget(
                  items: _controller.checkoutItems,
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
              ],
            ),
          ),
        ),
        // --------------------------[ Total Price & Order Now Bar ]-------------------------- //
        _buildBottomBarSection(),
      ],
    );
  }

  // --------------------------[ Bottom Bar Section ]-------------------------- //
  Widget _buildBottomBarSection() {
    return BlockBuilderWidget2<CartCubit, dynamic>(
      types: [_controller.placeOrderState],
      body: (_, state) => CheckoutBottomBarWidget(
        totalPrice: _controller.totalPrice,
        isLoading: state == StateType.loading,
        onOrderNowTap: _controller.onOrderNowTap,
      ),
    );
  }
}
