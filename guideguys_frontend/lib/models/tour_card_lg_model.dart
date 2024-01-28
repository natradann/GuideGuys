import 'dart:convert';

class TourCardLGModel {
  late String tourId;
  late String tourName;
  late String? tourImgPath;
  late List<String> convinces;
  late List<String> vehicles;
  late List<String> languages;
  late List<String> type;
  late double price;
  late double ratePoint;

  TourCardLGModel({
    required this.tourId,
    required this.tourName,
    this.tourImgPath,
    required this.convinces,
    required this.vehicles,
    required this.languages,
    required this.type,
    required this.price,
    required this.ratePoint,
  });

  factory TourCardLGModel.fromJson(Map<String, dynamic> json) {
    try {
      TourCardLGModel tour = TourCardLGModel(
        tourId: json['tour_id'].toString(),
        tourName: json['tour_name'],
        tourImgPath: (json['tour_img'] == null) ? null : json['tour_img'],
        convinces: (jsonDecode(json['tour_convinces']) as List<dynamic>)
            .map<String>((convince) => convince.toString())
            .toList(),
        vehicles: (jsonDecode(json['tour_vehicles']) as List<dynamic>)
            .map<String>((vehicle) => vehicle.toString())
            .toList(),
        languages: (jsonDecode(json['guide_languages']) as List<dynamic>)
            .map<String>((language) => language.toString())
            .toList(),
        type: (jsonDecode(json['tour_type']) as List<dynamic>)
            .map<String>((type) => type)
            .toList(),
        price: json['tour_price'].toDouble(),
        ratePoint: json['tour_point'].toDouble(),
      );
      return tour;
    } catch (error) {
      print(error);
      throw Exception(
          'Error on tour in tourName: ${json['tour_name']} and tourId: ${json['tour_id']}');
    }
  }
}
