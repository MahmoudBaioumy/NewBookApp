import 'package:flustra_template/modules/products/models/product.dart';

class CartResponse {
  CartDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CartResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  CartResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] is Map
        ? CartDataResponse.fromJson(
            Map<String, dynamic>.from(json['data'] as Map),
          )
        : null;
    message = json['message']?.toString();
    error = json['error'] is List ? List<dynamic>.from(json['error']) : null;
    status = json['status'] is int
        ? json['status'] as int
        : int.tryParse('${json['status']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (data != null) {
      result['data'] = data!.toJson();
    }
    result['message'] = message;
    result['error'] = error;
    result['status'] = status;
    return result;
  }
}

class CartDataResponse {
  int? id;
  CartUserResponse? user;
  String? total;
  List<CartItemResponse>? cartItems;

  CartDataResponse({
    this.id,
    this.user,
    this.total,
    this.cartItems,
  });

  CartDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}');
    user = json['user'] is Map
        ? CartUserResponse.fromJson(
            Map<String, dynamic>.from(json['user'] as Map),
          )
        : null;
    total = json['total']?.toString();
    if (json['cart_items'] is List) {
      cartItems = (json['cart_items'] as List)
          .whereType<Map>()
          .map(
            (item) =>
                CartItemResponse.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['id'] = id;
    if (user != null) {
      result['user'] = user!.toJson();
    }
    result['total'] = total;
    if (cartItems != null) {
      result['cart_items'] = cartItems!.map((item) => item.toJson()).toList();
    }
    return result;
  }
}

class CartUserResponse {
  int? userId;
  String? userName;

  CartUserResponse({
    this.userId,
    this.userName,
  });

  CartUserResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] is int
        ? json['user_id'] as int
        : int.tryParse('${json['user_id']}');
    userName = json['user_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['user_id'] = userId;
    result['user_name'] = userName;
    return result;
  }
}

class CartItemResponse {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItemResponse({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  CartItemResponse.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'] is int
        ? json['item_id'] as int
        : int.tryParse('${json['item_id']}');
    itemProductId = json['item_product_id'] is int
        ? json['item_product_id'] as int
        : int.tryParse('${json['item_product_id']}');
    itemProductName = json['item_product_name']?.toString();
    itemProductImage = json['item_product_image']?.toString();
    itemProductPrice = json['item_product_price']?.toString();
    itemProductDiscount = json['item_product_discount'] is int
        ? json['item_product_discount'] as int
        : int.tryParse('${json['item_product_discount']}');
    itemProductPriceAfterDiscount =
        (json['item_product_price_after_discount'] as num?)?.toDouble() ??
            double.tryParse('${json['item_product_price_after_discount']}');
    itemProductStock = json['item_product_stock'] is int
        ? json['item_product_stock'] as int
        : int.tryParse('${json['item_product_stock']}');
    itemQuantity = json['item_quantity'] is int
        ? json['item_quantity'] as int
        : int.tryParse('${json['item_quantity']}');
    itemTotal = (json['item_total'] as num?)?.toDouble() ??
        double.tryParse('${json['item_total']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['item_id'] = itemId;
    result['item_product_id'] = itemProductId;
    result['item_product_name'] = itemProductName;
    result['item_product_image'] = itemProductImage;
    result['item_product_price'] = itemProductPrice;
    result['item_product_discount'] = itemProductDiscount;
    result['item_product_price_after_discount'] = itemProductPriceAfterDiscount;
    result['item_product_stock'] = itemProductStock;
    result['item_quantity'] = itemQuantity;
    result['item_total'] = itemTotal;
    return result;
  }

  double get originalUnitPrice => double.tryParse(itemProductPrice ?? '') ?? 0.0;

  double get discountedUnitPrice {
    if (itemProductPriceAfterDiscount != null) {
      return itemProductPriceAfterDiscount!;
    }
    final resolvedDiscount = itemProductDiscount ?? 0;
    final calculated =
        originalUnitPrice - (originalUnitPrice * resolvedDiscount / 100);
    return double.parse(calculated.toStringAsFixed(2));
  }

  Product toProduct() {
    return Product(
      id: itemProductId,
      name: itemProductName ?? '',
      originalPrice: originalUnitPrice,
      discountedPrice: discountedUnitPrice,
      discountPercentage: itemProductDiscount ?? 0,
      description: '',
      category: '',
      imageUrl: itemProductImage ?? '',
      stock: itemProductStock,
    );
  }
}
