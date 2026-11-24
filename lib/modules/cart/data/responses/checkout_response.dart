class CheckoutResponse {
  CheckoutDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CheckoutResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  CheckoutResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] is Map
        ? CheckoutDataResponse.fromJson(
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

class CheckoutDataResponse {
  int? id;
  CheckoutUserResponse? user;
  String? total;
  List<CheckoutCartItemResponse>? cartItems;

  CheckoutDataResponse({
    this.id,
    this.user,
    this.total,
    this.cartItems,
  });

  CheckoutDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}');
    user = json['user'] is Map
        ? CheckoutUserResponse.fromJson(
            Map<String, dynamic>.from(json['user'] as Map),
          )
        : null;
    total = json['total']?.toString();
    if (json['cart_items'] is List) {
      cartItems = (json['cart_items'] as List)
          .whereType<Map>()
          .map(
            (item) => CheckoutCartItemResponse.fromJson(
              Map<String, dynamic>.from(item),
            ),
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

  double get parsedTotal => double.tryParse(total ?? '') ?? 0.0;
}

class CheckoutUserResponse {
  int? userId;
  String? userName;
  String? userEmail;
  String? address;
  String? phone;

  CheckoutUserResponse({
    this.userId,
    this.userName,
    this.userEmail,
    this.address,
    this.phone,
  });

  CheckoutUserResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] is int
        ? json['user_id'] as int
        : int.tryParse('${json['user_id']}');
    userName = json['user_name']?.toString();
    userEmail = json['user_email']?.toString();
    address = json['address']?.toString();
    phone = json['phone']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['user_id'] = userId;
    result['user_name'] = userName;
    result['user_email'] = userEmail;
    result['address'] = address;
    result['phone'] = phone;
    return result;
  }
}

class CheckoutCartItemResponse {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductPrice;
  int? itemQuantity;
  String? itemTotal;

  CheckoutCartItemResponse({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductPrice,
    this.itemQuantity,
    this.itemTotal,
  });

  CheckoutCartItemResponse.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'] is int
        ? json['item_id'] as int
        : int.tryParse('${json['item_id']}');
    itemProductId = json['item_product_id'] is int
        ? json['item_product_id'] as int
        : int.tryParse('${json['item_product_id']}');
    itemProductName = json['item_product_name']?.toString();
    itemProductPrice = json['item_product_price']?.toString();
    itemQuantity = json['item_quantity'] is int
        ? json['item_quantity'] as int
        : int.tryParse('${json['item_quantity']}');
    itemTotal = json['item_total']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['item_id'] = itemId;
    result['item_product_id'] = itemProductId;
    result['item_product_name'] = itemProductName;
    result['item_product_price'] = itemProductPrice;
    result['item_quantity'] = itemQuantity;
    result['item_total'] = itemTotal;
    return result;
  }

  double get parsedUnitPrice => double.tryParse(itemProductPrice ?? '') ?? 0.0;

  double get parsedItemTotal => double.tryParse(itemTotal ?? '') ?? 0.0;
}
