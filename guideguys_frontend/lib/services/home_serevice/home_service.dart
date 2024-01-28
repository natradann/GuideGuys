import 'dart:convert';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/home/home_model.dart';
import 'package:guideguys/services/home_serevice/home_service_interface.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:http/http.dart' as http;
import '../../models/tour_card_lg_model.dart';

class HomeService implements HomeServiceInterface {
  String ip = localhostIp;
  @override
  Future<List<GuideModel>> fetchAllGuides() async {
    String token = await SecureStorage().readSecureData('myToken');
    http.Response response = await http.get(
      Uri.parse("$ngrokLink/guides/get/all"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<GuideModel>((guide) => GuideModel.fromJson(guide))
          .toList();
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error");
    } else {
      throw Exception("Unknown Error");
    }
  }

  @override
  Future<List<TourCardLGModel>> fetchAllTours() async {
    http.Response response = await http.get(
      Uri.parse("$ngrokLink/tours/get/all"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<TourCardLGModel>((tour) => TourCardLGModel.fromJson(tour))
          .toList();
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error");
    } else {
      throw Exception("Unknown Error");
    }
  }
}
