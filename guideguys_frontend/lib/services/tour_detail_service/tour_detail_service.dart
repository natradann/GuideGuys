import 'dart:convert';
import 'package:guideguys/modules/tour_detail/tour_detail_model.dart';
import 'package:guideguys/services/tour_detail_service/tour_datail_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;

class ToureDetailService implements TourDetailServiceInterface {
  String ip = localhostIp;
  @override
  Future<TourDetailModel> fetchTourDetail({required String tourId}) async {
    http.Response response = await http.get(
      Uri.parse(
        "$ngrokLink/tours/get/datail/$tourId",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TourDetailModel.fromJson(jsonDecode(response.body)['tourDetail']);
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error");
    } else {
      throw Exception("Unknown Error");
    }
  }
}
