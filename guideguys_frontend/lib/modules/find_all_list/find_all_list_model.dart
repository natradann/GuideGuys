import 'dart:convert';

class TourModel {
  late String tourId;
  late String tourName;
  late String tourImgPath;
  late List<String> convinces;
  late List<String> vehicles;
  late List<String> languages;
  late List<String> type;
  late double price;
  late double ratePoint;

  TourModel({
    required this.tourId,
    required this.tourName,
    this.tourImgPath = "assets/images/blank-profile-picture.png",
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

class GuideModel {
  late String guidId;
  late String guideName;
  late String guideImgPath;
  late List<String> convinces;
  late List<String> languages;
  late double ratePoint;

  GuideModel({
    required this.guidId,
    required this.guideName,
    this.guideImgPath = "assets/images/blank-profile-picture.png",
    required this.convinces,
    required this.languages,
    required this.ratePoint,
  });

  // factory GuideModel.fromJson(Map<String, dynamic> json) {
  //   try {
  //     GuideModel guide = GuideModel(guidId: guidId, guideName: guideName, convinces: convinces, languages: languages, ratePoint: ratePoint)
  //   } catch (error) {
      
  //   }
  // }
}
