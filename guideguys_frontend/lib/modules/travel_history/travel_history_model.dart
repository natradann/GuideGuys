import 'dart:convert';

TravelHistoryModel travelHistoryModelFromJson(String str) =>
    TravelHistoryModel.fromJson(json.decode(str));

String travelHistoryModelToJson(TravelHistoryModel data) =>
    json.encode(data.toJson());

class TravelHistoryModel {
  String? customerImg;
  List<History> histories;

  TravelHistoryModel({
    this.customerImg,
    required this.histories,
  });

  factory TravelHistoryModel.fromJson(Map<String, dynamic> json) =>
      TravelHistoryModel(
        customerImg:
            (json["customer_img"] != null) ? json['customer_img'] : null,
        histories: List<History>.from(
            json["histories"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_img": customerImg,
        "histories": List<dynamic>.from(histories.map((x) => x.toJson())),
      };
}

class History {
  String historyId;
  String status;
  String tourId;
  String tourName;
  String guideId;
  String guideUsername;
  DateTime startDate;
  DateTime endDate;
  int price;

  History({
    required this.historyId,
    required this.status,
    required this.tourId,
    required this.tourName,
    required this.guideId,
    required this.guideUsername,
    required this.startDate,
    required this.endDate,
    required this.price,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        historyId: json["history_id"].toString(),
        status: json["status"],
        tourId: json["tour_id"].toString(),
        tourName: json["tour_name"],
        guideId: json["guide_id"],
        guideUsername: json["guide_username"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "history_id": historyId,
        "status": status,
        "tour_id": tourId,
        "tour_name": tourName,
        "guide_id": guideId,
        "guide_username": guideUsername,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "price": price,
      };
}
