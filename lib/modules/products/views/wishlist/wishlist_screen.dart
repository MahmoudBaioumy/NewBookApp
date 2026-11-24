import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_error_widget.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';
import '../books_list/widgets/staggered_books_list_widget.dart';
import 'widgets/wishlist_empty_widget.dart';
import 'widgets/wishlist_shimmer_widget.dart';
import 'wishlist_controller.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = AppRoutes.wishlistScreen;

  static void navigateToMe() => navigateTo(name);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final WishlistController _controller = WishlistController(
    ProductsCubit.i,
  );

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
    if (_controller.hasNoWishlistBooks) {
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
          // --------------------------[ Wishlist Books List ]-------------------------- //
          Expanded(child: _buildWishlistSection()),
        ],
      ),
    );
  }

  // --------------------------[ Wishlist Books List ]-------------------------- //
  Widget _buildWishlistSection() {
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: [_controller.wishlistState],
      body: (_, state) => _buildWishlistContent(state),
    );
  }

  // --------------------------[ Wishlist Content ]-------------------------- //
  Widget _buildWishlistContent(StateType state) {
    if (state == StateType.loading) {
      return const WishlistShimmerWidget();
    }
    if (state.isError() && _controller.hasNoWishlistBooks) {
      return CustomErrorWidget(
        message: _controller.errorMessage,
        onRetry: _controller.onRetry,
      );
    }
    if (_controller.hasNoWishlistBooks) {
      return const WishlistEmptyWidget();
    }
    return StaggeredBooksListWidget(
      books: _controller.wishlistBooks,
      isBookFavorite: _controller.isBookFavorite,
      onBookTap: _controller.onBookTap,
      onToggleFavoriteTap: _controller.onToggleFavoriteTap,
      onAddToCartTap: _controller.onAddToCartTap,
    );
  }
}
