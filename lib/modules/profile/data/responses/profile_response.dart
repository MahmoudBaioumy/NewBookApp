import 'package:flustra_template/modules/auth/data/responses/login_response.dart';

class ProfileResponse {
  UserResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProfileResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] is Map<String, dynamic>
        ? UserResponse.fromJson(json['data'] as Map<String, dynamic>)
        : null;
    message = json['message']?.toString();
    error = json['error'] != null ? List<dynamic>.from(json['error']) : null;
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
