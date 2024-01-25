import 'dart:convert';

ReviewTourModel reviewTourModelFromJson(String str) => ReviewTourModel.fromJson(json.decode(str));

String reviewTourModelToJson(ReviewTourModel data) => json.encode(data.toJson());

class ReviewTourModel {
    String historyId;
    String userId;
    String tourId;
    int point;
    String comment;
    DateTime commentDate;

    ReviewTourModel({
        required this.historyId,
        required this.userId,
        required this.tourId,
        required this.point,
        required this.comment,
        required this.commentDate,
    });

    factory ReviewTourModel.fromJson(Map<String, dynamic> json) => ReviewTourModel(
        historyId: json["history_id"],
        userId: json["user_id"],
        tourId: json["tour_id"],
        point: json["point"],
        comment: json["comment"],
        commentDate: DateTime.parse(json["comment_date"]),
    );

    Map<String, dynamic> toJson() => {
        "history_id": historyId,
        "user_id": userId,
        "tour_id": tourId,
        "point": point,
        "comment": comment,
        "comment_date": commentDate.toIso8601String(),
    };
}
