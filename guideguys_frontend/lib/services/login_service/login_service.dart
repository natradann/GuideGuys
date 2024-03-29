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
      throw "รหัสผ่านไม่ถูกต้อง";
    } else if (response.statusCode == 404) {
      throw "ไม่พบผู้ใช้";
    } else if (response.statusCode == 500) {
      throw "Internal Server Error";
    } else {
      throw "Unknown Error";
    }
  }
}
