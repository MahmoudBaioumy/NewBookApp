abstract class ApiConstants {
  // TODO: Put your actual URL here
  static const String baseUrl = "https://codingarabic.eraapro.com/api";

  static final _AuthApi auth = _AuthApi();
  static final _ProductsApi products = _ProductsApi();
  static final _ProfileApi profile = _ProfileApi();
  static final _CartApi cart = _CartApi();
}

class _CartApi {
  final String cart = "/cart";
  final String addToCart = "/add-to-cart";
  final String updateCart = "/update-cart";
  final String removeFromCart = "/remove-from-cart";
  final String checkout = "/checkout";
  final String placeOrder = "/place-order";
}

class _AuthApi {
  final String login = "/login";
  final String register = "/register";
  final String logout = "/logout";
}

class _ProfileApi {
  final String profile = "/profile";
  final String updateProfile = "/update-profile";
}

class _ProductsApi {
  final String sliders = "/sliders";
  final String newArrivals = "/products-new-arrivals";
  final String bestSeller = "/products-bestseller";
  final String categories = "/categories";
  final String wishlist = "/wishlist";
  final String addToWishlist = "/add-to-wishlist";

  String productDetails(int id) => "/products/$id";
}
