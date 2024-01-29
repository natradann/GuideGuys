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

String responseLoginModelToJson(ResponseLoginModel data) =>
    json.encode(data.toJson());

class ResponseLoginModel {
  String token;
  String userId;
  String username;
  String email;
  String? myGuideId;

  ResponseLoginModel({
    required this.token,
    required this.userId,
    required this.username,
    required this.email,
    this.myGuideId,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseLoginModel(
        token: json["token"],
        userId: json["user_id"],
        username: json["username"],
        email: json["user_email"],
        myGuideId: json["guide_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "username": username,
        "user_email": email,
        "guide_id": myGuideId,
      };
}
