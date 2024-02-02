import 'dart:convert';
import 'dart:typed_data';

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  String historyId;
  Uint8List base64Slip;

  PaymentModel({
    required this.historyId,
    required this.base64Slip,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        historyId: json['history_id'],
        base64Slip: json['slipImage'],
      );

  Map<String, dynamic> toJson() => {
        "history_id": historyId,
        "slipImage": base64Slip,
      };
}

ConfirmDetailModel confirmGuideDetailFromJson(String str) =>
    ConfirmDetailModel.fromJson(json.decode(str));

String confirmGuideDetailToJson(ConfirmDetailModel data) =>
    json.encode(data.toJson());

class ConfirmDetailModel {
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

  ConfirmDetailModel({
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

  factory ConfirmDetailModel.fromJson(Map<String, dynamic> json) {
    return ConfirmDetailModel(
      historyId: json["historyId"],
      guideCardNo: json["guideCardNo"],
      guideUsername: json["guideUsername"],
      guideName: json["guideName"],
      languages: (json['languages'] as List<dynamic>)
            .map<String>((language) => language.toString())
            .toList(),
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

