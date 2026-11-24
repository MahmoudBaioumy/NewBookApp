import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';
import 'books_list_controller.dart';
import 'widgets/staggered_books_list_widget.dart';

class BooksListScreen extends StatefulWidget {
  const BooksListScreen({super.key, this.args});

  final BooksListScreenArgs? args;

  static const String name = AppRoutes.booksListScreen;

  static void navigateToMe(BooksListScreenArgs args) =>
      navigateTo(name, arguments: args);

  @override
  State<BooksListScreen> createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final BooksListController _controller = BooksListController(
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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // --------------------------[ AppBar ]-------------------------- //
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _controller.canShowBackButton
          ? BackButton(onPressed: _controller.onBackTap)
          : null,
      title: Text(
        _controller.screenTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: Dimensions.paddingSizeSmall),
          // --------------------------[ Staggered Books List ]-------------------------- //
          Expanded(child: _buildBooksList()),
        ],
      ),
    );
  }

  // --------------------------[ Staggered Books List ]-------------------------- //
  Widget _buildBooksList() {
    return StaggeredBooksListWidget(
      books: _controller.books,
      isBookFavorite: _controller.isBookFavorite,
      onBookTap: _controller.onBookTap,
      onToggleFavoriteTap: _controller.onToggleFavoriteTap,
      onAddToCartTap: _controller.onAddToCartTap,
    );
  }
}
