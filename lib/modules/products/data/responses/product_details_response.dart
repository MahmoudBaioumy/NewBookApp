import 'products_response.dart';

class ProductDetailsResponse {
  ProductItemResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProductDetailsResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] is Map<String, dynamic>
        ? ProductItemResponse.fromJson(json['data'])
        : null;
    message = json['message'];
    error = json['error'] != null ? List<dynamic>.from(json['error']) : null;
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
