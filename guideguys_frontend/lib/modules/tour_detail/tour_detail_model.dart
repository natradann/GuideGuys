import 'dart:convert';

class TourDetailModel {
  late String tourId;
  late String tourName;
  late String? tourImage;
  late String username;
  late String? guideImage;
  late String guideUserId;
  late String guideId;
  late List<String> languages;
  late List<String> convinces;
  late List<String> vehicle;
  late List<String> type;
  late String tourDetail;
  late int tourPrice;
  late double tourPoint;

  TourDetailModel({
    required this.tourId,
    required this.tourName,
    this.tourImage,
    required this.username,
    this.guideImage,
    required this.guideUserId,
    required this.guideId,
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
        tourImage: (json['tour_img'] == null) ? null : json['tour_img'],
        username: json['user_username'],
        guideImage: (json['guide_img'] != null) ? json['guide_img'] : null,
        guideUserId: json['user_id'],
        guideId: json['tour_guide_id'],
        languages: (jsonDecode(json['guide_languages']) as List<dynamic>)
            .map<String>((language) => language.toString())
            .toList(),
        convinces: (jsonDecode(json['tour_convinces']) as List<dynamic>)
            .map<String>((convince) => convince.toString())
            .toList(),
        vehicle: (jsonDecode(json['tour_vehicles']) as List<dynamic>)
            .map<String>((vehicle) => vehicle.toString())
            .toList(),
        type: (jsonDecode(json['tour_type']) as List<dynamic>)
            .map<String>((type) => type.toString())
            .toList(),
        tourDetail: json['tour_detail'],
        tourPrice: json['tour_price'],
        tourPoint: json['tour_point'].toDouble(),
      );
      return tourDetail;
    } catch (error) {
      throw Exception(
        'Error on tour in tourName: ${json['tour_name']} and tourId: ${json['tour_id']} error on $error',
      );
    }
  }
}
