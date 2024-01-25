import 'dart:convert';

class TravelHistoryModel {
  String historyId;
  String status;
  String tourId;
  String tourName;
  String guideId;
  String guideName;
  DateTime startDate;
  DateTime endDate;
  int price;

  TravelHistoryModel({
    required this.historyId,
    required this.status,
    required this.tourId,
    required this.tourName,
    required this.guideId,
    required this.guideName,
    required this.startDate,
    required this.endDate,
    required this.price,
  });

  factory TravelHistoryModel.fromJson(Map<String, dynamic> json) {
    return TravelHistoryModel(
      historyId: json["id"].toString(),
      status: json["status"],
      tourId: json["tour"]["id"].toString(),
      tourName: json["tour_name"],
      guideId: json["guide"]['id'],
      guideName: json["guide"]['user']['username'],
      startDate: DateTime.parse(json["start_date"]),
      endDate: DateTime.parse(json["end_date"]),
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "historyId": historyId,
        "status": status,
        "tourId": tourId,
        "tourName": tourName,
        "guideId": guideId,
        "guideName": guideName,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "price": price,
      };
}
