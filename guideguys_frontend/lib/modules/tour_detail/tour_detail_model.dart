import 'dart:convert';

class TourDetailModel {
  late String tourId;
  late String tourName;
  late String username;
  late String guideUserId;
  late String guideId;
  late String imgPath;
  late List<String> languages;
  late List<String> convinces;
  late List<String> vehicle;
  late List<String> type;
  late String tourDetail;
  late double tourPrice;
  late double tourPoint;

  TourDetailModel({
    required this.tourId,
    required this.tourName,
    required this.username,
    required this.guideUserId,
    required this.guideId,
    this.imgPath = "assets/images/blank-profile-picture.png",
    required this.languages,
    required this.convinces,
    required this.vehicle,
    required this.type,
    required this.tourDetail,
    required this.tourPrice,
    required this.tourPoint,
  });

  factory TourDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      TourDetailModel tourDetail = TourDetailModel(
        tourId: json['tour_id'].toString(),
        tourName: json['tour_name'],
        username: json['user_username'],
        guideUserId: json['user_id'],
        guideId: json['tour_guide_id'],
        languages: (jsonDecode(json['guide_languages']) as List<dynamic>)
            .map<String>((language) => language.toString())
            .toList(),
        convinces: (jsonDecode(json['tour_convinces']) as List<dynamic>)
            .map<String>((convince) => convince.toString())
            .toList(),
        vehicle: (jsonDecode(json['tour_vehicle']) as List<dynamic>)
            .map<String>((vehicle) => vehicle.toString())
            .toList(),
        type: (jsonDecode(json['tour_type']) as List<dynamic>)
            .map<String>((type) => type.toString())
            .toList(),
        tourDetail: json['tour_detail'],
        tourPrice: json['tour_price'].toDouble(),
        tourPoint: json['tour_point'].toDouble(),
      );
      return tourDetail;
    } catch (error) {
      throw Exception(
          'Error on tour in tourName: ${json['tour_name']} and tourId: ${json['tour_id']}');
    }
  }
}
