import 'package:dio/dio.dart';
import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';

import '../data/products/repo.dart';
import '../data/responses/categories_response.dart';
import '../data/responses/product_details_response.dart';
import '../data/responses/products_response.dart';
import '../data/responses/sliders_response.dart';
import '../data/responses/wishlist_response.dart';

enum ProductsCubitTypes {
  none,
  sliders,
  promoBanners,
  categories,
  bestSellers,
  newArrivals,
  productDetails,
  wishlist,
  addToWishlist,
}

class ProductsCubit extends BaseCubit<dynamic> {
  ProductsCubit() : super(ProductsCubitTypes.none);

  static ProductsCubit get i => getIt<ProductsCubit>();
  static ProductsCubit get() => getIt<ProductsCubit>();

  final ProductsRepo _repo = ProductsImp();

  // ========================== 🔥 Data Cache 🔥 ==========================
  SlidersResponse? slidersResponse;
  CategoriesResponse? categoriesResponse;
  ProductsResponse? bestSellersResponse;
  ProductsResponse? newArrivalsResponse;
  ProductDetailsResponse? productDetailsResponse;
  WishlistResponse? wishlistResponse;
  final Set<int> favoriteProductIds = <int>{};
  List<String> promoBanners = [];

  // --------------------------[ isProductFavorite ]-------------------------- //
  bool isProductFavorite(int? productId) {
    if (productId == null) return false;
    return favoriteProductIds.contains(productId);
  }

  // --------------------------[ _syncFavoriteIdsFromWishlist ]-------------------------- //
  void _syncFavoriteIdsFromWishlist(WishlistResponse response) {
    final items = response.data?.items ?? [];
    for (final item in items) {
      if (item.id != null) {
        favoriteProductIds.add(item.id!);
      }
    }
  }

  // --------------------------[ getSliders ]-------------------------- //
  BaseEitherResponse<SlidersResponse> getSliders({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<SlidersResponse>(
      type: state ?? ProductsCubitTypes.sliders,
      fun: () => _repo.getSliders(cancelToken: cancelToken),
      onSuccess: (response) => slidersResponse = response,
      onFailure: (failure) => failure.printInfo("getSliders"),
    );
  }

  // --------------------------[ getPromoBanners ]-------------------------- //
  BaseEitherResponse<List<String>> getPromoBanners() {
    return fastFire<List<String>>(
      type: ProductsCubitTypes.promoBanners,
      fun: _repo.getPromoBanners,
      onSuccess: (banners) => promoBanners = banners,
    );
  }

  // --------------------------[ getCategories ]-------------------------- //
  BaseEitherResponse<CategoriesResponse> getCategories({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<CategoriesResponse>(
      type: state ?? ProductsCubitTypes.categories,
      fun: () => _repo.getCategories(cancelToken: cancelToken),
      onSuccess: (response) => categoriesResponse = response,
      onFailure: (failure) => failure.printInfo("getCategories"),
    );
  }

  // --------------------------[ getBestSellerBooks ]-------------------------- //
  BaseEitherResponse<ProductsResponse> getBestSellerBooks({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<ProductsResponse>(
      type: state ?? ProductsCubitTypes.bestSellers,
      fun: () => _repo.getBestSellerBooks(cancelToken: cancelToken),
      onSuccess: (response) => bestSellersResponse = response,
      onFailure: (failure) => failure.printInfo("getBestSellerBooks"),
    );
  }

  // --------------------------[ getNewArrivalBooks ]-------------------------- //
  BaseEitherResponse<ProductsResponse> getNewArrivalBooks({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<ProductsResponse>(
      type: state ?? ProductsCubitTypes.newArrivals,
      fun: () => _repo.getNewArrivalBooks(cancelToken: cancelToken),
      onSuccess: (response) => newArrivalsResponse = response,
      onFailure: (failure) => failure.printInfo("getNewArrivalBooks"),
    );
  }

  // --------------------------[ getProductDetails ]-------------------------- //
  BaseEitherResponse<ProductDetailsResponse> getProductDetails({
    required int productId,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<ProductDetailsResponse>(
      type: state ?? ProductsCubitTypes.productDetails,
      fun: () => _repo.getProductDetails(
        productId: productId,
        cancelToken: cancelToken,
      ),
      onSuccess: (response) => productDetailsResponse = response,
      onFailure: (failure) => failure.printInfo("getProductDetails"),
    );
  }

  // --------------------------[ getWishlist ]-------------------------- //
  BaseEitherResponse<WishlistResponse> getWishlist({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<WishlistResponse>(
      type: state ?? ProductsCubitTypes.wishlist,
      fun: () => _repo.getWishlist(cancelToken: cancelToken),
      onSuccess: (response) {
        wishlistResponse = response;
        _syncFavoriteIdsFromWishlist(response);
      },
      onFailure: (failure) => failure.printInfo("getWishlist"),
    );
  }

  // --------------------------[ addToWishlist ]-------------------------- //
  BaseEitherResponse<WishlistResponse> addToWishlist({
    required int productId,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<WishlistResponse>(
      type: state ?? ProductsCubitTypes.addToWishlist,
      callLoading: false,
      fun: () => _repo.addToWishlist(
        productId: productId,
        cancelToken: cancelToken,
      ),
      onSuccess: (response) {
        wishlistResponse = response;
        _syncFavoriteIdsFromWishlist(response);
      },
      onFailure: (failure) => failure.printInfo("addToWishlist"),
    );
  }
}
