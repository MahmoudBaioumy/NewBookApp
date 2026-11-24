import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_error_widget.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';
import 'book_details_controller.dart';
import 'widgets/book_details_bottom_action_widget.dart';
import 'widgets/book_details_cover_header_widget.dart';
import 'widgets/book_details_info_section_widget.dart';
import 'widgets/book_details_shimmer_widget.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, this.args});

  final BookDetailsScreenArgs? args;

  static const String name = AppRoutes.bookDetailsScreen;

  static void navigateToMe(BookDetailsScreenArgs args) =>
      navigateTo(name, arguments: args);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final BookDetailsController _controller = BookDetailsController(
    ProductsCubit.i,
    args: widget.args,
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
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: [_controller.productDetailsState],
      body: (_, state) => _buildScreenContent(state),
    );
  }

  // --------------------------[ Screen Content ]-------------------------- //
  Widget _buildScreenContent(StateType state) {
    if (state == StateType.loading) {
      return const BookDetailsShimmerWidget();
    }
    if (state.isError() && _controller.hasNoBookData) {
      return CustomErrorWidget(
        message: _controller.errorMessage,
        onRetry: _controller.onRetry,
      );
    }
    final currentBook = _controller.book;
    if (currentBook == null) return const SizedBox.shrink();

    return Column(
      children: [
        // --------------------------[ Scrollable Book Details ]-------------------------- //
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------------------------[ Hero Cover Header ]-------------------------- //
                _buildCoverHeader(currentBook.imageUrl),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                // --------------------------[ Book Info & Description ]-------------------------- //
                BookDetailsInfoSectionWidget(book: currentBook),
                const SizedBox(height: Dimensions.paddingSizeLarge),
              ],
            ),
          ),
        ),
        // --------------------------[ Add To Cart Bottom Button ]-------------------------- //
        _buildBottomAction(),
      ],
    );
  }

  // --------------------------[ Hero Cover Header ]-------------------------- //
  Widget _buildCoverHeader(String imageUrl) {
    return BookDetailsCoverHeaderWidget(
      imageUrl: imageUrl,
      isFavorite: _controller.isFavorite,
      onBackTap: _controller.onBackTap,
      onFavoriteTap: _controller.onToggleFavoriteTap,
    );
  }

  // --------------------------[ Add To Cart Bottom Button ]-------------------------- //
  Widget _buildBottomAction() {
    return BookDetailsBottomActionWidget(
      onAddToCartTap: _controller.onAddToCartTap,
    );
  }
}
