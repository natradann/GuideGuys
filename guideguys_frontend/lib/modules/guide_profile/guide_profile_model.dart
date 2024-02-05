class GuideProfileModel {
  late String guideUserId;
  late String guideId;
  late String guideName;
  late String firstName;
  late String lastName;
  late String? guideImage;
  late String guideCardNo;
  // late String guideCardType;
  late DateTime cardExpired;
  late double guidePoint;
  late List<String> convinces;
  late List<String> languages;
  late String experience;
  late List<TourModel> alltours;

  GuideProfileModel({
    required this.guideUserId,
    required this.guideId,
    required this.guideName,
    required this.firstName,
    required this.lastName,
    this.guideImage,
    required this.guideCardNo,
    // required this.guideCardType,
    required this.cardExpired,
    required this.guidePoint,
    required this.convinces,
    required this.languages,
    required this.experience,
    required this.alltours,
  });

  factory GuideProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      print(json["convinces"].runtimeType);
      GuideProfileModel guide = GuideProfileModel(
        guideUserId: json['userId'],
        guideId: json['guideId'],
        guideName: json['username'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        guideImage: (json['guide_img'] != null) ? json['guide_img'] : null,
        guideCardNo: json['guideCardNo'],
        // guideCardType: json['guideType'],
        cardExpired: DateTime.parse(json['guideCardExpired']),
        guidePoint: json['guidePoint'].toDouble(),
        convinces:
            List<String>.from(json["convinces"].split(',').map((x) => x)),
        languages:
            List<String>.from(json["languages"].split(',').map((x) => x)),
        experience: json['experience'],
        alltours: (json['tours'] as List<dynamic>)
            .map<TourModel>((tour) => TourModel.fromJson(tour))
            .toList(),
      );
      return guide;
    } catch (error) {
      throw Exception(
          'Error on guideId: ${json['guideId']} and name: ${json['username']} $error');
    }
  }
}

class TourModel {
  late String tourId;
  late String tourName;
  late String? tourImgPath;
  late List<String> convinces;
  late List<String> tourType;
  late int tourPrice;
  late double tourRatePoint;

  TourModel({
    required this.tourId,
    required this.tourName,
    this.tourImgPath,
    required this.convinces,
    required this.tourType,
    required this.tourPrice,
    required this.tourRatePoint,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    try {
      TourModel tour = TourModel(
        tourId: json['id'].toString(),
        tourName: json['name'],
        tourImgPath: json['img'],
        convinces:
            List<String>.from(json["convinces"].split(',').map((x) => x)),
        tourType: List<String>.from(json["type"].split(',').map((x) => x)),
        tourPrice: json['price'],
        tourRatePoint: json['point'].toDouble(),
      );
      return tour;
    } catch (error) {
      throw Exception(
          'Error on tourId: ${json['id']} and name: ${json['name']} $error');
    }
  }
}
