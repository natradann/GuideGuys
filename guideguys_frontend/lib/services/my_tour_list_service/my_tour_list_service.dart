import 'dart:convert';

import 'package:guideguys/modules/my_tour_list/my_tour_list_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/my_tour_list_service/my_tour_list_service_interface.dart';
import 'package:http/http.dart' as http;

class MyTourListService implements MyTourListServiceInterface {
  String ip = localhostIp;
  String tokenText = token;

  @override
  Future<List<MyTourListModel>> fetchMyTourList() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$ngrokLink/tours/get/tour/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenText'
        },
      );

      if (response.statusCode == 200) {
        return myTourListModelFromJson(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('guide has no tour');
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
