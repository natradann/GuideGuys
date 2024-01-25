class GuideProfileModel {
  late String guideUserId;
  late String guideId;
  late String guideName;
  late String firstName;
  late String lastName;
  late String guideImgPath;
  late String guideCardNo;
  late String guideCardType;
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
    this.guideImgPath = "assets/images/blank-profile-picture.png",
    required this.guideCardNo,
    required this.guideCardType,
    required this.cardExpired,
    required this.guidePoint,
    required this.convinces,
    required this.languages,
    required this.experience,
    required this.alltours,
  });

  factory GuideProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      GuideProfileModel guide = GuideProfileModel(
        guideUserId: json['userId'],
        guideId: json['guideId'],
        guideName: json['username'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        guideCardNo: json['guideCardNo'],
        guideCardType: json['guideType'],
        cardExpired: DateTime.parse(json['guideCardExpired']),
        guidePoint: json['guidePoint'].toDouble(),
        convinces: (json['convinces'] as List<dynamic>)
            .map<String>((convince) => convince.toString())
            .toList(),
        languages: (json['languages'] as List<dynamic>)
            .map<String>((language) => language.toString())
            .toList(),
        experience: json['experience'],
        alltours: (json['tours'] as List<dynamic>)
            .map<TourModel>((tour) => TourModel.fromJson(tour))
            .toList(),
      );
      return guide;
    } catch (error) {
      throw Exception(
          'Error on guideId: ${json['guideId']} and name: ${json['username']}');
    }
  }
}

class TourModel {
  late String tourId;
  late String tourName;
  late String tourImgPath;
  late List<String> convinces;
  late List<String> tourType;
  late double tourPrice;
  late double tourRatePoint;

  TourModel({
    required this.tourId,
    required this.tourName,
    this.tourImgPath = "assets/images/blank-profile-picture.png",
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
        // tourImgPath: json['img'],
        convinces: (json['convinces'] as List<dynamic>)
            .map<String>((convince) => convince.toString())
            .toList(),
        tourType: (json['type'] as List<dynamic>)
            .map<String>((type) => type)
            .toList(),
        tourPrice: json['price'].toDouble(),
        tourRatePoint: json['point'].toDouble(),
      );
      return tour;
    } catch (error) {
      throw Exception(
          'Error on tourId: ${json['id']} and name: ${json['name']}');
    }
  }
}
