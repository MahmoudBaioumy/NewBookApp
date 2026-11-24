import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/modules/products/data/products_fake_data.dart';
import 'package:flustra_template/modules/products/data/responses/categories_response.dart';
import 'package:flustra_template/modules/products/data/responses/products_response.dart';
import 'package:flustra_template/modules/products/data/responses/sliders_response.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_controller.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_screen.dart';
import 'package:flustra_template/modules/products/views/books_list/books_list_controller.dart';
import 'package:flustra_template/modules/products/views/books_list/books_list_screen.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';

class ProductsHomeController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  ProductsHomeController(this._productsCubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  final ProductsCubit _productsCubit;
  final CancelToken _slidersCancelToken = CancelToken();
  final CancelToken _categoriesCancelToken = CancelToken();
  final CancelToken _bestSellersCancelToken = CancelToken();
  final CancelToken _newArrivalsCancelToken = CancelToken();

  final String slidersState = UniqueKey().toString();
  final String categoriesState = UniqueKey().toString();
  final String bestSellersState = UniqueKey().toString();
  final String newArrivalsState = UniqueKey().toString();

  final PageController topBannerPageController = PageController(
    viewportFraction: Dimensions.bannerTopViewportFraction,
  );

  SlidersResponse? _slidersResponse;
  CategoriesResponse? _categoriesResponse;
  ProductsResponse? _bestSellersResponse;
  ProductsResponse? _newArrivalsResponse;

  String? _slidersErrorMessage;
  String? _categoriesErrorMessage;
  String? _bestSellersErrorMessage;
  String? _newArrivalsErrorMessage;

  int _currentTopBannerIndex = 0;
  int _currentPromoBannerIndex = 0;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String get userName {
    final sessionName = AppSessionManager.name;
    if (sessionName != null && sessionName.trim().isNotEmpty) {
      return sessionName;
    }
    return FakeProductsData.defaultUserName;
  }

  String get userAvatarUrl {
    final sessionImage = AppSessionManager.image;
    if (sessionImage != null && sessionImage.trim().isNotEmpty) {
      return sessionImage;
    }
    return FakeProductsData.defaultUserAvatarUrl;
  }

  String? get slidersErrorMessage => _slidersErrorMessage;

  String? get categoriesErrorMessage => _categoriesErrorMessage;

  String? get bestSellersErrorMessage => _bestSellersErrorMessage;

  String? get newArrivalsErrorMessage => _newArrivalsErrorMessage;

  int get currentTopBannerIndex => _currentTopBannerIndex;

  int get currentPromoBannerIndex => _currentPromoBannerIndex;

  List<SliderItemResponse> get sliders =>
      _slidersResponse?.data?.sliders ??
      _productsCubit.slidersResponse?.data?.sliders ??
      [];

  List<String> get topBanners => sliders
      .map((slider) => slider.image ?? '')
      .where((imageUrl) => imageUrl.isNotEmpty)
      .toList();

  bool get hasNoTopBanners => topBanners.isEmpty;

  List<String> get promoBanners => _productsCubit.promoBanners;

  List<CategoryItemResponse> get categoryItems =>
      _categoriesResponse?.data?.categories ??
      _productsCubit.categoriesResponse?.data?.categories ??
      [];

  List<BookCategoryModel> get categories =>
      categoryItems.map((item) => item.toBookCategoryModel()).toList();

  bool get hasNoCategories => categories.isEmpty;

  List<ProductItemResponse> get bestSellerProductItems =>
      _bestSellersResponse?.data?.products ??
      _productsCubit.bestSellersResponse?.data?.products ??
      [];

  List<Product> get bestSellerBooks =>
      bestSellerProductItems.map((item) => item.toProduct()).toList();

  bool get hasNoBestSellerBooks => bestSellerBooks.isEmpty;

  List<ProductItemResponse> get newArrivalProductItems =>
      _newArrivalsResponse?.data?.products ??
      _productsCubit.newArrivalsResponse?.data?.products ??
      [];

  List<Product> get newArrivalBooks =>
      newArrivalProductItems.map((item) => item.toProduct()).toList();

  bool get hasNoNewArrivalBooks => newArrivalBooks.isEmpty;

  // ========================== 🔥 initialization 🔥 ========================== //
  // --------------------------[ init ]-------------------------- //
  void init() {
    _loadAllHomeData();
  }

  // ========================== 🌍 Public events 🌍 ========================== //
  // --------------------------[ onRetryTopBanners ]-------------------------- //
  void onRetryTopBanners() {
    _loadSliders();
  }

  // --------------------------[ onRetryCategories ]-------------------------- //
  void onRetryCategories() {
    _loadCategories();
  }

  // --------------------------[ onRetryBestSellers ]-------------------------- //
  void onRetryBestSellers() {
    _loadBestSellerBooks();
  }

  // --------------------------[ onRetryNewArrivals ]-------------------------- //
  void onRetryNewArrivals() {
    _loadNewArrivalBooks();
  }

  // --------------------------[ onMenuTap ]-------------------------- //
  void onMenuTap() {
    debugPrint('onMenuTap triggered');
    // TODO: Open drawer or filter bottom sheet when requested
  }

  // --------------------------[ onAvatarTap ]-------------------------- //
  void onAvatarTap() {
    debugPrint('onAvatarTap triggered');
    // TODO: Navigate to profile screen when requested
  }

  // --------------------------[ onTopBannerPageChanged ]-------------------------- //
  void onTopBannerPageChanged(int index) {
    if (_currentTopBannerIndex == index) return;
    _currentTopBannerIndex = index;
    notifyListeners();
  }

  // --------------------------[ onTopBannerTap ]-------------------------- //
  void onTopBannerTap(int index) {
    debugPrint('onTopBannerTap: $index');
    // TODO: Handle top banner tap action
  }

  // --------------------------[ onPromoBannerPageChanged ]-------------------------- //
  void onPromoBannerPageChanged(int index) {
    if (_currentPromoBannerIndex == index) return;
    _currentPromoBannerIndex = index;
    notifyListeners();
  }

  // --------------------------[ onPromoBannerTap ]-------------------------- //
  void onPromoBannerTap(int index) {
    debugPrint('onPromoBannerTap: $index');
    // TODO: Handle promo banner tap action
  }

  // --------------------------[ onSeeAllBestSellersTap ]-------------------------- //
  void onSeeAllBestSellersTap() {
    BooksListScreen.navigateToMe(
      BooksListScreenArgs(
        title: AppStrings.bestSeller.tx(),
        productsResponse:
            _bestSellersResponse ?? _productsCubit.bestSellersResponse,
        books: bestSellerBooks,
      ),
    );
  }

  // --------------------------[ onSeeAllCategoriesTap ]-------------------------- //
  void onSeeAllCategoriesTap() {
    debugPrint('onSeeAllCategoriesTap triggered');
    // TODO: Navigate to all categories screen
  }

  // --------------------------[ onSeeAllNewArrivalsTap ]-------------------------- //
  void onSeeAllNewArrivalsTap() {
    BooksListScreen.navigateToMe(
      BooksListScreenArgs(
        title: AppStrings.newArrivals.tx(),
        productsResponse:
            _newArrivalsResponse ?? _productsCubit.newArrivalsResponse,
        books: newArrivalBooks,
      ),
    );
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

  // --------------------------[ onCategoryTap ]-------------------------- //
  void onCategoryTap(BookCategoryModel category) {
    debugPrint('onCategoryTap: ${category.name}');
    // TODO: Navigate to category books screen
  }

  // ========================== 🔒 Private methods 🔒 ========================== //
  // --------------------------[ _loadAllHomeData ]-------------------------- //
  Future<void> _loadAllHomeData() async {
    _loadSliders();
    _loadBestSellerBooks();
    _productsCubit.getPromoBanners();
    _loadCategories();
    _loadNewArrivalBooks();
  }

  // --------------------------[ _loadSliders ]-------------------------- //
  Future<void> _loadSliders() async {
    final res = await _productsCubit.getSliders(
      cancelToken: _slidersCancelToken,
      state: slidersState,
    );
    res.fold(
      (Failure failure) {
        _slidersErrorMessage = failure.message;
        failure.showToast();
      },
      (SlidersResponse response) {
        _slidersErrorMessage = null;
        _slidersResponse = response;
      },
    );
  }

  // --------------------------[ _loadCategories ]-------------------------- //
  Future<void> _loadCategories() async {
    final res = await _productsCubit.getCategories(
      cancelToken: _categoriesCancelToken,
      state: categoriesState,
    );
    res.fold(
      (Failure failure) {
        _categoriesErrorMessage = failure.message;
        failure.showToast();
      },
      (CategoriesResponse response) {
        _categoriesErrorMessage = null;
        _categoriesResponse = response;
      },
    );
  }

  // --------------------------[ _loadBestSellerBooks ]-------------------------- //
  Future<void> _loadBestSellerBooks() async {
    final res = await _productsCubit.getBestSellerBooks(
      cancelToken: _bestSellersCancelToken,
      state: bestSellersState,
    );
    res.fold(
      (Failure failure) {
        _bestSellersErrorMessage = failure.message;
        failure.showToast();
      },
      (ProductsResponse response) {
        _bestSellersErrorMessage = null;
        _bestSellersResponse = response;
      },
    );
  }

  // --------------------------[ _loadNewArrivalBooks ]-------------------------- //
  Future<void> _loadNewArrivalBooks() async {
    final res = await _productsCubit.getNewArrivalBooks(
      cancelToken: _newArrivalsCancelToken,
      state: newArrivalsState,
    );
    res.fold(
      (Failure failure) {
        _newArrivalsErrorMessage = failure.message;
        failure.showToast();
      },
      (ProductsResponse response) {
        _newArrivalsErrorMessage = null;
        _newArrivalsResponse = response;
      },
    );
  }

  @override
  void dispose() {
    _slidersCancelToken.cancel();
    _categoriesCancelToken.cancel();
    _bestSellersCancelToken.cancel();
    _newArrivalsCancelToken.cancel();
    _productsCubit.disposeState(slidersState);
    _productsCubit.disposeState(categoriesState);
    _productsCubit.disposeState(bestSellersState);
    _productsCubit.disposeState(newArrivalsState);
    topBannerPageController.dispose();
    super.dispose();
  }
}
