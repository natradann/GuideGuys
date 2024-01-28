import 'dart:convert';

class RegisterModel {
  late String username;
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  late String phoneNumber;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
      };
}

ResponseRegisterModel responseRegisterModelFromJson(String str) => ResponseRegisterModel.fromJson(json.decode(str));

String responseRegisterModelToJson(ResponseRegisterModel data) => json.encode(data.toJson());

class ResponseRegisterModel {
    String token;
    String userId;
    String username;
    String? myGuideId;

    ResponseRegisterModel({
        required this.token,
        required this.userId,
        required this.username,
        this.myGuideId,
    });

    factory ResponseRegisterModel.fromJson(Map<String, dynamic> json) => ResponseRegisterModel(
        token: json["token"],
        userId: json["user_id"],
        username: json["username"],
        myGuideId: json["myGuideId"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "username": username,
        "myGuideId": myGuideId,
    };
}