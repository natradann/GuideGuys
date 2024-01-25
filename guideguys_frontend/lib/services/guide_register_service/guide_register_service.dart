import 'dart:convert';
import 'dart:developer';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/guide_register/guide_register_model.dart';
import 'package:guideguys/services/guide_register_service/guide_register_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class GuideRegisterService implements GuideRegisterServiceInterface {
  String ip = localhostIp;

  @override
  Future<void> guideRegister({required GuideRegisterModel newGuide}) async {
    String token = await SecureStorage().readSecureData('token');
    http.Response response = await http.post(
        Uri.parse("$ngrokLink/guides/register"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(newGuide.toJson()));

    if (response.statusCode == 200) {
      log('Guide Register complete');
      return;
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
