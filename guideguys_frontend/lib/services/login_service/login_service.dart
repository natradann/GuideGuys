import 'dart:convert';
import 'package:guideguys/modules/login/login_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/login_service/login_service_interface.dart';
import 'package:http/http.dart' as http;

class LoginService implements LoginServiceInterface {
  String ip = localhostIp;
  
  @override
  Future<ResponseLoginModel> vertifyAccount({required LoginModel userInfo}) async {
    http.Response response = await http.post(
      Uri.parse("$ngrokLink/users/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userInfo.toJson()),
    );

    if (response.statusCode == 200) {
      return responseLoginModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw Exception("Unable to Sign JWT or password not match");
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error");
    } else {
      throw Exception("Unknown Error");
    }
  }
}
