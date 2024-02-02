import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  String id;
  String tourName;
  String tourImg;
  double tourPoint;
  List<RateModel> rate;

  ReviewModel({
    required this.id,
    required this.tourName,
    required this.tourImg,
    required this.tourPoint,
    required this.rate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    try {
      ReviewModel review = ReviewModel(
        id: json["id"].toString(),
        tourName: json["name"],
        tourImg: json["image"],
        tourPoint: json["point"].toDouble(),
        rate: List<RateModel>.from(
            json["rate"].map((x) => RateModel.fromJson(x))),
      );
      return review;
    } catch (error) {
      throw 'Error on tourId ${json["id"]}, tourName ${json["name"]} $error';
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": tourName,
        "point": tourPoint,
        "rate": List<dynamic>.from(rate.map((x) => x.toJson())),
      };
}

class RateModel {
  String id;
  double point;
  String comment;
  DateTime commentDate;
  String customerId;
  String customerUsername;
  String? customerImg;

  RateModel({
    required this.id,
    required this.point,
    required this.comment,
    required this.commentDate,
    required this.customerId,
    required this.customerUsername,
    this.customerImg,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    print(json["user_id"]["id"]);
    try {
      RateModel rate = RateModel(
        id: json["rate_id"].toString(),
        point: json["point"].toDouble(),
        comment: json["comment"],
        commentDate: DateTime.parse(json["comment_date"]),
        customerId: json["user_id"]["id"],
        customerUsername: json["user_id"]["username"],
        customerImg:
            (json["user_id"]["img"] != null) ? json["user_id"]["img"] : null,
      );
      return rate;
    } catch (error) {
      throw Exception('Error on rateId ${json["rate_id"]} $error');
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "point": point,
        "comment": comment,
        "comment_date": commentDate.toIso8601String(),
        "user_id": jsonEncode({
          "id": customerId,
          "username": customerUsername,
        }),
      };
}
