import 'dart:convert';

import 'package:guideguys/modules/review/review_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/review_service/review_service_interface.dart';
import 'package:http/http.dart' as http;

class ReviewService implements ReviewServiceInterface {
  String ip = localhostIp;

  @override
  Future<ReviewModel> fetchAllReviewByTourId({required String tourId}) async {
    http.Response response = await http.get(
      Uri.parse('$ngrokLink/rates/get/reviewBy/$tourId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ReviewModel.fromJson(
          jsonDecode(response.body));
    } else if (response.statusCode == 500) {
      throw Exception("Internal Server Error");
    } else {
      throw Exception("Unknown Error");
    }
  }
}
