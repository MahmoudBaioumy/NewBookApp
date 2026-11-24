class PlaceOrderRequest {
  static const int defaultGovernorateId = 1;

  final String name;
  final int governorateId;
  final String phone;
  final String address;
  final String email;

  const PlaceOrderRequest({
    required this.name,
    this.governorateId = defaultGovernorateId,
    required this.phone,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'governorate_id': governorateId,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }
}
