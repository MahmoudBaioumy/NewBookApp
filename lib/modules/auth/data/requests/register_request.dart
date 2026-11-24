class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;
  final String city;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'phone': phone,
        'city': city,
      };
}
