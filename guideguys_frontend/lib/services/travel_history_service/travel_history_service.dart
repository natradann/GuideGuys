import 'dart:convert';

import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/travel_history/travel_history_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/travel_history_service/travel_history_service_interface.dart';
import 'package:http/http.dart' as http;

class TravelHistoryService implements TravelHistoryServiceInterface {

  @override
  Future<TravelHistoryModel> fetchTravelHistory() async {
    String token = await SecureStorage().readSecureData('myToken');
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/history/get/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return travelHistoryModelFromJson(response.body);
      } else if (response.statusCode == 404) {
        return travelHistoryModelFromJson(response.body);
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
