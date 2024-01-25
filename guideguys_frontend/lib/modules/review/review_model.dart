import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  int id;
  String tourName;
  double tourPoint;
  List<RateModel> rate;

  ReviewModel({
    required this.id,
    required this.tourName,
    required this.tourPoint,
    required this.rate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    try {
      ReviewModel review = ReviewModel(
        id: json["id"],
        tourName: json["name"],
        tourPoint: json["point"].toDouble(),
        rate: List<RateModel>.from(json["rate"].map((x) => RateModel.fromJson(x))),
      );
      return review;
    } catch (error) {
      throw 
          'Error on tourId ${json["id"]}, tourName ${json["name"]}';
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
  int id;
  double point;
  String comment;
  DateTime commentDate;
  String customerId;
  String customerUsername;

  RateModel({
    required this.id,
    required this.point,
    required this.comment,
    required this.commentDate,
    required this.customerId,
    required this.customerUsername,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    try {
      RateModel rate = RateModel(
        id: json["id"],
        point: json["point"].toDouble(),
        comment: json["comment"],
        commentDate: DateTime.parse(json["comment_date"]),
        customerId: json["user_id"]["id"],
        customerUsername: json["user_id"]["username"],
      );
      return rate;
    } catch (error) {
      throw Exception('Error on rateId ${json["id"]}');
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
