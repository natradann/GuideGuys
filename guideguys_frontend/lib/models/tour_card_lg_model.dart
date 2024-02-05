class TourCardLGModel {
  late String tourId;
  late String tourName;
  late String? tourImgPath;
  late List<String> convinces;
  late List<String> vehicles;
  late List<String> languages;
  late List<String> type;
  late int price;
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
        convinces: List<String>.from(json["tour_convinces"].split(',').map((x) => x)),
        vehicles: List<String>.from(json["tour_vehicles"].split(',').map((x) => x)),
        languages: List<String>.from(json["guide_languages"].split(',').map((x) => x)),
        type: List<String>.from(json["tour_type"].split(',').map((x) => x)),
        price: json['tour_price'],
        ratePoint: json['tour_point'].toDouble(),
      );
      return tour;
    } catch (error) {
      throw Exception(
          'Error on tour in tourName: ${json['tour_name']} and tourId: ${json['tour_id']} error on $error');
    }
  }
}
