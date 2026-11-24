class PlaceOrderResponse {
  int? orderId;
  String? message;
  List<dynamic>? error;
  int? status;

  PlaceOrderResponse({
    this.orderId,
    this.message,
    this.error,
    this.status,
  });

  PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] is Map) {
      final dataMap = Map<String, dynamic>.from(json['data'] as Map);
      orderId = dataMap['id'] is int
          ? dataMap['id'] as int
          : int.tryParse('${dataMap['id']}');
    }
    message = json['message']?.toString();
    error = json['error'] is List ? List<dynamic>.from(json['error']) : null;
    status = json['status'] is int
        ? json['status'] as int
        : int.tryParse('${json['status']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (orderId != null) {
      result['data'] = {'id': orderId};
    }
    result['message'] = message;
    result['error'] = error;
    result['status'] = status;
    return result;
  }
}
