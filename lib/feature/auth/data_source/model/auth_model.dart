class AuthModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? token;

  AuthModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.token,
  });

  // fromJson
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}
