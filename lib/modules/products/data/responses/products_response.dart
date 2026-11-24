import '../../models/product.dart';

class ProductsResponse {
  ProductsDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProductsResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProductsDataResponse.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'] != null ? List<dynamic>.from(json['error']) : null;
    status = json['status'] is int ? json['status'] : int.tryParse('${json['status']}');
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

class ProductsDataResponse {
  List<ProductItemResponse>? products;

  ProductsDataResponse({
    this.products,
  });

  ProductsDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] is List) {
      products = (json['products'] as List)
          .whereType<Map<String, dynamic>>()
          .map(ProductItemResponse.fromJson)
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (products != null) {
      result['products'] = products!.map((item) => item.toJson()).toList();
    }
    return result;
  }
}

class ProductItemResponse {
  int? id;
  String? name;
  String? description;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  int? stock;
  int? bestSeller;
  String? image;
  String? category;

  ProductItemResponse({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.stock,
    this.bestSeller,
    this.image,
    this.category,
  });

  ProductItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse('${json['id']}');
    name = json['name'];
    description = json['description'];
    price = json['price']?.toString();
    discount = json['discount'] is int ? json['discount'] : int.tryParse('${json['discount']}');
    priceAfterDiscount = (json['price_after_discount'] as num?)?.toDouble() ??
        double.tryParse('${json['price_after_discount']}');
    stock = json['stock'] is int ? json['stock'] : int.tryParse('${json['stock']}');
    bestSeller = json['best_seller'] is int
        ? json['best_seller']
        : int.tryParse('${json['best_seller']}');
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['id'] = id;
    result['name'] = name;
    result['description'] = description;
    result['price'] = price;
    result['discount'] = discount;
    result['price_after_discount'] = priceAfterDiscount;
    result['stock'] = stock;
    result['best_seller'] = bestSeller;
    result['image'] = image;
    result['category'] = category;
    return result;
  }

  Product toProduct() {
    final parsedOriginalPrice = double.tryParse(price ?? '') ?? 0.0;
    final resolvedDiscount = discount ?? 0;
    final calculatedDiscountedPrice =
        parsedOriginalPrice - (parsedOriginalPrice * resolvedDiscount / 100);
    final resolvedDiscountedPrice = priceAfterDiscount ??
        double.parse(calculatedDiscountedPrice.toStringAsFixed(2));

    return Product(
      id: id,
      name: name ?? '',
      originalPrice: parsedOriginalPrice,
      discountedPrice: resolvedDiscountedPrice,
      discountPercentage: resolvedDiscount,
      description: description ?? '',
      category: category ?? '',
      imageUrl: image ?? '',
      stock: stock,
      bestSeller: bestSeller,
    );
  }
}
