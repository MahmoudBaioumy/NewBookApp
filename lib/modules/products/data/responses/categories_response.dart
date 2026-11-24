import '../../models/product.dart';
import '../products_fake_data.dart';

class CategoriesResponse {
  CategoriesDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CategoriesResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CategoriesDataResponse.fromJson(json['data']) : null;
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

class CategoriesDataResponse {
  List<CategoryItemResponse>? categories;
  CategoriesMetaResponse? meta;
  CategoriesLinksResponse? links;

  CategoriesDataResponse({
    this.categories,
    this.meta,
    this.links,
  });

  CategoriesDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] is List) {
      categories = (json['categories'] as List)
          .whereType<Map<String, dynamic>>()
          .map(CategoryItemResponse.fromJson)
          .toList();
    }
    meta = json['meta'] != null ? CategoriesMetaResponse.fromJson(json['meta']) : null;
    links = json['links'] != null ? CategoriesLinksResponse.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (categories != null) {
      result['categories'] = categories!.map((item) => item.toJson()).toList();
    }
    if (meta != null) {
      result['meta'] = meta!.toJson();
    }
    if (links != null) {
      result['links'] = links!.toJson();
    }
    return result;
  }
}

class CategoryItemResponse {
  int? id;
  String? name;
  int? productsCount;
  String? image;

  CategoryItemResponse({
    this.id,
    this.name,
    this.productsCount,
    this.image,
  });

  CategoryItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse('${json['id']}');
    name = json['name'];
    productsCount = json['products_count'] is int
        ? json['products_count']
        : int.tryParse('${json['products_count']}');
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['id'] = id;
    result['name'] = name;
    result['products_count'] = productsCount;
    if (image != null) {
      result['image'] = image;
    }
    return result;
  }

  BookCategoryModel toBookCategoryModel() {
    final defaultCoverUrl = FakeProductsData.bookCategories.first.imageUrl;
    final resolvedImage = (image != null && image!.trim().isNotEmpty)
        ? image!
        : defaultCoverUrl;

    return BookCategoryModel(
      id: '${id ?? ''}',
      name: name ?? '',
      imageUrl: resolvedImage,
      productsCount: productsCount,
    );
  }
}

class CategoriesMetaResponse {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  CategoriesMetaResponse({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  CategoriesMetaResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'] is int ? json['total'] : int.tryParse('${json['total']}');
    perPage = json['per_page'] is int ? json['per_page'] : int.tryParse('${json['per_page']}');
    currentPage = json['current_page'] is int
        ? json['current_page']
        : int.tryParse('${json['current_page']}');
    lastPage = json['last_page'] is int ? json['last_page'] : int.tryParse('${json['last_page']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['total'] = total;
    result['per_page'] = perPage;
    result['current_page'] = currentPage;
    result['last_page'] = lastPage;
    return result;
  }
}

class CategoriesLinksResponse {
  String? first;
  String? last;
  String? prev;
  String? next;

  CategoriesLinksResponse({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  CategoriesLinksResponse.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['first'] = first;
    result['last'] = last;
    result['prev'] = prev;
    result['next'] = next;
    return result;
  }
}
