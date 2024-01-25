import 'package:guideguys/modules/create_tour/create_tour_model.dart';
import 'package:guideguys/services/create_tour_service/create_tour_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class CreateTourService implements CreateTourServiceInterface {
  String ip = localhostIp;
  String tokenText = token;

  @override
  Future<void> createTour({required CreateTourModel newTour}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$ngrokLink/tours/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenText'
        },
        body: createTourModelToJson(newTour),
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
