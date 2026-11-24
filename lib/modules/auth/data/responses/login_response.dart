class AuthResponse {
  AuthDataResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  AuthResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  AuthResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AuthDataResponse.fromJson(json['data']) : null;
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

class AuthDataResponse {
  UserResponse? user;
  String? token;

  AuthDataResponse({
    this.user,
    this.token,
  });

  AuthDataResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserResponse.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (user != null) {
      result['user'] = user!.toJson();
    }
    result['token'] = token;
    return result;
  }
}

class UserResponse {
  int? id;
  String? name;
  String? email;
  String? address;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  UserResponse({
    this.id,
    this.name,
    this.email,
    this.address,
    this.city,
    this.phone,
    this.emailVerified,
    this.image,
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['id'] = id;
    result['name'] = name;
    result['email'] = email;
    result['address'] = address;
    result['city'] = city;
    result['phone'] = phone;
    result['email_verified'] = emailVerified;
    result['image'] = image;
    return result;
  }
}

typedef LoginResponse = AuthResponse;
typedef UserDataResponse = AuthDataResponse;
