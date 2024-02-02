import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/create_tour/create_tour_model.dart';
import 'package:guideguys/services/create_tour_service/create_tour_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class CreateTourService implements CreateTourServiceInterface {
  String ip = localhostIp;

  @override
  Future<void> createTour({required CreateTourModel newTour}) async {
    String token = await SecureStorage().readSecureData('myToken');
    try {
      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse('$ngrokLink/tours/create'),
      );

      request.headers['Authorization'] = 'bearer $token';
      request.fields['tourName'] = newTour.tourName;
      request.fields['convinces'] = newTour.convinces.join(',');
      request.fields['vehicle'] = newTour.vehicle.join(',');
      request.fields['tourType'] = newTour.tourType.join(',');
      request.fields['detail'] = newTour.detail;
      request.fields['price'] = newTour.price.toString();

      request.files.add(http.MultipartFile.fromBytes(
        'img',
        newTour.base64Image,
        filename: 'tour_image.jpg',
      ));

      http.StreamedResponse response = await request.send();

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
