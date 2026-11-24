import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';

import '../products_fake_data.dart';
import '../responses/categories_response.dart';
import '../responses/product_details_response.dart';
import '../responses/products_response.dart';
import '../responses/sliders_response.dart';
import '../responses/wishlist_response.dart';

abstract class ProductsRepo {
  // --------------------------[ getSliders ]-------------------------- //
  Future<Either<Failure, SlidersResponse>> getSliders({
    CancelToken? cancelToken,
  });

  Future<Either<Failure, List<String>>> getPromoBanners();

  // --------------------------[ getCategories ]-------------------------- //
  Future<Either<Failure, CategoriesResponse>> getCategories({
    CancelToken? cancelToken,
  });

  // --------------------------[ getBestSellerBooks ]-------------------------- //
  Future<Either<Failure, ProductsResponse>> getBestSellerBooks({
    CancelToken? cancelToken,
  });

  // --------------------------[ getNewArrivalBooks ]-------------------------- //
  Future<Either<Failure, ProductsResponse>> getNewArrivalBooks({
    CancelToken? cancelToken,
  });

  // --------------------------[ getProductDetails ]-------------------------- //
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails({
    required int productId,
    CancelToken? cancelToken,
  });

  // --------------------------[ getWishlist ]-------------------------- //
  Future<Either<Failure, WishlistResponse>> getWishlist({
    CancelToken? cancelToken,
  });

  // --------------------------[ addToWishlist ]-------------------------- //
  Future<Either<Failure, WishlistResponse>> addToWishlist({
    required int productId,
    CancelToken? cancelToken,
  });
}

class ProductsImp implements ProductsRepo {
  // --------------------------[ getSliders ]-------------------------- //
  @override
  Future<Either<Failure, SlidersResponse>> getSliders({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<SlidersResponse>(
      endPoint: ApiConstants.products.sliders,
      asObject: (json) => SlidersResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<Failure, List<String>>> getPromoBanners() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return right(FakeProductsData.promoBannerImages);
  }

  // --------------------------[ getCategories ]-------------------------- //
  @override
  Future<Either<Failure, CategoriesResponse>> getCategories({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<CategoriesResponse>(
      endPoint: ApiConstants.products.categories,
      asObject: (json) => CategoriesResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ getBestSellerBooks ]-------------------------- //
  @override
  Future<Either<Failure, ProductsResponse>> getBestSellerBooks({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<ProductsResponse>(
      endPoint: ApiConstants.products.bestSeller,
      asObject: (json) => ProductsResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ getNewArrivalBooks ]-------------------------- //
  @override
  Future<Either<Failure, ProductsResponse>> getNewArrivalBooks({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<ProductsResponse>(
      endPoint: ApiConstants.products.newArrivals,
      asObject: (json) => ProductsResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ getProductDetails ]-------------------------- //
  @override
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails({
    required int productId,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<ProductDetailsResponse>(
      endPoint: ApiConstants.products.productDetails(productId),
      asObject: (json) => ProductDetailsResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ getWishlist ]-------------------------- //
  @override
  Future<Either<Failure, WishlistResponse>> getWishlist({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<WishlistResponse>(
      endPoint: ApiConstants.products.wishlist,
      asObject: (json) => WishlistResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ addToWishlist ]-------------------------- //
  @override
  Future<Either<Failure, WishlistResponse>> addToWishlist({
    required int productId,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<WishlistResponse>(
      endPoint: ApiConstants.products.addToWishlist,
      asObject: (json) => WishlistResponse.fromJson(json),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: {'product_id': productId},
    );
  }
}
