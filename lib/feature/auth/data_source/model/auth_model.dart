class AuthModel {
  String? name;
  String? email;
  String? password;
  String? phone;

  AuthModel({
    this.name,
    this.email,
    this.password,
    this.phone,
  });

  // fromJson
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
