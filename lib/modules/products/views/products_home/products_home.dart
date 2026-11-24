import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_error_widget.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';
import '../../widgets/book_horizontal_list_widget.dart';
import '../../widgets/home_categories_list_widget.dart';
import '../../widgets/home_header_widget.dart';
import '../../widgets/home_top_slider_widget.dart';
import '../../widgets/promo_banner_slider_widget.dart';
import '../../widgets/section_header_widget.dart';
import 'products_home_controller.dart';

class ProductsHomeScreen extends StatefulWidget {
  const ProductsHomeScreen({super.key});

  @override
  State<ProductsHomeScreen> createState() => _ProductsHomeScreenState();
}

class _ProductsHomeScreenState extends State<ProductsHomeScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final ProductsHomeController _controller = ProductsHomeController(
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.paddingSizeDefault),
            // --------------------------[ Header ]-------------------------- //
            _buildHeader(),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            // --------------------------[ Top Banner Carousel ]-------------------------- //
            _buildTopBannerSlider(),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            // --------------------------[ Best Seller Header ]-------------------------- //
            _buildBestSellerHeader(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ Best Seller List ]-------------------------- //
            _buildBestSellerList(),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            // --------------------------[ Promo Banner Slider ]-------------------------- //
            _buildPromoBannerSlider(),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            // --------------------------[ Categories Header ]-------------------------- //
            _buildCategoriesHeader(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ Categories List ]-------------------------- //
            _buildCategoriesList(),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            // --------------------------[ New Arrivals Header ]-------------------------- //
            _buildNewArrivalsHeader(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ New Arrivals List ]-------------------------- //
            _buildNewArrivalsList(),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Header ]-------------------------- //
  Widget _buildHeader() {
    return HomeHeaderWidget(
      userName: _controller.userName,
      userAvatarUrl: _controller.userAvatarUrl,
      onMenuTap: _controller.onMenuTap,
      onAvatarTap: _controller.onAvatarTap,
    );
  }

  // --------------------------[ Top Banner Carousel ]-------------------------- //
  Widget _buildTopBannerSlider() {
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: [_controller.slidersState],
      body: (_, state) => _buildTopBannerSliderContent(state),
    );
  }

  // --------------------------[ Top Banner Carousel Content ]-------------------------- //
  Widget _buildTopBannerSliderContent(StateType state) {
    if (state.isError() && _controller.hasNoTopBanners) {
      return CustomErrorWidget(
        message: _controller.slidersErrorMessage,
        onRetry: _controller.onRetryTopBanners,
      );
    }
    return HomeTopSliderWidget(
      banners: _controller.topBanners,
      pageController: _controller.topBannerPageController,
      isLoading: state == StateType.loading,
      onPageChanged: _controller.onTopBannerPageChanged,
      onBannerTap: _controller.onTopBannerTap,
    );
  }

  // --------------------------[ Best Seller Header ]-------------------------- //
  Widget _buildBestSellerHeader() {
    return SectionHeaderWidget(
      title: AppStrings.bestSeller.tx(),
      onSeeAllTap: _controller.onSeeAllBestSellersTap,
    );
  }

  // --------------------------[ Best Seller List ]-------------------------- //
  Widget _buildBestSellerList() {
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: [_controller.bestSellersState],
      body: (_, state) => _buildBestSellerListContent(state),
    );
  }

  // --------------------------[ Best Seller List Content ]-------------------------- //
  Widget _buildBestSellerListContent(StateType state) {
    if (state.isError() && _controller.hasNoBestSellerBooks) {
      return CustomErrorWidget(
        message: _controller.bestSellersErrorMessage,
        onRetry: _controller.onRetryBestSellers,
      );
    }
    return BookHorizontalListWidget(
      books: _controller.bestSellerBooks,
      isLoading: state == StateType.loading,
      onBookTap: _controller.onBookTap,
    );
  }

  // --------------------------[ Promo Banner Slider ]-------------------------- //
  Widget _buildPromoBannerSlider() {
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: const [ProductsCubitTypes.promoBanners],
      body: (_, state) => PromoBannerSliderWidget(
        banners: _controller.promoBanners,
        currentIndex: _controller.currentPromoBannerIndex,
        isLoading: state == StateType.loading,
        onPageChanged: _controller.onPromoBannerPageChanged,
        onBannerTap: _controller.onPromoBannerTap,
      ),
    );
  }

  // --------------------------[ Categories Header ]-------------------------- //
  Widget _buildCategoriesHeader() {
    return SectionHeaderWidget(
      title: AppStrings.categories.tx(),
      onSeeAllTap: _controller.onSeeAllCategoriesTap,
    );
  }

  // --------------------------[ Categories List ]-------------------------- //
  Widget _buildCategoriesList() {
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: [_controller.categoriesState],
      body: (_, state) => _buildCategoriesListContent(state),
    );
  }

  // --------------------------[ Categories List Content ]-------------------------- //
  Widget _buildCategoriesListContent(StateType state) {
    if (state.isError() && _controller.hasNoCategories) {
      return CustomErrorWidget(
        message: _controller.categoriesErrorMessage,
        onRetry: _controller.onRetryCategories,
      );
    }
    return HomeCategoriesListWidget(
      categories: _controller.categories,
      isLoading: state == StateType.loading,
      onCategoryTap: _controller.onCategoryTap,
    );
  }

  // --------------------------[ New Arrivals Header ]-------------------------- //
  Widget _buildNewArrivalsHeader() {
    return SectionHeaderWidget(
      title: AppStrings.newArrivals.tx(),
      onSeeAllTap: _controller.onSeeAllNewArrivalsTap,
    );
  }

  // --------------------------[ New Arrivals List ]-------------------------- //
  Widget _buildNewArrivalsList() {
    return BlockBuilderWidget2<ProductsCubit, dynamic>(
      types: [_controller.newArrivalsState],
      body: (_, state) => _buildNewArrivalsListContent(state),
    );
  }

  // --------------------------[ New Arrivals List Content ]-------------------------- //
  Widget _buildNewArrivalsListContent(StateType state) {
    if (state.isError() && _controller.hasNoNewArrivalBooks) {
      return CustomErrorWidget(
        message: _controller.newArrivalsErrorMessage,
        onRetry: _controller.onRetryNewArrivals,
      );
    }
    return BookHorizontalListWidget(
      books: _controller.newArrivalBooks,
      isLoading: state == StateType.loading,
      onBookTap: _controller.onBookTap,
    );
  }
}
