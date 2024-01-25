import 'dart:convert';

CreateTourModel createTourModelFromJson(String str) =>
    CreateTourModel.fromJson(json.decode(str));

String createTourModelToJson(CreateTourModel data) =>
    json.encode(data.toJson());

class CreateTourModel {
  String tourName;
  List<String> convinces;
  List<String> vehicle;
  List<String> tourType;
  String detail;
  int price;

  CreateTourModel({
    required this.tourName,
    required this.convinces,
    required this.vehicle,
    required this.tourType,
    required this.detail,
    required this.price,
  });

  factory CreateTourModel.fromJson(Map<String, dynamic> json) =>
      CreateTourModel(
        tourName: json["tourName"],
        convinces: List<String>.from(json["convinces"].map((x) => x)),
        vehicle: json["vehicle"],
        tourType: json["tourType"],
        detail: json["detail"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "tourName": tourName,
        "convinces": List<dynamic>.from(convinces.map((x) => x)),
        "vehicle": vehicle,
        "tourType": tourType,
        "detail": detail,
        "price": price,
      };
}

