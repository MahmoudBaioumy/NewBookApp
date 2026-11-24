import 'package:dio/dio.dart';
import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';

import '../data/cart_repo.dart';
import '../data/requests/place_order_request.dart';
import '../data/responses/cart_response.dart';
import '../data/responses/checkout_response.dart';
import '../data/responses/place_order_response.dart';

enum CartCubitTypes {
  none,
  getCart,
  addToCart,
  updateCart,
  removeFromCart,
  getCheckout,
  placeOrder,
}

class CartCubit extends BaseCubit<dynamic> {
  final CartRepo _repo;

  CartCubit(this._repo) : super(CartCubitTypes.none);

  static CartCubit get i => getIt<CartCubit>();

  // ========================== 🔥 Data Cache 🔥 ========================== //
  CartResponse? cartResponse;
  CheckoutResponse? checkoutResponse;

  // --------------------------[ clearCartData ]-------------------------- //
  void clearCartData() {
    cartResponse = CartResponse(
      data: CartDataResponse(
        total: '0.00',
        cartItems: [],
      ),
    );
    checkoutResponse = null;
  }

  // --------------------------[ getCart ]-------------------------- //
  BaseEitherResponse<CartResponse> getCart({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<CartResponse>(
      type: state ?? CartCubitTypes.getCart,
      fun: () => _repo.getCart(cancelToken: cancelToken),
      onSuccess: (response) => cartResponse = response,
      onFailure: (failure) => failure.printInfo('getCart'),
    );
  }

  // --------------------------[ addToCart ]-------------------------- //
  BaseEitherResponse<CartResponse> addToCart({
    required int productId,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<CartResponse>(
      type: state ?? CartCubitTypes.addToCart,
      callLoading: false,
      fun: () => _repo.addToCart(
        productId: productId,
        cancelToken: cancelToken,
      ),
      onSuccess: (response) => cartResponse = response,
      onFailure: (failure) => failure.printInfo('addToCart'),
    );
  }

  // --------------------------[ updateCart ]-------------------------- //
  BaseEitherResponse<CartResponse> updateCart({
    required int cartItemId,
    required int quantity,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<CartResponse>(
      type: state ?? CartCubitTypes.updateCart,
      callLoading: false,
      fun: () => _repo.updateCart(
        cartItemId: cartItemId,
        quantity: quantity,
        cancelToken: cancelToken,
      ),
      onSuccess: (response) => cartResponse = response,
      onFailure: (failure) => failure.printInfo('updateCart'),
    );
  }

  // --------------------------[ removeFromCart ]-------------------------- //
  BaseEitherResponse<CartResponse> removeFromCart({
    required int cartItemId,
    int? productId,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<CartResponse>(
      type: state ?? CartCubitTypes.removeFromCart,
      callLoading: false,
      fun: () => _repo.removeFromCart(
        cartItemId: cartItemId,
        productId: productId,
        cancelToken: cancelToken,
      ),
      onSuccess: (response) => cartResponse = response,
      onFailure: (failure) => failure.printInfo('removeFromCart'),
    );
  }

  // --------------------------[ getCheckout ]-------------------------- //
  BaseEitherResponse<CheckoutResponse> getCheckout({
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<CheckoutResponse>(
      type: state ?? CartCubitTypes.getCheckout,
      fun: () => _repo.getCheckout(cancelToken: cancelToken),
      onSuccess: (response) => checkoutResponse = response,
      onFailure: (failure) => failure.printInfo('getCheckout'),
    );
  }

  // --------------------------[ placeOrder ]-------------------------- //
  BaseEitherResponse<PlaceOrderResponse> placeOrder({
    required PlaceOrderRequest request,
    CancelToken? cancelToken,
    dynamic state,
  }) async {
    return await fastFire<PlaceOrderResponse>(
      type: state ?? CartCubitTypes.placeOrder,
      fun: () => _repo.placeOrder(
        request: request,
        cancelToken: cancelToken,
      ),
      onSuccess: (_) => clearCartData(),
      onFailure: (failure) => failure.printInfo('placeOrder'),
    );
  }
}
