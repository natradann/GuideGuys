import 'dart:convert';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/create_confirm_guide/create_confirm_guide_model.dart';
import 'package:guideguys/services/create_confirm_guide_service/create_confirm_guide_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class CreateConfirmGuideService implements CreateConFirmGuideServiceInterface {
  String ip = localhostIp;

  @override
  Future<GuideInfoModel> fetchGuideInfoForConfirmForm() async {
    String token = await SecureStorage().readSecureData('myToken');
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/guides/get/guideInfo/forConfirmForm'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return guideInfoModelFromJson(response.body);
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> createForm(
      {required CreateConfirmGuideModel confirmForm}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$ngrokLink/history/create/form'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(confirmForm.toJson()),
      );
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }
}
