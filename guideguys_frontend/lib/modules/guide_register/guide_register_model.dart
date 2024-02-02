import 'dart:typed_data';

class GuideRegisterModel {
  late Uint8List base64CardImage;
  late String guideCardNumber;
  late String guideCardType;
  late DateTime expiredDate;
  late List<String> convinces;
  late List<String> languages;
  late String experience;

  GuideRegisterModel({
    required this.base64CardImage,
    required this.guideCardNumber,
    required this.guideCardType,
    required this.expiredDate,
    required this.convinces,
    required this.languages,
    required this.experience,
  });

  factory GuideRegisterModel.fromJson(Map<String, dynamic> json) =>
      GuideRegisterModel(
        base64CardImage: json['card_img'],
        guideCardNumber: json["card_no"],
        guideCardType: json["type"],
        expiredDate: DateTime.parse(json["card_expired"]),
        convinces: List<String>.from(json["convinces"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        experience: json["experience"],
      );

  Map<String, dynamic> toJson() => {
        "card_img": base64CardImage,
        "card_no": guideCardNumber,
        "type": guideCardType,
        "card_expired": expiredDate.toIso8601String(),
        "convinces": List<dynamic>.from(convinces.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "experience": experience,
        "point": 0.0,
      };
}
