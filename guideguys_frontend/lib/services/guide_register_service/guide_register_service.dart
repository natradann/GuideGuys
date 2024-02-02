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
  Future<String> guideRegister({required GuideRegisterModel newGuide}) async {
    String token = await SecureStorage().readSecureData('myToken');
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse("$ngrokLink/guides/register"),
    );

    request.headers['Authorization'] = 'bearer $token';
    request.fields['card_no'] = newGuide.guideCardNumber;
    request.fields['type'] = newGuide.guideCardType;
    request.fields['card_expired'] = newGuide.expiredDate.toIso8601String();
    request.fields['convinces'] = newGuide.convinces.join(',');
    request.fields['languages'] = newGuide.languages.join(',');
    request.fields['experience'] = newGuide.experience;
    request.fields['point'] = '0';

    request.files.add(http.MultipartFile.fromBytes(
      'img',
      newGuide.base64CardImage,
      filename: 'card_image.jpg',
    ));

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        log('Guide Register complete');
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else if (response.statusCode == 401) {
        throw Exception('User already exists');
      } else if (response.statusCode == 402) {
        throw Exception('Unable to Sign JWT');
      } else if (response.statusCode == 403) {
        throw Exception('hash error');
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }

  // @override
  // Future<String> guideRegister({required GuideRegisterModel newGuide}) async {
  //   String token = await SecureStorage().readSecureData('myToken');
  //   http.Response response = await http.post(
  //       Uri.parse("$ngrokLink/guides/register"),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token'
  //       },
  //       body: jsonEncode(newGuide.toJson()));

  //   if (response.statusCode == 200) {
  //     log('Guide Register complete');
  //     return jsonDecode(response.body);
  //   } else if (response.statusCode == 401) {
  //     throw Exception('User already exists');
  //   } else if (response.statusCode == 402) {
  //     throw Exception('Unable to Sign JWT');
  //   } else if (response.statusCode == 403) {
  //     throw Exception('hash error');
  //   } else {
  //     throw Exception("Unknown Error");
  //   }
  // }
}
