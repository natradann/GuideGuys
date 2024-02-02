import 'dart:convert';

List<MyTourListModel> myTourListModelFromJson(String str) =>
    List<MyTourListModel>.from(
        json.decode(str).map((x) => MyTourListModel.fromJson(x)));

// String myTourListModelToJson(List<MyTourListModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyTourListModel {
  late String tourId;
  late String tourName;
  late String? tourImage;
  late List<String> convinces;
  late List<String> vehicles;
  late List<String> languages;
  late List<String> type;
  late int price;
  late double ratePoint;

  MyTourListModel({
    required this.tourId,
    required this.tourName,
    this.tourImage,
    required this.convinces,
    required this.vehicles,
    required this.languages,
    required this.type,
    required this.price,
    required this.ratePoint,
  });

  factory MyTourListModel.fromJson(Map<String, dynamic> json) {
    try {
      MyTourListModel tour = MyTourListModel(
        tourId: json['tour_id'].toString(),
        tourName: json['tour_name'],
        tourImage: (json['tour_img'] != null) ? json['tour_img'] : null,
        convinces: List<String>.from(json["tour_convinces"].split(',').map((x) => x)),
        vehicles: List<String>.from(json["tour_vehicle"].split(',').map((x) => x)),
        languages: List<String>.from(json["guide_languages"].split(',').map((x) => x)),
        type: List<String>.from(json["tour_type"].split(',').map((x) => x)),
        price: json['tour_price'],
        ratePoint: json['tour_point'].toDouble(),
      );
      return tour;
    } catch (error) {
      throw Exception(
          'Error on tour in tourName: ${json['tour_name']} and tourId: ${json['tour_id']} on error $error');
    }
  }
}
