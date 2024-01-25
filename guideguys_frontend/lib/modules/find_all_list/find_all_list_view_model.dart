
import 'package:guideguys/models/tour_card_lg_model.dart';
import 'package:guideguys/modules/home/home_model.dart';
// import 'package:guideguys/modules/find_all_list/find_all_list_model.dart';

class FindAllListViewModel {
  // late List<GuideModel> allGuides;
  // late List<TourModel> allTours;
  List<String> tagList = [];

  // Future<bool> fetchAllInfo({required List<GuideModel> guides, required List<TourModel> tours}) async {
  //   try {
  //     allGuides = guides;

  //     allTours = tours;
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  List<TourCardLGModel> filterTours({required List<TourCardLGModel> allTours}) {
    if (tagList.isEmpty) {
      return allTours;
    }
    List<TourCardLGModel> tourFiltered = tagList
        .expand((tagText) => allTours.where((tour) {
              bool isTourNameMatch =
                  tour.tourName.toLowerCase().contains(tagText.toLowerCase());

              bool areConvincesMatch = tour.convinces.any((convince) =>
                  convince.toLowerCase().contains(tagText.toLowerCase()));

              bool arelanguagesMatch = tour.languages.any((language) =>
                  language.toLowerCase().contains(tagText.toLowerCase()));

              bool areTourTypesMatch = tour.type.any((tourType) =>
                  tourType.toLowerCase().contains(tagText.toLowerCase()));

              bool areVehiclesMatch = tour.vehicles.any((vehicle) =>
                  vehicle.toLowerCase().contains(tagText.toLowerCase()));
              return isTourNameMatch ||
                  areConvincesMatch ||
                  arelanguagesMatch ||
                  areTourTypesMatch ||
                  areVehiclesMatch;
            }))
        .toList();
    return tourFiltered;
  }

  List<GuideModel> filterGuides({required List<GuideModel> allGuides}) {
    if (tagList.isEmpty) {
      return allGuides;
    }
    List<GuideModel> guideFiltered = tagList
        .expand((tagText) => allGuides.where((guide) {
              bool isGuideNameMatch =
                  guide.guideName.toLowerCase().contains(tagText.toLowerCase());

              bool areConvincesMatch = guide.convinces.any((convince) =>
                  convince.toLowerCase().contains(tagText.toLowerCase()));

              bool arelanguagesMatch = guide.languages.any((language) =>
                  language.toLowerCase().contains(tagText.toLowerCase()));

              return isGuideNameMatch || areConvincesMatch || arelanguagesMatch;
            }))
        .toSet()
        .toList();
    return guideFiltered;
  }

  Future<bool> addTag({required String newTag}) async {
    try {
      tagList.add(newTag);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> onUserDeleteTag({required String tagName}) async {
    try {
      tagList.remove(tagName);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  List<TourModel> allToursMock = [
    TourModel(
      tourId: '1',
      tourName: 'Ride bike around the world',
      tourImgPath: "assets/images/blank-profile-picture.png",
      price: 1000,
      convinces: ["กรุงเทพ", "นนบุรี"],
      vehicles: ["รถส่วนตัว"],
      type: ["Food tour"],
      languages: ["อังกฤษ", "ไทย"],
      ratePoint: 4,
    ),
    TourModel(
      tourId: '1',
      tourName: 'Ride bus around the world',
      tourImgPath: "assets/images/blank-profile-picture.png",
      price: 500,
      convinces: ["กรุงเทพ", "นนบุรี"],
      vehicles: ["รถส่วนตัว"],
      type: ["Food tour"],
      languages: ["อังกฤษ", "ไทย"],
      ratePoint: 4,
    ),
    TourModel(
      tourId: '1',
      tourName: 'Ride bike around the country',
      tourImgPath: "assets/images/blank-profile-picture.png",
      price: 2000,
      convinces: ["กรุงเทพ", "นนบุรี"],
      vehicles: ["รถส่วนตัว"],
      type: ["Food tour"],
      languages: ["อังกฤษ", "ไทย"],
      ratePoint: 4,
    ),
  ];
}
