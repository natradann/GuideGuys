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
