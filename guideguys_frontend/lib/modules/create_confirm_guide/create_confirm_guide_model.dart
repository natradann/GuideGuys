import 'dart:convert';

GuideInfoModel guideInfoModelFromJson(String str) => GuideInfoModel.fromJson(json.decode(str));

String guideInfoModelToJson(GuideInfoModel data) => json.encode(data.toJson());
String createConfirmGuideModelToJson(CreateConfirmGuideModel data) => json.encode(data.toJson());

class CreateConfirmGuideModel {
  late String? tourId;
  late String tourName;
  late String customerId;
  late String guideId;
  late DateTime startDate;
  late DateTime endDate;
  late String price;
  late String headCount;
  late String plan;
  late DateTime aptDate;
  late String aptPlace;
  late String status;

  CreateConfirmGuideModel({
    this.tourId,
    required this.tourName,
    required this.customerId,
    required this.guideId,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.headCount,
    required this.plan,
    required this.aptDate,
    required this.aptPlace,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'tour': tourId,
    'tour_name': tourName,
    'customer': customerId,
    'guide': guideId,
    'start_date': startDate.toString(),
    'end_date': endDate.toString(),
    'price': int.parse(price),
    'headcount': int.parse(headCount),
    'plan': plan,
    'appointment_date': aptDate.toString(),
    'appointment_place': aptPlace,
    'status': status,
  };
}

class GuideInfoModel {
    String guideId;
    String guideName;
    String cardNo;
    List<String> languages;
    List<TourModel> tour;

    GuideInfoModel({
        required this.guideId,
        required this.guideName,
        required this.cardNo,
        required this.languages,
        required this.tour,
    });

    factory GuideInfoModel.fromJson(Map<String, dynamic> json) => GuideInfoModel(
        guideId: json["guideId"],
        guideName: json["guideName"],
        cardNo: json["CardNo"],
        languages: List<String>.from(json["languages"].split(',').map((x) => x)),
        tour: List<TourModel>.from(json["tour"].map((x) => TourModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "guideId": guideId,
        "guideName": guideName,
        "CardNo": cardNo,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "tour": List<dynamic>.from(tour.map((x) => x.toJson())),
    };
}

class TourModel {
    String tourId;
    String tourName;

    TourModel({
        required this.tourId,
        required this.tourName,
    });

    factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
        tourId: json["id"].toString(),
        tourName: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": tourId,
        "name": tourName,
    };
}
