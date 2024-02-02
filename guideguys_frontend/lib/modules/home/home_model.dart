import 'dart:convert';

class GuideModel {
  late String guideId;
  late String guideName;
  late String? guideImg;
  late List<String> convinces;
  late List<String> languages;
  late List<String> tourNames;
  late List<String> tourTypes;
  late List<String> allVehicles;
  late double ratePoint;

  GuideModel({
    required this.guideId,
    required this.guideName,
    this.guideImg,
    required this.convinces,
    required this.languages,
    required this.tourNames,
    required this.tourTypes,
    required this.allVehicles,
    required this.ratePoint,
  });

  factory GuideModel.fromJson(Map<String, dynamic> json) {
    try {
      GuideModel guide = GuideModel(
        guideId: json['guide_id'],
        guideName: json['username'],
        guideImg: json['guide_img'],
        convinces:
            List<String>.from(json["guide_convinces"].split(',').map((x) => x)),
        languages:
            List<String>.from(json["guide_languages"].split(',').map((x) => x)),
        tourNames: List<String>.from(json["guide_tour_name"].map((x) => x)),
        tourTypes: List<String>.from(json["guide_tour_type"].map((x) => x)),
        allVehicles: List<String>.from(json["guide_vehicle"].map((x) => x)),
        ratePoint: json['guide_point'].toDouble(),
      );
      return guide;
    } catch (error) {
      throw 'Error on guide in username: ${json['username']} and guideId: ${json['guide_id']} error on $error';
    }
  }
}

class TourModel {
  late String tourId;
  late String tourName;
  late String? tourImgPath;
  late List<String> convinces;
  late List<String> vehicles;
  late List<String> languages;
  late List<String> type;
  late double price;
  late double ratePoint;

  TourModel({
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

  factory TourModel.fromJson(Map<String, dynamic> json) {
    try {
      TourModel tour = TourModel(
        tourId: json['tour_id'].toString(),
        tourName: json['tour_name'],
        tourImgPath: json['tour_img'],
        convinces: (jsonDecode(json['tour_convinces']) as List<dynamic>)
            .map<String>((convince) => convince.toString())
            .toList(),
        vehicles: (jsonDecode(json['tour_vehicle']) as List<dynamic>)
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
      throw Exception(
          'Error on tour in tourName: ${json['tour_name']} and tourId: ${json['tour_id']}');
    }
  }
}
