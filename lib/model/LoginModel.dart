class LoginModel {
  bool status;
  String message;
  LoginData? data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  String name;
  String email;
  String phone;
  int points;
  int credit;
  String token;

  LoginData({
    required this.name,
    required this.email,
    required this.phone,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory LoginData.fromJson(Map json) {
    return LoginData(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
  }
}
