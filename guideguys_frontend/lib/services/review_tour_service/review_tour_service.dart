import 'package:guideguys/modules/review_tour/review_tour_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/review_tour_service/review_tour_service_interface.dart';
import 'package:http/http.dart' as http;

class ReviewTourService implements ReviewTourServiceInterface {
  String ip = localhostIp;

  @override
  Future<bool> rateTourHistory({required ReviewTourModel reviewTour}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$ngrokLink/rates/add/review'),
          headers: {'Content-Type': 'application/json'},
          body: reviewTourModelToJson(reviewTour));

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception("Tour rate information is not array");
      } else if (response.statusCode == 401) {
        throw Exception("Guide rate information is not array");
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
