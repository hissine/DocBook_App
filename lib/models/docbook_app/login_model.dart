class LoginModel {
  int? status;
  String? message;
  String? userId;
  List<dynamic>? role;
  String? token;

  LoginModel({
    this.message,
    this.userId,
    this.role,
    this.token
  });
//named constructor
  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['userId'] = userId;
    data['role'] = role;
    data['token'] = token;
    return data;
  }
}