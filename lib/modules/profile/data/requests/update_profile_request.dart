import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final String name;
  final String phone;
  final String city;
  final String address;
  final String? imagePath;

  const UpdateProfileRequest({
    required this.name,
    required this.phone,
    required this.city,
    required this.address,
    this.imagePath,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> fields = <String, dynamic>{
      'name': name,
      'phone': phone,
      'city': city,
      'address': address,
    };

    if (imagePath != null && imagePath!.trim().isNotEmpty) {
      fields['image'] = await MultipartFile.fromFile(imagePath!);
    }

    return FormData.fromMap(fields);
  }
}
