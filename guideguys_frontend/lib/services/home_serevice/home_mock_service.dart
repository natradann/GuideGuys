import 'package:guideguys/modules/home/home_model.dart';
import 'package:guideguys/services/home_serevice/home_service_interface.dart';

import '../../models/tour_card_lg_model.dart';

class HomeMockService implements HomeServiceInterface {
  @override
  Future<List<GuideModel>> fetchAllGuides() async {
    List<GuideModel> allGuides = [
      GuideModel(
        guideId: '1',
        guideName: 'Meaowguide',
        guideImgPath: "assets/images/blank-profile-picture.png",
        convinces: ["กรุงเทพ", "สมุทปราการ", "กรุงเทพ", "สมุทปราการ"],
        languages: ['ไทย'],
        ratePoint: 5,
      ),
      GuideModel(
        guideId: '1',
        guideName: 'Jeedguide',
        guideImgPath: "assets/images/blank-profile-picture.png",
        convinces: ["เชียงใหม่", "พะเยา"],
        languages: ['ไทย'],
        ratePoint: 4,
      ),
      GuideModel(
        guideId: '1',
        guideName: 'Gaabguide',
        guideImgPath: "assets/images/blank-profile-picture.png",
        convinces: ["ภูเก็ต", "พังงา"],
        languages: ['ไทย'],
        ratePoint: 3,
      )
    ];
    
    return allGuides;
  }

  @override
  Future<List<TourCardLGModel>> fetchAllTours() async {
    List<TourCardLGModel> allTours = [
      TourCardLGModel(
        tourId: '1',
        tourName: 'Ride bike around the world',
        tourImgPath: "assets/images/blank-profile-picture.png",
        price: 1000,
        convinces: [
          "กรุงเทพ",
          "นนทบุรี",
          "สระบุรี",
          "สระแก้ว",
          "อ่างทอง",
          "เลย",
        ],
        vehicles: ["รถส่วนตัว"],
        type: ["Food tour"],
        languages: ["อังกฤษ", "ไทย"],
        ratePoint: 4,
      ),
      TourCardLGModel(
        tourId: '2',
        tourName: 'Ride bus around the world',
        tourImgPath: "assets/images/blank-profile-picture.png",
        price: 500,
        convinces: ["กรุงเทพ", "ตราด"],
        vehicles: ["รถส่วนตัว"],
        type: ["Food tour"],
        languages: ["อังกฤษ", "จีน"],
        ratePoint: 4,
      ),
      TourCardLGModel(
        tourId: '3',
        tourName: 'Ride boke around the country',
        tourImgPath: "assets/images/blank-profile-picture.png",
        price: 2000,
        convinces: ["เลย", "นนทบุรี"],
        vehicles: ["รถส่วนตัว"],
        type: ["Food tour"],
        languages: ["อังกฤษ", "ไทย", "จีน"],
        ratePoint: 4,
      ),
    ];

    return allTours;
  }
}
