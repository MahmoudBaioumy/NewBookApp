import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/constants/app_api.dart';
import 'package:flustra_template/core/helper/shared_methods.dart';

import 'requests/place_order_request.dart';
import 'responses/cart_response.dart';
import 'responses/checkout_response.dart';
import 'responses/place_order_response.dart';

abstract class CartRepo {
  // --------------------------[ getCart ]-------------------------- //
  Future<Either<Failure, CartResponse>> getCart({
    CancelToken? cancelToken,
  });

  // --------------------------[ addToCart ]-------------------------- //
  Future<Either<Failure, CartResponse>> addToCart({
    required int productId,
    CancelToken? cancelToken,
  });

  // --------------------------[ updateCart ]-------------------------- //
  Future<Either<Failure, CartResponse>> updateCart({
    required int cartItemId,
    required int quantity,
    CancelToken? cancelToken,
  });

  // --------------------------[ removeFromCart ]-------------------------- //
  Future<Either<Failure, CartResponse>> removeFromCart({
    required int cartItemId,
    int? productId,
    CancelToken? cancelToken,
  });

  // --------------------------[ getCheckout ]-------------------------- //
  Future<Either<Failure, CheckoutResponse>> getCheckout({
    CancelToken? cancelToken,
  });

  // --------------------------[ placeOrder ]-------------------------- //
  Future<Either<Failure, PlaceOrderResponse>> placeOrder({
    required PlaceOrderRequest request,
    CancelToken? cancelToken,
  });
}

class CartImp implements CartRepo {
  // --------------------------[ getCart ]-------------------------- //
  @override
  Future<Either<Failure, CartResponse>> getCart({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<CartResponse>(
      endPoint: ApiConstants.cart.cart,
      asObject: (json) => CartResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ addToCart ]-------------------------- //
  @override
  Future<Either<Failure, CartResponse>> addToCart({
    required int productId,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<CartResponse>(
      endPoint: ApiConstants.cart.addToCart,
      asObject: (json) => CartResponse.fromJson(json),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: {'product_id': productId},
    );
  }

  // --------------------------[ updateCart ]-------------------------- //
  @override
  Future<Either<Failure, CartResponse>> updateCart({
    required int cartItemId,
    required int quantity,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<CartResponse>(
      endPoint: ApiConstants.cart.updateCart,
      asObject: (json) => CartResponse.fromJson(json),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: {
        'cart_item_id': cartItemId,
        'quantity': quantity,
      },
    );
  }

  // --------------------------[ removeFromCart ]-------------------------- //
  @override
  Future<Either<Failure, CartResponse>> removeFromCart({
    required int cartItemId,
    int? productId,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<CartResponse>(
      endPoint: ApiConstants.cart.removeFromCart,
      asObject: (json) => CartResponse.fromJson(json),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: {
        'cart_item_id': cartItemId,
        if (productId != null) 'product_id': productId,
      },
    );
  }

  // --------------------------[ getCheckout ]-------------------------- //
  @override
  Future<Either<Failure, CheckoutResponse>> getCheckout({
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<CheckoutResponse>(
      endPoint: ApiConstants.cart.checkout,
      asObject: (json) => CheckoutResponse.fromJson(json),
      method: DioMethod.get,
      cancelToken: cancelToken,
    );
  }

  // --------------------------[ placeOrder ]-------------------------- //
  @override
  Future<Either<Failure, PlaceOrderResponse>> placeOrder({
    required PlaceOrderRequest request,
    CancelToken? cancelToken,
  }) async {
    return await handleResponse<PlaceOrderResponse>(
      endPoint: ApiConstants.cart.placeOrder,
      asObject: (json) => PlaceOrderResponse.fromJson(json),
      method: DioMethod.post,
      cancelToken: cancelToken,
      data: request.toJson(),
    );
  }
}
