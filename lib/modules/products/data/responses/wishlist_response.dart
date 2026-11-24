import 'products_response.dart';

class WishlistResponse {
  WishlistPaginationDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  WishlistResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  WishlistResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] is Map
        ? WishlistPaginationDataResponse.fromJson(
            Map<String, dynamic>.from(json['data'] as Map),
          )
        : null;
    message = json['message']?.toString();
    error = json['error'] is List ? List<dynamic>.from(json['error']) : null;
    status = json['status'] is int
        ? json['status']
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

class WishlistPaginationDataResponse {
  int? currentPage;
  List<ProductItemResponse>? items;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<WishlistPageLinkResponse>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  WishlistPaginationDataResponse({
    this.currentPage,
    this.items,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  WishlistPaginationDataResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] is int
        ? json['current_page']
        : int.tryParse('${json['current_page']}');
    if (json['data'] is List) {
      items = (json['data'] as List)
          .whereType<Map>()
          .map(
            (item) =>
                ProductItemResponse.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    }
    firstPageUrl = json['first_page_url']?.toString();
    from = json['from'] is int ? json['from'] : int.tryParse('${json['from']}');
    lastPage = json['last_page'] is int
        ? json['last_page']
        : int.tryParse('${json['last_page']}');
    lastPageUrl = json['last_page_url']?.toString();
    if (json['links'] is List) {
      links = (json['links'] as List)
          .whereType<Map>()
          .map(
            (item) => WishlistPageLinkResponse.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    }
    nextPageUrl = json['next_page_url']?.toString();
    path = json['path']?.toString();
    perPage = json['per_page'] is int
        ? json['per_page']
        : int.tryParse('${json['per_page']}');
    prevPageUrl = json['prev_page_url']?.toString();
    to = json['to'] is int ? json['to'] : int.tryParse('${json['to']}');
    total = json['total'] is int
        ? json['total']
        : int.tryParse('${json['total']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['current_page'] = currentPage;
    if (items != null) {
      result['data'] = items!.map((item) => item.toJson()).toList();
    }
    result['first_page_url'] = firstPageUrl;
    result['from'] = from;
    result['last_page'] = lastPage;
    result['last_page_url'] = lastPageUrl;
    if (links != null) {
      result['links'] = links!.map((item) => item.toJson()).toList();
    }
    result['next_page_url'] = nextPageUrl;
    result['path'] = path;
    result['per_page'] = perPage;
    result['prev_page_url'] = prevPageUrl;
    result['to'] = to;
    result['total'] = total;
    return result;
  }
}

class WishlistPageLinkResponse {
  String? url;
  String? label;
  bool? active;

  WishlistPageLinkResponse({
    this.url,
    this.label,
    this.active,
  });

  WishlistPageLinkResponse.fromJson(Map<String, dynamic> json) {
    url = json['url']?.toString();
    label = json['label']?.toString();
    active = json['active'] is bool ? json['active'] : json['active'] == true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['url'] = url;
    result['label'] = label;
    result['active'] = active;
    return result;
  }
}
