import 'package:guideguys/modules/confirm_guide_detail/confirm_guide_detail_model.dart';
import 'package:guideguys/services/confirm_guide_detail_service/confirm_guide_detail_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class ConfirmGuideDatailService implements ConfirmGuideDetailServiceInterface {
  String ip = localhostIp;

  @override
  Future<ConfirmGuideDetailModel> fetchConfirmGuideFormModel(
      {required String historyId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/history/get/confirmForm/$historyId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return confirmGuideDetailFromJson(response.body);
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
