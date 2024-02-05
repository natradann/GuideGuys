import 'package:guideguys/models/tour_card_lg_model.dart';
import 'package:guideguys/modules/home/home_model.dart';
// import 'package:guideguys/modules/find_all_list/find_all_list_model.dart';

class FindAllListViewModel {
  late List<GuideModel> allGuides;
  late List<TourCardLGModel> allTours;
  List<String> tagList = [];
  List<String> typeTourList = [];
  List<String> typeVehicleList = [];

  getData(
      {List<TourCardLGModel>? allToursData,
      List<GuideModel>? allGuidesData}) async {
    try {
      if (allToursData != null) {
        allTours = List.from(allToursData);
      } else if (allGuidesData != null){
        allGuides = List.from(allGuidesData);
      }
    } catch (_) {
      rethrow;
    }
  }

  List<TourCardLGModel> filterTours() {
    List<TourCardLGModel> tagListFiltered = [];
    List<TourCardLGModel> typeTourListFiltered = [];
    List<TourCardLGModel> typeVehicleListFiltered = [];
    if (tagList.isEmpty && typeTourList.isEmpty && typeVehicleList.isEmpty) {
      return allTours;
    } else if (tagList.isNotEmpty) {
      tagListFiltered = tagList
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

                return (isTourNameMatch ||
                    areConvincesMatch ||
                    arelanguagesMatch ||
                    areTourTypesMatch ||
                    areVehiclesMatch);
              }))
          .toList();
    } else if (typeTourList.isNotEmpty) {
      typeTourListFiltered = typeTourList
          .expand((typeText) => allTours.where((tour) {
                bool areTourTypesMatch = tour.type.any((tourType) =>
                    tourType.toLowerCase().contains(typeText.toLowerCase()));

                return areTourTypesMatch;
              }))
          .toList();
    } else if (typeVehicleList.isNotEmpty) {
      typeVehicleListFiltered = typeVehicleList
          .expand((vehicleText) => allTours.where((tour) {
                bool areVehiclesMatch = tour.vehicles.any((vehicle) =>
                    vehicle.toLowerCase().contains(vehicleText.toLowerCase()));

                return areVehiclesMatch;
              }))
          .toList();
    }

    return {
      ...tagListFiltered,
      ...typeTourListFiltered,
      ...typeVehicleListFiltered
    }.toSet().toList();
  }

  List<GuideModel> filterGuides() {
    List<GuideModel> tagListFiltered = [];
    List<GuideModel> typeTourListFiltered = [];
    List<GuideModel> typeVehicleListFiltered = [];
    if (tagList.isEmpty && typeTourList.isEmpty && typeVehicleList.isEmpty) {
      return allGuides;
    } else if (tagList.isNotEmpty) {
      tagListFiltered = tagList
          .expand((tagText) => allGuides.where((guide) {
                bool isGuideNameMatch = guide.guideName
                    .toLowerCase()
                    .contains(tagText.toLowerCase());

                bool areConvincesMatch = guide.convinces.any((convince) =>
                    convince.toLowerCase().contains(tagText.toLowerCase()));

                bool arelanguagesMatch = guide.languages.any((language) =>
                    language.toLowerCase().contains(tagText.toLowerCase()));

                bool areTourNamesMatch = guide.tourNames.any((tourName) =>
                    tourName.toLowerCase().contains(tagText.toLowerCase()));

                bool areTourTypesMatch = guide.tourTypes.any((tourType) =>
                    tourType.toLowerCase().contains(tagText.toLowerCase()));

                bool areVehiclesMatch = guide.allVehicles.any((vehicle) =>
                    vehicle.toLowerCase().contains(tagText.toLowerCase()));

                return isGuideNameMatch ||
                    areConvincesMatch ||
                    arelanguagesMatch ||
                    areTourNamesMatch ||
                    areTourTypesMatch ||
                    areVehiclesMatch;
              }))
          .toSet()
          .toList();
    } else if (typeTourList.isNotEmpty) {
      typeTourListFiltered = typeTourList
          .expand((typeText) => allGuides.where((tour) {
                bool areTourTypesMatch = tour.tourTypes.any((tourType) =>
                    tourType.toLowerCase().contains(typeText.toLowerCase()));

                return areTourTypesMatch;
              }))
          .toList();
    } else if (typeVehicleList.isNotEmpty) {
      typeVehicleListFiltered = typeVehicleList
          .expand((vehicleText) => allGuides.where((tour) {
                bool areVehiclesMatch = tour.allVehicles.any((vehicle) =>
                    vehicle.toLowerCase().contains(vehicleText.toLowerCase()));

                return areVehiclesMatch;
              }))
          .toList();
    }

    return {
      ...tagListFiltered,
      ...typeTourListFiltered,
      ...typeVehicleListFiltered
    }.toSet().toList();
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
