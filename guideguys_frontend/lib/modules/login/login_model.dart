import 'dart:convert';

class LoginModel {
  late String username;
  late String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

ResponseLoginModel responseLoginModelFromJson(String str) =>
    ResponseLoginModel.fromJson(json.decode(str));

String responseLoginModelToJson(int status ,ResponseLoginModel data) =>
    json.encode(data.toJson());

class ResponseLoginModel {
  String token;
  String userId;
  String username;

  ResponseLoginModel({
    required this.token,
    required this.userId,
    required this.username,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseLoginModel(
        token: json["token"],
        userId: json["user_id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "username": username,
      };
}
