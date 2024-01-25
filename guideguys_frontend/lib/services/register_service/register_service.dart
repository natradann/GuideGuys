import 'dart:convert';

import 'package:guideguys/modules/register/register_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/register_service/register_service_interface.dart';
import 'package:http/http.dart' as http;

class RegisterService implements RegisterServiceInterface {
  @override
  Future<String> createAccount({required RegisterModel regisInfo}) async {
    String ip = localhostIp;
    http.Response response = await http.post(
      Uri.parse("$ngrokLink/users/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(regisInfo.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["token"];
    } else if (response.statusCode == 401) {
      throw Exception('User already exists');
    } else if (response.statusCode == 402) {
      throw Exception('Unable to Sign JWT');
    } else if (response.statusCode == 403) {
      throw Exception('hash error');
    } else {
      throw Exception("Unknown Error");
    }
  }
}
