class SlidersResponse {
  SlidersDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  SlidersResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  SlidersResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SlidersDataResponse.fromJson(json['data']) : null;
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

class SlidersDataResponse {
  List<SliderItemResponse>? sliders;

  SlidersDataResponse({
    this.sliders,
  });

  SlidersDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] is List) {
      sliders = (json['sliders'] as List)
          .whereType<Map<String, dynamic>>()
          .map(SliderItemResponse.fromJson)
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (sliders != null) {
      result['sliders'] = sliders!.map((item) => item.toJson()).toList();
    }
    return result;
  }
}

class SliderItemResponse {
  String? image;

  SliderItemResponse({
    this.image,
  });

  SliderItemResponse.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['image'] = image;
    return result;
  }
}
