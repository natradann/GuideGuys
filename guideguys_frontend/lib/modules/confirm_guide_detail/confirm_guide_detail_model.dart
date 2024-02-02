import 'dart:convert';

ConfirmGuideDetailModel confirmGuideDetailFromJson(String str) =>
    ConfirmGuideDetailModel.fromJson(json.decode(str));

String confirmGuideDetailToJson(ConfirmGuideDetailModel data) =>
    json.encode(data.toJson());

class ConfirmGuideDetailModel {
  int historyId;
  String guideCardNo;
  String guideUsername;
  String guideName;
  List<String> languages;
  String tourName;
  DateTime startDate;
  DateTime endDate;
  int price;
  int headcount;
  String plan;
  DateTime aptDate;
  String aptPlace;

  ConfirmGuideDetailModel({
    required this.historyId,
    required this.guideCardNo,
    required this.guideUsername,
    required this.guideName,
    required this.languages,
    required this.tourName,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.headcount,
    required this.plan,
    required this.aptDate,
    required this.aptPlace,
  });

  factory ConfirmGuideDetailModel.fromJson(Map<String, dynamic> json) {
    return ConfirmGuideDetailModel(
      historyId: json["historyId"],
      guideCardNo: json["guideCardNo"],
      guideUsername: json["guideUsername"],
      guideName: json["guideName"],
      languages: List<String>.from(json["languages"].split(',').map((x) => x)),
      tourName: json["tourName"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      price: json["price"],
      headcount: json["headcount"],
      plan: json["plan"],
      aptDate: DateTime.parse(json["apt_date"]),
      aptPlace: json["apt_place"],
    );
  }

  Map<String, dynamic> toJson() => {
        "historyId": historyId,
        "guideCardNo": guideCardNo,
        "guideUsername": guideUsername,
        "guideName": guideName,
        "languages": languages,
        "tourName": tourName,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "price": price,
        "headcount": headcount,
        "plan": plan,
        "apt_date": aptDate.toIso8601String(),
        "apt_place": aptPlace,
      };
}

