import 'dart:convert';
import 'package:guideguys/modules/guide_profile/guide_profile_model.dart';
import 'package:guideguys/services/guide_profile_service/guide_profile_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class GuideProfileService implements GuideProfileServiceInterface {
  String ip = localhostIp;
  @override
  Future<GuideProfileModel> fetchGuideProfile({required String guideId}) async {
    http.Response response = await http.get(
        Uri.parse('$ngrokLink/guides/get/profile/$guideId'),
        headers: {
          'Content-Type': 'application/json',
        });
    // print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return GuideProfileModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error");
    } else {
      throw Exception("Unknown Error");
    }
  }
}
