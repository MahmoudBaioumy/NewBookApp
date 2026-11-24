import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_error_widget.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../cubit/cart_cubit.dart';
import 'cart_controller.dart';
import 'widgets/cart_checkout_bottom_bar_widget.dart';
import 'widgets/cart_empty_widget.dart';
import 'widgets/cart_shimmer_widget.dart';
import 'widgets/staggered_cart_list_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String name = AppRoutes.cartScreen;

  static void navigateToMe() => navigateTo(name);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final CartController _controller = CartController(CartCubit.i);

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
  void reassemble() {
    super.reassemble();
    if (_controller.hasNoCartItems) {
      _controller.init();
    }
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
      body: _buildBody(),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: Dimensions.paddingSizeDefault),
          // --------------------------[ Cart Section ]-------------------------- //
          Expanded(child: _buildCartSection()),
        ],
      ),
    );
  }

  // --------------------------[ Cart Section ]-------------------------- //
  Widget _buildCartSection() {
    return BlockBuilderWidget2<CartCubit, dynamic>(
      types: [_controller.cartState],
      body: (_, state) => _buildCartContent(state),
    );
  }

  // --------------------------[ Cart Content ]-------------------------- //
  Widget _buildCartContent(StateType state) {
    if (state == StateType.loading) {
      return const CartShimmerWidget();
    }
    if (state.isError() && _controller.hasNoCartItems) {
      return CustomErrorWidget(
        message: _controller.errorMessage,
        onRetry: _controller.onRetry,
      );
    }
    if (_controller.hasNoCartItems) {
      return const CartEmptyWidget();
    }
    return Column(
      children: [
        // --------------------------[ Staggered Cart Items List ]-------------------------- //
        Expanded(
          child: StaggeredCartListWidget(
            items: _controller.cartItems,
            getItemQuantity: _controller.getItemQuantity,
            onItemTap: _controller.onItemTap,
            onIncrementQuantityTap: _controller.onIncrementQuantityTap,
            onDecrementQuantityTap: _controller.onDecrementQuantityTap,
            onRemoveItemTap: _controller.onRemoveItemTap,
          ),
        ),
        // --------------------------[ Total Price & CheckOut Bar ]-------------------------- //
        CartCheckoutBottomBarWidget(
          totalPrice: _controller.totalCartPrice,
          onCheckoutTap: _controller.onCheckoutTap,
        ),
      ],
    );
  }
}
